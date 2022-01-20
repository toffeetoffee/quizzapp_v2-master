import 'package:flutter/material.dart';
import 'quiz-brain.dart';
// -TODO 4: import rflutter package
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // -TODO 6.ปรับปรุง UI ตามชอบ
        backgroundColor: Colors.white,
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
  //กำหนดให้ scoreKeeper เริ่มต้นเป็นลิสต์ว่าง
  List<Icon> scoreKeeper = [];
  int totalScore = 0;

  void checkAnswer(bool user_ans) {
    bool correctAnswer = quizBrain.getQuestionAnswer()!;
    bool ending = quizBrain.isFinished()!;

    // -TODO 5: ปรับแก้โค้ดโดย ถ้าคำถามหมดแล้วให้ 1)โชว์ alert โดยใช้ rflutter_alert , 2) รีเซต questionNumber ให้เป็นศูนย์ด้วยเมธอด reset, 3) เซตให้ scoreKeeper เป็นลิสต์ว่าง และ 4) เซต totalScore ให้เป็นศูนย์
    setState(() {
       if (correctAnswer == user_ans) {
        //เพิ่มข้อมูลเข้าไปในลิสต์ scoreKeeper โดยใช้ add method
        totalScore++;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        if (ending == false) {
          quizBrain.nextQuestion();
        }
        if (ending == true) {
          Alert(
            context: context,
            title: "Your score is:",
            desc: "$totalScore",
            buttons: [
              DialogButton(
                child: Text(
                  "RESET",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {setState(() {
                  totalScore = 0;
                  scoreKeeper.clear();
                  quizBrain.reset();
                  Navigator.pop(context);
      });},
                width: 120,
              )
            ],
          ).show();
        }
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        if (ending == false) {
          quizBrain.nextQuestion();
        }
        if (ending == true) {
          Alert(
            context: context,
            title: "Your score is:",
            desc: "$totalScore",
            buttons: [
              DialogButton(
                child: Text(
                  "RESET",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {setState(() {
                  totalScore = 0;
                  scoreKeeper.clear();
                  quizBrain.reset();
                  Navigator.pop(context);
                });},
                width: 120,
              )
            ],
          ).show();
        }
    }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '$totalScore',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText()!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // -TODO 2: ปรับแก้โดยการเรียกใช้ฟังก์ชัน checkAnswer
                checkAnswer(false);
                // bool? correctAnswer = quizBrain.getQuestionAnswer();
                // if (correctAnswer == false) {
                //   setState(() {
                //     //เมื่อกดปุ่ม False เพิ่มข้อมูลเข้าไปในลิสต์ scoreKeeper โดยใช้ add method
                //     totalScore++;
                //     scoreKeeper.add(Icon(
                //       Icons.check,
                //       color: Colors.green,
                //     ));
                //
                //     quizBrain.nextQuestion();
                //   });
                // } else {
                //   setState(() {
                //     scoreKeeper.add(Icon(
                //       Icons.close,
                //       color: Colors.red,
                //     ));
                //
                //     quizBrain.nextQuestion();
                //   });
                // }
              },
            ),
          ),
        ),
        //แสดงผล icon สำหรับ scoreKeeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
