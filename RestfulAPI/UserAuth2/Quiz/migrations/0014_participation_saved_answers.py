# Generated by Django 4.0.2 on 2022-03-23 08:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Quiz', '0013_quiz_quiz_quiz_start_t_42f1d9_idx_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='participation',
            name='saved_answers',
            field=models.JSONField(default=[]),
            preserve_default=False,
        ),
    ]
