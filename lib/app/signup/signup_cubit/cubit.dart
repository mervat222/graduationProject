import 'dart:async';
import 'dart:convert';

import 'package:cord_2/app/signup/signup_cubit/signup_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());


  static SignUpCubit get(context) => BlocProvider.of(context);

  static var name = TextEditingController();
  static var phone_number = TextEditingController();
  static var email = TextEditingController();
  static var password = TextEditingController();
  static var password_confirmation = TextEditingController();
  static var register_status;
  static var register_message;
  static Dio dio = Dio();

  static var token;

  bool isPressed = false;
  func(String s) {
    if (s == '') {
      isPressed == false;
      emit(NewFunc());
    } else {
      null;
    }
  }

  isPress() {
    isPressed = true;
    emit(IsPressState());
  }

  errorTextFunc(String field, String fieldName) {
    if (field.isEmpty) {
      return '$fieldName shouldn,t be Empty';
    } else {
      Null;
    }
  }

  Future httpData(name, phone, email, password, passwordConfirmation) async {
    try {
      final response = await http.post(
        Uri.parse('https://cord0.me/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'phone': phone,
        },
        headers: {
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        register_status = data['status'];
        register_message = data['message'];
        emit(SignUpSuccess());
        token = data['token'];
      } else {
        register_status = false;
        var data = jsonDecode(response.body);
        token = data['token'];

        register_message = data['message'];
      }
    } catch (e) {
      register_message = e.toString() + '\n      Check Your Connection';
    }
  }

  /*init() async {
    dio = Dio(BaseOptions(
      baseUrl: 'https://cord0.me/api/',
    ));
  }

  Future register(name, phone, email, password, password_confirmation) async {
    return await dio.post('register', data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation
    }).then((value) {
      print('------------------------');
      print(value.statusCode);
      register_status = value.data['status'];
      register_message = value.data['message'];
      emit(SignUpSuccess());
      print(value.data);
    }).catchError((e) {
      register_message = 'The email has already been taken.';

      print('**********************');

      emit(SignUpFailure());
      print(e.toString());
    });
  }*/
}
