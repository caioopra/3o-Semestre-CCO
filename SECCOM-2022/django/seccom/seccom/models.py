from django.db import models


# classe modelo do banco de dados do Django
class Student(models.Model):
    # SQL consegue definir propriedades
    name       = models.CharField(max_length=80, null=False)
    birthdate  = models.DateField(null=False)   # nao pode ser nulo
    enter_year = models.IntegerField(null=False)
    created_on = models.DateTimeField(auto_now_add=True)    # não precisa dizer esse valor, quando cria, preenche com data
