
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, PasswordField, TextAreaField, BooleanField, DateField, IntegerField
from wtforms.fields.core import DateTimeField, SelectField
from wtforms.validators import DataRequired, Email, Length
from wtforms_sqlalchemy.fields import QuerySelectField
from models import *


class PagoForm(FlaskForm):
    concepto = QuerySelectField(query_factory=Concepto.concepto_query, allow_blank=True, get_label='nombre')
    fecha_pago = DateField(label = None,validators=None, format='%Y-%m-%d')
    monto = IntegerField('Monto', validators=[DataRequired(), Length(max=10)])
    submit = SubmitField('Registrar pago')

class DevengadoForm(FlaskForm):
    concepto = QuerySelectField(query_factory=Concepto.concepto_query, allow_blank=True, get_label='nombre')
    monto = IntegerField('Monto', validators=[DataRequired()])
    submit = SubmitField('Devengar')

class LoginForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember_me = BooleanField('Recuérdame')
    submit = SubmitField('Login')

class AlumnosForm(FlaskForm):
    apellido = StringField('Apellido', validators=[DataRequired(), Length(max=128)])
    nombre = StringField('Nombre', validators=[DataRequired(), Length(max=128)])
    dni = StringField('DNI', validators=[DataRequired()])
    domicilio = StringField('Domicilio', validators=[Length(max=128)])
    localidad =  QuerySelectField(query_factory=Localidad.localidad_query, allow_blank=True, get_label='nombre')
    pais_nac =  QuerySelectField(query_factory=Pais_nac.pais_nac_query, allow_blank=True, get_label='nombre')
    sexo =  QuerySelectField(query_factory=Sexo.sexo_query, allow_blank=True, get_label='descripcion')
    #DATOS DEL CONTACTO
    nombre_apellido_cont = StringField('Nombre y Apellido', validators=[DataRequired(), Length(max=128)])
    direccion_cont = StringField('Domicilio', validators=[DataRequired(), Length(max=128)])
    telefono_cont = StringField('Teléfono', validators=[DataRequired(), Length(max=18)])
    correo_electronico_cont = StringField('Email', validators=[DataRequired(), Email()])
    relacion_cont = StringField('Relacion', validators=[DataRequired(), Length(max=50)])
    submit = SubmitField('Registrar')

class AlumnadoForm(FlaskForm):
    alumno =  QuerySelectField(query_factory=Alumnos.alumnos_query, allow_blank=True)
    curso =  QuerySelectField(query_factory=Curso.curso_query, allow_blank=True, get_label='nombre')
    division =  QuerySelectField(query_factory=Division.division_query, allow_blank=True, get_label='nombre')
    anio = IntegerField('Año', validators=[DataRequired()])
    submit = SubmitField('Registrar')

