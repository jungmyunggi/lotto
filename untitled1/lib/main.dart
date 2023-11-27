import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로또 번호 생성기',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> lotteryNumbers = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("로또 번호 생성기"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < lotteryNumbers.length; i++)
                LotteryRow(rowNumber: i + 1, numbers: lotteryNumbers[i]),
              ElevatedButton(
                onPressed: () {
                  generateAndSetNumbers();
                },
                child: Text('생성'),
              ),
              Text('숫자를 다시 뽑고싶으면 생성버튼을 눌러주세요'),


            ],
          ),
        ),
      ),
    );
  }

  void generateAndSetNumbers() {
    setState(() {
      lotteryNumbers.clear();
      for (var i = 0; i < 5; i++) {
        lotteryNumbers.add(generateLottoNumbers());
      }
    });
  }

  List<int> generateLottoNumbers() {
    List<int> lotto = [];
    while (true) {
      var rnd = Random().nextInt(46) + 1;
      if (!lotto.contains(rnd)) {
        lotto.add(rnd);
      }
      if (lotto.length == 6) break;
    }
    lotto.sort();
    return lotto;
  }
}

class LotteryRow extends StatelessWidget {
  final int rowNumber;
  final List<int> numbers;

  const LotteryRow({Key? key, required this.rowNumber, required this.numbers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("$rowNumber번 : "),
            for (var number in numbers)
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
