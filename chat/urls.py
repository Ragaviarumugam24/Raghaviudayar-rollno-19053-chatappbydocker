from django.urls import path
from . import views

urlpatterns = [
    path('home/', views.home, name='home'),  # 👈 new
    path('<str:room_name>/', views.room, name='room'),
]