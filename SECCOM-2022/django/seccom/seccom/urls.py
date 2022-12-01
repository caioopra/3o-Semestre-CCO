"""seccom URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path("primeiraurl/", views.primeiraurl),  # path, view
    path("meunome/", views.meunome),
    path("id/<int:id>", views.minhaid),   # vai ter link .../id/inteiro  e chama o views.id
    path("primeiratela/", views.primeiratela),
    path("estudante/", views.estudante),
    path("estudante/<str:name>", views.estudanteview)
]
