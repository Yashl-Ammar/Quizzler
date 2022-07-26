import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  QuizBrain quizBrain = QuizBrain();

  List<Widget> scoreKeeper = [];

  void onFinish()
  {
      Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
        isOverlayTapDismiss: false,
        isCloseButton: false,
      ),
      title: 'End of Quiz',
      desc: 'The quiz has ended press the reset button to restart the quiz',
      buttons: [
        DialogButton(
            onPressed: () {
              setState(() {
                quizBrain.reset();
                scoreKeeper = [];
              });
              Navigator.pop(context);
            },
            child: const Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
        )
      ],
    ).show();
  }


  void checkAnswer(bool userPickedAnswer)
  {
    if(quizBrain.getAnswer() == userPickedAnswer){
      scoreKeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    }
    else{
      scoreKeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.

                checkAnswer(true);



                setState(() {


                    if(quizBrain.isFinished() == true)
                    {
                      onFinish();
                    }
                    else {
                      quizBrain.nextQuestion();
                    }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);

                if(quizBrain.isFinished())
                {
                  onFinish();
                }

                setState(() {
                  quizBrain.nextQuestion();
                });
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreKeeper,
        ),

      ],
    );
  }
}