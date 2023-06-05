import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}



class MyApp extends StatelessWidget {
  final stt.SpeechToText speech = stt.SpeechToText();
  String transcription = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Speech to Text Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Transcription:',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                transcription,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Start Listening'),
                onPressed: startListening,
              ),
              ElevatedButton(
                child: Text('Stop Listening'),
                onPressed: stopListening,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startListening() {
    speech.listen(
      onResult: (result) {
        transcription = result.recognizedWords;
        if (result.finalResult) {
          stopListening();
        }
      },
    );
  }

  void stopListening() {
    speech.stop();
  }
}
