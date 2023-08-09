import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();
  var enabled = false;
  List<Score> score = [];
  double rate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    score.add(Score(rate: 5, comment: '맛돌이'));
    score.add(Score(rate: 1, comment: '노맛돌이'));
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Text('${score[index].rate}'),
        title: Text(score[index].comment),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                setState(() {
                  rate = rating;
                  enabled = true;
                });
              },
            ),
            TextFormField(
              controller: _textEditingController,
              enabled: enabled,
              decoration: const InputDecoration(
                  hintText: '맛이 어떻냐고',
                  label: Text('급식 맛돌이?'),
                  border: OutlineInputBorder()),
              maxLength: 20,
            ),
            ElevatedButton(
                onPressed: enabled
                    ? () {
                        score.add(
                          Score(
                              rate: rate, comment: _textEditingController.text),
                        );
                        setState(() {
                          ListView;
                        });
                      }
                    : null,
                child: const Text('저장하기')),
            Expanded(child: listView)
          ],
        ),
      ),
    );
  }
}

class Score {
  double rate;
  String comment;

  Score({required this.rate, required this.comment});
}
