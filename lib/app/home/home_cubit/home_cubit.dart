import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../login/login_cubit/login_cubit.dart';
import '../../signup/signup_cubit/cubit.dart';
import 'home_states.dart';
import 'package:translator/translator.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  static bool toggle = false;

  static String tvoice =
      'https://coqui-prod-creator-app-synthesized-samples.s3.amazonaws.com/samples/fc0b3fb0-8344-428d-9775-c9a3e95febfb.wav';

  static int t = 1;
  chgtooggle(x) {
    toggle = x;
    emit(chgToggleState());
  }

  static String selectedLanguage = 'English';
  static String type = 'en';

  static dynamic userToken;

  token() {
    if (SignUpCubit.token == null) {
      userToken = LoginCubit.token;
    } else {
      userToken = SignUpCubit.token;
    }
  }

  ggg() async {
    AudioPlayer myAudioPlayer = AudioPlayer();
    await myAudioPlayer.play(tvoice);
  }

  static dynamic data;

  static var tdata = 'You have a maid who has a sweetheart?';
  Future<String?> getTextData() async {
    try {
      if (toggle == true) {
        final response = await http
            .post(Uri.parse('https://cord0.me/api/signals/simulate'), body: {
          'cloned': '1'
        }, headers: {
          "Accept": "application/json",
          'authorization': 'Bearer 342|NSh2wwl5OJTdrLA9DPuxQLVEZSkRL4UlaoCgOrmP'
        });

        var mydata = await jsonDecode(response.body);
        tdata = mydata['text'];
        tvoice = mydata['audio_url'];

        return tdata;
      } else {
        final response = await http.post(
            Uri.parse('https://cord0.me/api/signals/simulate'),
            body: {},
            headers: {
              "Accept": "application/json",
              'authorization': 'Bearer $userToken'
            });
        data = await jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      return e.toString();
    }
  }

  FlutterTts ftts = FlutterTts();

  //------------------------------- speacking the the output text ----------------------------------//

  tts() async {
    if (toggle == true) {
      AudioPlayer myAudioPlayer = AudioPlayer();
      await myAudioPlayer.play(tvoice);
    } else {
      await ftts.setLanguage("en-US");
      await ftts.setSpeechRate(0.2); //speed of speech
      await ftts.setVolume(1.0); //volume of speech
      await ftts.setPitch(1);

      var result = await ftts.speak(translatedText);
    }
  }

  stoptts() async {
    await ftts.stop();
  }

  Future<List> getSensorData() async {
    try {
      final response = await http.get(Uri.parse('https://cord0.me/api/sensors'),
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer $userToken'
          });
      var data = await jsonDecode(response.body);
      List listOfData = data['data'];
      return listOfData;
    } catch (e) {
      return List.empty();
    }
  }

  //TODO VARIABLES
  bool isRecording = false;
  List<int> duration = [900, 700, 600, 800, 500];
  List<int> height = [30, 60, 50, 80, 60, 45, 50, 90, 35, 60];
  //TODO METHODS
  void startRecord() {
    isRecording = true;
    emit(StartRecording());
  }

  void stopRecord() {
    isRecording = false;
    emit(StopRecording());
  }

  static String translatedText = 'I only doubt—';
  /*  'When I glance over my notes and records of the Sherlock Holmes cases between the years ’82 and ’90, I am faced by so many which present strange and interesting features that it is no easy matter to know which to choose and which to leave.';
 */

  GoogleTranslator translator = GoogleTranslator();

  translate(type) async {
    try {
      await translator.translate(data!, from: 'en', to: type).then((value) {
        translatedText = value.text;
        return translatedText;
      });
    } catch (e) {
      translatedText = e.toString();
      return translatedText;
    }
  }
}
