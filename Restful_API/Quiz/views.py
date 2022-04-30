from rest_framework.response import  Response
from rest_framework.decorators import api_view
from rest_framework import status
from datetime import datetime
import json
from Quiz.serializers import *
from Quiz.models import Quiz, Question, Participation
from django.utils import timezone
from Authentication import security_tools
from decimal import *
from Quiz.controllers import *

# /quiz/view/<str:status>
@api_view(['GET'])
def show_quiz(request, cur_status):
    token = request.headers['Authorization']
    if security_tools.authenticate(token) == None:
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    controller = ShowQuizController()
    
    if request.method =='GET':
        if cur_status == 'upcoming': # get list of upcoming quizzes
            return Response(controller.get_upcoming_quizzes(), status=status.HTTP_200_OK)
        elif cur_status == 'running':
            return Response(controller.get_running_quizzes(), status=status.HTTP_200_OK)
        elif cur_status == 'all':
            return Response(controller.get_all_quizzes(), status=status.HTTP_200_OK)
        elif cur_status == 'ended':
            return Response(controller.get_ended_quizzes(), status=status.HTTP_200_OK)
        else:
            return Response({'error' : 'invalid query'}, status=status.HTTP_400_BAD_REQUEST)

#/quiz/questions/
# get list of questions with quiz id
# include header Authorization and QuizID with the id of the  quiz
@api_view(['GET'])
def questions(request):
    token = request.headers['Authorization']
    if security_tools.authenticate(token) == None:
        return Response(status=status.HTTP_401_UNAUTHORIZED)
    quiz_id = request.headers['QuizID']

    controller = QuestionController(quiz_id)
    try:
        # check if quiz has started or not.
        if controller.get_status() == 'upcoming':
            return Response({'error': 'quiz has not started  yet!'}, status=status.HTTP_403_FORBIDDEN)

        return  Response(controller.get_question_data(), status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

# get quiz answer  after the  quiz is finished
# include header QuizID with the id of the  quiz
@api_view(['GET'])
def answers(request):
    token = request.headers['Authorization']
    if security_tools.authenticate(token) == None:
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    quiz_id = request.headers['QuizID']
    controller = AnswerController(quiz_id)
    try:
        if controller.get_status() != 'ended':
            return Response({'error':'answers are not published yet!'}, 
            status=status.HTTP_203_NON_AUTHORITATIVE_INFORMATION)
        return  Response(controller.get_answer_data(), status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_400_BAD_REQUEST)
'''  
{
    "quiz_id": "amar_quiz1234r",
    "question_no":1
    "answer":[]
}
'''
@api_view(['POST'])
def save_ans(request):
    if request.method == 'POST':
        token = request.headers['Authorization']
        user = security_tools.authenticate(token)
        if user == None:
            return Response({'message':'not logged in!'},status=status.HTTP_401_UNAUTHORIZED)

        body = request.data
        quiz_id = body['quiz_id']
        question_no = body['question_no']
        answer = body['answer'] # answer user submitted
        
        vss = SaveSubmitController(user, quiz_id, question_no, answer)

        if vss.check_if_running() == False:
            return  Response({'message':'quiz is not running'}, status=status.HTTP_410_GONE)
        
        vss.create_participation()
        if vss.check_question_no() == False:
            return Response({'message':'out of range'}, status=status.HTTP_404_NOT_FOUND)

        if vss.check_if_submitted() == True:
            return Response({'message':'already submitted'}, status=status.HTTP_406_NOT_ACCEPTABLE)
        
        if vss.validate_answer() == False:
            return Response({'message':'invalid type'}, status=status.HTTP_400_BAD_REQUEST)

        vss.save_ans()
        return Response({'message':'submitted'}, status=status.HTTP_200_OK)


@api_view(['POST'])
def submit_ans(request):
    
    if request.method == 'POST':
        token = request.headers['Authorization']
        user = security_tools.authenticate(token)
        if user == None:
            return Response({'message':'not logged in!'},status=status.HTTP_401_UNAUTHORIZED)

        body = request.data
        quiz_id = body['quiz_id']
        question_no = body['question_no']
        answer = body['answer'] # answer user submitted
        
        vss = SaveSubmitController(user, quiz_id, question_no, answer)

        if vss.check_if_running() == False:
            return  Response({'message':'quiz is not running'}, status=status.HTTP_410_GONE)
        
        vss.create_participation()
        if vss.check_question_no() == False:
            return Response({'message':'out of range'}, status=status.HTTP_404_NOT_FOUND)
        
        if vss.check_if_submitted() == True:
            return Response({'message':'already submitted'}, status=status.HTTP_406_NOT_ACCEPTABLE)

        if vss.validate_answer() == False:
            return Response({'message':'invalid type'}, status=status.HTTP_400_BAD_REQUEST)

        vss.save_ans()
        vss.submit_ans()

        return Response({'message':'submitted'}, status=status.HTTP_200_OK)

# get participation status 
# include header Authorization and QuizID 

@api_view(['GET'])
def participation_status(request):
    token = request.headers['Authorization']
    user = security_tools.authenticate(token)
    if user == None:
        return Response({'message':'not logged in!'},status=status.HTTP_401_UNAUTHORIZED)

    quiz_id = request.headers['QuizID']
    controller = ParticipationStatusController(quiz_id, user)
    try:
        return Response(controller.get_participation_data(), status= status.HTTP_200_OK)
    except:
        pass
    return Response({'message':'invalid data'}, status= status.HTTP_400_BAD_REQUEST)
