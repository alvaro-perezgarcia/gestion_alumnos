from flask import Flask, render_template, redirect,request, url_for
from flask_sqlalchemy import SQLAlchemy #forms
from flask_wtf import FlaskForm #forms
from wtforms_sqlalchemy.fields import QuerySelectField #forms
from wtforms import StringField, SubmitField, PasswordField, TextAreaField, BooleanField
from wtforms.validators import DataRequired, Length

from flask_login import LoginManager, logout_user, current_user, login_user, login_required
from werkzeug.urls import url_parse
from forms import *
from models import *

app = Flask(__name__)


app.config['SECRET_KEY'] = '7110c8ae51a4b5af97be6534caef90e4bb9bdcb3380af008f90b23a5d1616bf319bc298105da20fe'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://BD2021:BD2021itec@143.198.156.171/apg_lp2'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

login_manager = LoginManager(app)
login_manager.login_view = "login"
db = SQLAlchemy(app)

@app.route('/')
def raiz():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('index'))  
    form = LoginForm()
    if form.validate_on_submit():
        user = User.get_by_email(form.email.data)
        if user is None:
            return render_template('login.html', form=form)
        else:    
            if user is not None and user.check_password(form.password.data):
                login_user(user, remember=form.remember_me.data)
                next_page = request.args.get('next')
                if not next_page or url_parse(next_page).netloc != '':
                    next_page = url_for('index')
                return redirect(next_page)
    return render_template('login.html', form=form)

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))

@login_manager.user_loader
def load_user(user_id):
    return User.get_by_id(int(user_id))

@app.route("/index", methods = ['GET','POST'])
@login_required
def index():
    return render_template("index.html")

@app.route("/carga_alumno", methods = ['GET','POST'])
@login_required
def cargaAlumno():
    form = AlumnosForm()
    if form.validate_on_submit():
        apellido = form.apellido.data
        nombre = form.nombre.data
        dni = form.dni.data
        domicilio = form.domicilio.data
        localidad = form.localidad.data
        pais_nac = form.pais_nac.data
        sexo =  form.sexo.data
        #DATOS DE CONTACTO
        nombre_apellido_cont = form.nombre_apellido_cont.data
        direccion_cont = form.direccion_cont.data
        telefono_cont = form.telefono_cont.data
        correo_electronico_cont = form.correo_electronico_cont.data
        relacion_cont = form.relacion_cont.data
       
        nuevoAlumno = Alumnos(apellido=apellido, nombre=nombre, dni=dni, domicilio=domicilio, id_localidad=localidad.id, id_pais_nac=pais_nac.id, id_sexo=sexo.id, activo=1,nombre_apellido_cont=nombre_apellido_cont,direccion_cont=direccion_cont,telefono_cont=telefono_cont,correo_electronico_cont=correo_electronico_cont,relacion_cont=relacion_cont)
        nuevoAlumno.save()
        return render_template("op_exitosa.html", form=form)  
    return render_template("carga_alumno.html", form=form)

@app.route("/alumnado", methods = ['GET','POST'])
@login_required
def alumnado():
    form = AlumnadoForm()
    if form.validate_on_submit():
        alumno = form.alumno.data
        curso = form.curso.data
        division = form.division.data
        anio = form.anio.data

        nuevoRegistro = Alumnado(id_alumnos=alumno.id, id_curso=curso.id, id_division=division.id, anio=anio)
        nuevoRegistro.save()
        return render_template("op_exitosa.html", form=form)   
    return render_template("alumnado.html", form=form)   


@app.route("/devengar", methods = ['GET','POST'])
@login_required
def devengar():
    form = DevengadoForm()
    rows = db.session.query(Alumnado).count()
    if form.validate_on_submit():
        for i in range(rows):
            alumnado = Alumnado.get_all()[i]
            concepto = form.concepto.data
            monto = form.monto.data
            nuevoDevengado = Devengado(id_alumnado = alumnado.id, id_concepto=concepto.id, monto=monto, pagado=0)
            nuevoDevengado.save()
        return render_template("op_exitosa.html", form=form)
    return render_template("devengar.html", form=form)
    
@app.route("/pagos", methods = ['GET','POST'])
@login_required
def listar_devengado():
    pagos = Devengado.get_all_adeudados()
    alumnosMorosos = []
    for pago in pagos:
        concepto = Devengado.get_concepto(pago.id_concepto)
        alumnado = Alumnado.get_by_id(pago.id_alumnado)
        alumno = Alumnos.get_by_id(alumnado.id_alumnos)
        alumno_pagos = Alumno_pagos(alumno, pago.id, concepto.nombre, pago.monto )#
        alumnosMorosos.append(alumno_pagos)  
    return render_template("pago.html", alumnosMorosos=alumnosMorosos)

#anota como pagado a un alumno en la tabla devengado
@app.route("/pagar/<int:pago_id>/", methods=['GET', 'POST'])
@login_required
def update_devengado(pago_id):
    pago = Devengado.query.filter_by(id=pago_id).first()
    pago.pagado=1
    db.session.merge(pago)
    db.session.commit()  
    return render_template("pagar.html", pago=pago)

#editar alumnos
@app.route("/alumnos", methods = ['GET','POST'])
@login_required
def listar_alumnos():
    chicos = Alumnos.get_all()
    return render_template("alumnos.html", chicos=chicos)

# actualiza los datos del alumno
@app.route("/editar_alumno/<int:alum_id>/", methods=['GET', 'POST'])
@login_required
def update_alumnos(alum_id):
    chico = Alumnos.query.filter_by(id=alum_id).first()
    form = AlumnosForm(obj=chico)
    if form.validate_on_submit():
        chico.apellido = form.apellido.data
        chico.nombre = form.nombre.data
        chico.dni = form.dni.data
        chico.domicilio = form.domicilio.data
        chico.localidad = form.localidad.data
        chico.pais_nac = form.pais_nac.data
        chico.sexo =  form.sexo.data
        #DATOS DE CONTACTO
        chico.nombre_apellido_cont = form.nombre_apellido_cont.data
        chico.direccion_cont = form.direccion_cont.data
        chico.telefono_cont = form.telefono_cont.data
        chico.correo_electronico_cont = form.correo_electronico_cont.data
        chico.relacion_cont = form.relacion_cont.data
        db.session.merge(chico)
        db.session.commit() 
        return render_template("op_exitosa.html", form=form)    
    return render_template("editar_alumno.html", chico=chico, form=form)

@app.route("/op_exitosa")
@login_required
def op_exitosa():
    return render_template("op_exitosa.html")

#consultar alumnado
@app.route("/matriculados", methods = ['GET','POST'])
@login_required
def listar_matriculados():
    matris = Alumnado.get_all()
    listaMatric =[]
    for matri in matris:
        alumno = Alumnos.get_by_id(matri.id_alumnos)
        curso = Curso.get_by_id(matri.id_curso)
        division = Division.get_by_id(matri.id_division)
        anio=matri.anio
        x = alumno.nombre +" "+alumno.apellido,curso.nombre,division.nombre,anio, alumno.dni 
        listaMatric.append(x)
    return render_template("matriculados.html", listaMatric=listaMatric)

@app.errorhandler(404)
@login_required
def error_404_handler(e):
    return render_template('error.html'), 404

@app.errorhandler(500)
@login_required
def base_error_handler(e):
    return render_template('error.html'), 500

if __name__ == '__main__':
    app.run(debug=False)





