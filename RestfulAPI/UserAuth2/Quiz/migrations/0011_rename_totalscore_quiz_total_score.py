# Generated by Django 4.0.2 on 2022-02-25 08:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Quiz', '0010_quiz_totalscore'),
    ]

    operations = [
        migrations.RenameField(
            model_name='quiz',
            old_name='totalScore',
            new_name='total_score',
        ),
    ]
