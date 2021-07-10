import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function Reset;
  Result(this.resultScore,this.Reset);

  String get result {
    var resultText;
    if (resultScore <= 6) {
      resultText = 'You are Awesome like me';
    } else if (resultScore > 6 && resultScore < 20) {
      resultText = 'We have our Similarities and Differences';
    } else {
      resultText = 'We are Completely Different';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
            Text(
              'Survey Complete!!',
              style: TextStyle
              (fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
              textAlign: TextAlign.center,
              ),
            Text(
                     result,
                     style: TextStyle(
                     fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
                     textAlign: TextAlign.center,
    ),
    RaisedButton(
      child: Text('Restart Quiz'),
      textColor: Colors.black,
      onPressed : Reset
       )
          ],
        ));
  }
}
