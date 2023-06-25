import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../login/login_cubit/login_cubit.dart';
import '../../signup/signup_cubit/cubit.dart';
part 'PatientProile_state.dart';

class PatientProileCubit extends Cubit<PatientProileState> {
  PatientProileCubit() : super(PatientProileInitial());
  static PatientProileCubit get(context) => BlocProvider.of(context);
  static var name = 'wait...';
  static var phone = '';
  static var email = 'wait...';
  static var userToken;
  token() {
    if (SignUpCubit.token == null) {
      userToken = LoginCubit.token;
    } else {
      userToken = SignUpCubit.token;
    }
  }

  static XFile? image;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  updateProfile(name, phone, image) async {
    try {
      final response =
      await http.post(Uri.parse('https://cord0.me/api/profile'), headers: {
        "Accept": "application/json",
        'authorization': 'Bearer $userToken'
      }, body: {
        'name': name,
        'phone': phone,
        // 'image': File(image!.path)
      });

      if (response.statusCode == 201) {
      } else {
      }
    } catch (e) {
    }
  }

  getData(myData) async {
    try {
      final response = await http.get(Uri.parse('https://cord0.me/api/profile'),
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer $userToken'
          });
      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        return await data['data'][myData];
      } else {
      }
    } catch (e) {
    }
  }

  int stat = 0;
  void changeStat(index) {
    stat = index;
    emit(ChangeStat());
  }

  getSensorData() async {
    try {
      final response = await http.get(Uri.parse('https://cord0.me/api/sensors'),
          headers: {
            "Accept": "application/json",
            'authorization': 'Bearer $userToken'
          });
      var data = await jsonDecode(response.body);
      List listOfData = data['data'];

    } catch (e) {

    }
  }
}
