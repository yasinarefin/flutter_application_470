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

class ShowQuizController():
    def get_upcoming_quizzes(self): # return serialized upcoming quiz data
        quizzes = Quiz.objects.filter(start_time__gte=timezone.now(), end_time__gte = timezone.now())
        q_ser = QuizSerializer(quizzes, many=True)
        return q_ser.data 

    def get_running_quizzes(self): # return serialized upcoming quiz data
        quizzes = Quiz.objects.filter(start_time__lte=timezone.now(), end_time__gte = timezone.now())
        q_ser = QuizSerializer(quizzes, many=True)
        return q_ser.data 
    
    def get_all_quizzes(self): # return serialized upcoming quiz data
        quizzes = Quiz.objects.all()
        q_ser = QuizSerializer(quizzes, many=True)
        return q_ser.data 
    def get_ended_quizzes(self): # return serialized upcoming quiz data
        quizzes = Quiz.objects.filter(end_time__lt = timezone.now())
        q_ser = QuizSerializer(quizzes, many=True)
        return q_ser.data 


class QuestionController():

    def __init__(self, quiz_id):
        self.quiz_obj = Quiz.objects.get(quiz_id=quiz_id)

    def get_status(self):
        self.quiz_obj.get_status

    def get_question_data(self):
        question = Question.objects.get(quiz=self.quiz_obj)
        question_ser = QuestionSerializer(question)
        return question_ser.data



class AnswerController():

    def __init__(self, quiz_id):
        self.quiz_obj = Quiz.objects.get(quiz_id=quiz_id)

    def get_status(self):
        self.quiz_obj.get_status

    def get_answer_data(self):
        question = Question.objects.get(quiz=quiz)
        question_ser = AnswerSerializer(question)
        return question_ser.data


class SaveSubmitController():
    def __init__(self, user, quiz_id, question_no, answer):
        self.user = user
        self.quiz_obj = Quiz.objects.get(quiz_id=quiz_id)
        self.questions = Question.objects.get(quiz=quiz_id)
        self.answer = answer
        self.question_no = question_no
        self.q_count = self.questions.question_count
        self.question = self.questions.questions[question_no]
        self.options = self.question['options']
        self.points = self.question['score']
    
    def check_question_no(self): # if submitted question no is out of range
        if self.question_no >= self.q_count:
            return False
        return True

    def check_if_running(self):
        if self.quiz_obj.get_status != 'running':
            return False
        return True

    

    def validate_answer(self):
        if self.question['type'] == 'sc':
            ok = all(isinstance(x, int) for x in self.answer) # for single choice everything in the answer array must be a integer
            ok2 = max(self.answer) < len(self.options) and min(self.answer) >= 0 # index  of option < number of option
            return ok and ok2
                
        elif self.question['type'] =='mc':
            ok = all(isinstance(x, int) for x in self.answer)
            ok2 = max(self.answer) < len(self.options) and min(self.answer) >= 0
            return ok and ok2

        elif self.question['type'] == 'inp':
            ok = all(isinstance(x, str) for x in self.answer)
            return ok 
    
    def create_participation(self):
        # if there is no participation already
        try:
            Participation.objects.get(user=self.user, quiz=self.quiz_obj)
        except:
            Participation.objects.create(user=self.user, quiz=self.quiz_obj,
            answers=[[] for i in range(self.q_count)], saved_answers=[[] for i in range(self.q_count)], score=0)
        self.participation = participation = Participation.objects.get(user=self.user, quiz=self.quiz_obj)
    
    def check_if_submitted(self):
        if len(self.participation.answers[self.question_no]) != 0:
            return True
        return False


    def submit_ans(self):
        user_points = 0
        corr_answer = self.questions.answers[self.question_no]
        # print(corr_answer)
        # print(answer)
        # print(points)
        if self.question['type'] == 'sc':
            if len(corr_answer) == len(self.answer) and set(corr_answer) == set(self.answer):
                user_points += self.points
        
        if self.question['type'] == 'mc':
            wrong_sel = 0
            for i in self.answer:
                print(i)
                if i not in corr_answer:
                    wrong_sel += 1
            user_points += Decimal(self.points / 2**wrong_sel)

        if self.question['type'] == 'inp':
            if self.answer[0] in corr_answer:
                user_points += self.points
        

        print('sss', user_points)

        
        self.participation.answers[self.question_no] = self.answer
        self.participation.score += user_points
        self.participation.save()


    def save_ans(self):    
        self.participation.saved_answers[self.question_no] = self.answer
        self.participation.save()


class ParticipationStatusController():
    
    def __init__(self, quiz_id, user):
        self.quiz_id = quiz_id
        self.user_obj = user

    def get_participation_data(self):
        participation_obj = Participation.objects.get(user=self.user_obj, quiz=Quiz.objects.get(quiz_id=self.quiz_id))
        obj_ser = ParticipationSerializer(participation_obj)
        return obj_ser.data