import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var question = [
    {
      'qt': 'What\'s Your Favorite Color?',
      'answer': [{'text':'Red','score': 8},{'text':'Green','score': 2},{'text':'White','score': 5},{'text':'Black','score': 10}]
    },
    {
      'qt': 'What is your Favorite Anmial?',
      'answer': [{'text':'Cat','score': 10},{'text':'Dog','score': 2},{'text':'Lion','score': 5},{'text':'Tiger','score': 8}]
    },
    {
      'qt': 'What is Your Favorite Sports?',
      'answer': [{'text':'Football','score': 8},{'text':'BasketBall','score': 2},{'text':'Cricket','score': 5},{'text':'Hockey','score': 10}]
    },
  ];
  var questionIndex = 0;
  var totalScore=0;

  void resetQuiz(){
    setState(() {
     questionIndex=0;
    totalScore=0;
});
 
  }


  void answerQuestion(int score) {
totalScore+=score;

    setState(() {
      questionIndex = questionIndex + 1;
    });
    if (questionIndex < question.length) {
      print('We Have more Questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: questionIndex < question.length
            ? Quiz(
                answerQuestion: answerQuestion,
                question: question,
                questionIndex: questionIndex,
              )
            : Result(totalScore,resetQuiz),
      ),
    );
  }
}
