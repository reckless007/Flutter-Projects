import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String,Object>> question;
  final Function answerQuestion;
  final int questionIndex;

   Quiz({this.answerQuestion,this.question,this.questionIndex});


  @override
  Widget build(BuildContext context) {
    return  Column(
                children: <Widget>[
                  Question(
                    question[questionIndex]['qt'],
                  ),
                  ...(question[questionIndex]['answer'] as List<Map<String,Object>>)
                      .map((answer) {
                    return Answer(() => answerQuestion(answer['score']), answer['text']);
                  }).toList()
                ],
              );
  }
}
