import 'package:flutter/material.dart';
import 'package:quizzler_flutter/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  QuizBrain quizBrain = QuizBrain();

  int correct = 0, wrong = 0;
  void resetQuiz() {
    setState(() {
      scoreKeeper.clear();
      quizBrain.resetQuestionNumber();
      correct = wrong = 0;
    });
  }

  void buttonClicked(bool answer) {
    setState(
      () {
        if(answer == quizBrain.getQuestionAnswer()){
          scoreKeeper.add(const Icon(color: Colors.lightGreen, Icons.check));
          correct++;
        }
        else{
          scoreKeeper.add(const Icon(color: Colors.red, Icons.close));
          wrong++;
        }
        if(quizBrain.checkLength() == true) {
          Alert(
            context: context,
            type: AlertType.info,
            title: "Quiz Completed",
            desc: "Correct Answer : $correct \n Wrong Answer: $wrong",
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetQuiz();
                },
                width: 140,
                color: Colors.cyan,
                child: const Text(
                  "Restart the Quiz",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show();
        }
        else {quizBrain.nextQuestion();}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () => buttonClicked(true),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () => buttonClicked(false),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
