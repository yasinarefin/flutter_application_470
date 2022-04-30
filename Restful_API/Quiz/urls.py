from django.urls import path, include
from Quiz import views
urlpatterns = [
    path('view/<str:cur_status>/', views.show_quiz),
    path('questions/', views.questions),
    path('answers/', views.answers),
    path('submit_ans/', views.submit_ans),
    path('save_ans/', views.save_ans),
    path('participation_status/', views.participation_status)
]