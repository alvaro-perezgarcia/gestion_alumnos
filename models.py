from flask_login import UserMixin
from sqlalchemy.orm import relationship
from werkzeug.security import generate_password_hash, check_password_hash
from flask import url_for
from slugify import slugify
from sqlalchemy.exc import IntegrityError
from app import db


class Alumnado(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    id_alumnos = db.Column(db.Integer(), db.ForeignKey('alumnos.id', ondelete='CASCADE'), nullable=False)
    id_curso = db.Column(db.Integer(), db.ForeignKey('curso.id', ondelete='CASCADE'), nullable=False)
    id_division = db.Column(db.Integer(), db.ForeignKey('division.id', ondelete='CASCADE'), nullable=False)
    anio = db.Column(db.Integer(), nullable=False)
    alumnos = relationship("Alumnos",back_populates="alumnado")
    
    def save(self):
        db.session.add(self)
        db.session.commit()
    
    def get_all():
        return Alumnado.query.all()

    
    def get_by_id(id):
        return Alumnado.query.get(id)
    

class Alumnos(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    apellido = db.Column(db.String(50), nullable=False) 
    nombre = db.Column(db.String(50), nullable=False) 
    dni = db.Column(db.Integer(), nullable=False)
    domicilio = db.Column(db.String(70), nullable=True) #ver si no poniendolo directamente es lo mismo que el nullable=True
    id_localidad = db.Column(db.Integer(), db.ForeignKey('localidad.id', ondelete='CASCADE'), nullable=False)
    id_pais_nac = db.Column(db.Integer(), db.ForeignKey('pais_nac.id', ondelete='CASCADE'), nullable=False)
    id_sexo = db.Column(db.Integer(), db.ForeignKey('sexo.id', ondelete='CASCADE'), nullable=True)
    activo = db.Column(db.Integer(), nullable=False) #ver porque en la BD figura como Binary
    #agregado de contacto
    nombre_apellido_cont = db.Column(db.String(100), nullable=False) 
    direccion_cont = db.Column(db.String(100), nullable=True) 
    telefono_cont = db.Column(db.String(100), nullable=True) 
    correo_electronico_cont = db.Column(db.String(70), nullable=False) #este tendria que se Null=False para que este si o si porque se usa para ingresar
    relacion_cont = db.Column(db.String(100), nullable=True)
    alumnado = relationship("Alumnado", back_populates="alumnos")

    def get_all():
        return Alumnos.query.all()
    
    def save(self):
        db.session.add(self)
        db.session.commit()

    def alumnos_query(): #lucas
        return Alumnos.query

    def get_by_id(id):
        return Alumnos.query.get(id)   
    
    def __repr__(self):
        return '{}'.format(self.apellido + " " + self.nombre + " - DNI: " + self.dni)


class Concepto(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    nombre= db.Column(db.String(50), nullable=False) 

    def concepto_query(): #new
        return Concepto.query
        

class Curso(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    nombre = db.Column(db.String(25), nullable=False)
    
    def curso_query(): #new
        return Curso.query
    
    def get_by_id(id):
        return Curso.query.get(id)

class Devengado(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    id_alumnado = db.Column(db.Integer(), db.ForeignKey('alumnado.id', ondelete='CASCADE'), nullable=False)
    id_concepto = db.Column(db.Integer(), db.ForeignKey('concepto.id', ondelete='CASCADE'), nullable=False)
    monto = db.Column(db.Integer(), nullable=False)
    pagado = db.Column(db.Integer(), nullable=True)

    def devengado_query():
        return Devengado.query

    def save(self):
        if not self.id:
            db.session.add(self)

        saved = False
        while not saved:
            db.session.commit()
            saved = True
    
    def get_all():
        return Devengado.query.all()

    def get_all_adeudados():
        return Devengado.query.filter(Devengado.pagado == 0).order_by(Devengado.id_alumnado.asc()).all()
    
    def get_by_id(id):
        return Devengado.query.get(id)

    def get_concepto(id):
        return Concepto.query.get(id)
      

class Division(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    nombre = db.Column(db.String(1), nullable=False) 

    def division_query():
        return Division.query
    
    def get_by_id(id):
        return Division.query.get(id) 


class Localidad(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    id_provincia = db.Column(db.Integer(), db.ForeignKey('provincia.id', ondelete='CASCADE'), nullable=False)

    def localidad_query():
        return Localidad.query    


class Pais_nac(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)

    def pais_nac_query(): #new
        return Pais_nac.query  

class Sexo(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    inicial = db.Column(db.String(1), nullable=False)
    descripcion = db.Column(db.String(25), nullable=False)

    def get_all():
        return Sexo.query.all()
    
    def sexo_query(): 
        return Sexo.query

class Alumno_pagos:
    def __init__(self, alumno, pago_id, concepto, monto):
        self.alumno = alumno
        self.pago_id = pago_id
        self.concepto = concepto    
        self.monto = monto

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(256), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)

    def __init__(self, name, email):
        self.name = name
        self.email = email

    def __repr__(self):
        return f'<User {self.email}>'

    def set_password(self):
        self.password = generate_password_hash(self.password)

    def check_password(self, password):
        return check_password_hash(self.password, password)

    def save(self):
        if not self.id:
            db.session.add(self)
        db.session.commit()

    def delete(self):
        db.session.delete(self)
        db.session.commit()

    @staticmethod
    def get_by_id(id):
        return User.query.get(id)

    @staticmethod
    def get_by_email(email):
        user = User.query.filter_by(email=email).first()
        user.set_password()
        return user

    @staticmethod
    def get_all():
        return User.query.all()
        
        




