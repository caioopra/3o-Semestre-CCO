# visualizção para os links
from django.http import HttpResponse
from django.shortcuts import render, redirect
from .models import Student

def primeiraurl(request):
    return HttpResponse('oi')  # protocolo HTTP para comunicação web


# capturando variáveis com request (coleção de informação de quem faz requisição)
def meunome(request):
    name = request.GET.get("name", "Desconhecido")  # "variavel", "Default"
    sobrenome = request.GET.get("sobrenome", "")    # usa GET porque é o que o browser está mandando
    
    return HttpResponse(f"{name} {sobrenome}")


# forma diferente de receber parametro
# para paginação, por exemplo, serveria melhor (1 parametro apenas)
def minhaid(request, id):           # URLconf
    return HttpResponse(f"{id}")


def primeiratela(request):
    nome = request.GET.get("nome", "desconhecido")
    # variáveis para usar dentro da pagina
    context = {
        "nome": nome,
        "amigos": [
            "Joao",
            "Pedro",
            "Caio"
        ],
        "animals": {
            "dog": "Cachorro",
            "cat": "Gato"
        }
    }
    
    # dados passados pelo context
    # render para mostrar um HTML na tela (renderizar)
    return render(request, "primeiratela.html", context)


def estudante(request):
    if (request.method == "POST"):
        # no POST é o mesmo name dado no HTML
        name = request.POST.get("name")
        birthdate = request.POST.get("birthdate")
        enteryear = int(request.POST.get("enteryear"))
    
        student = Student(name=name, birthdate=birthdate, enter_year=enteryear)
        student.save()  # abstrai necessidade de saber SQL
    
        return redirect(f"/estudante/{name}")       # vai para outra página
    
    return render(request, "estudante.html")

def estudanteview(request, name):
    student = Student.objects.get(name=name)
    return HttpResponse(f"{student.name} {student.birthdate} {student.enter_year}")
