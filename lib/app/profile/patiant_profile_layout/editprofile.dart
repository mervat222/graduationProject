import 'dart:io';

import 'package:cord_2/app/profile/cubit/PatientProile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/circular_button.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PatientProileCubit(),
        child: BlocConsumer<PatientProileCubit, PatientProileState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = PatientProileCubit.get(context);

              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(55.h),
                  child: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 16,
                          foregroundColor: Colors.white,
                          child: CircularButton2(
                              icon:Icons.check, onTap: () {
                            cubit.updateProfile(
                                      cubit.nameController.text,
                                      cubit.phoneController.text,
                                      PatientProileCubit.image);
                                  Navigator.pop(context);
                          },),
                        ),
                      )
                    ],
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    elevation: 0,
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20),
                    ),
                    centerTitle: true,
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding:
                    const EdgeInsets.only(top: 25, left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 38,
                              backgroundColor: Color.fromRGBO(0, 129, 207, 1),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                AssetImage('assets/icons/Avatar.png'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                        elevation: 0.0,
                                        // title: Center(child: Text("Evaluation our APP")),
                                        content: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 15),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0))),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const Row(
                                                      children: [
                                                        ImageIcon(
                                                          AssetImage(
                                                              'assets/icons/icon6.png'),
                                                          color: Color.fromRGBO(
                                                              130, 128, 240, 1),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text('Add Frame')
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  InkWell(
                                                    onTap: () async {
                                                      ImagePicker picker =
                                                      ImagePicker();
                                                      PatientProileCubit.image =
                                                      await picker.pickImage(
                                                          source:
                                                          ImageSource
                                                              .camera);
                                                    },
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final ImagePicker
                                                        _picker =
                                                        ImagePicker();
                                                        PatientProileCubit
                                                            .image =
                                                        (await _picker
                                                            .pickImage(
                                                            source: ImageSource
                                                                .gallery))!;
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          ImageIcon(
                                                            AssetImage(
                                                                'assets/icons/icon7.png'),
                                                            color:
                                                            Color.fromRGBO(
                                                                130,
                                                                128,
                                                                240,
                                                                1),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              'Select Profile Picture')
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  InkWell(
                                                    onTap: () {
                                                      ImagePicker.platform
                                                          .pickImage(
                                                          source:
                                                          ImageSource
                                                              .camera);
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        ImageIcon(
                                                          AssetImage(
                                                              'assets/icons/icon7.png'),
                                                          color: Color.fromRGBO(
                                                              130, 128, 240, 1),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text('Take Picture')
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0))),
                                              child: Center(
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    textColor: Colors.white,
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  5)),
                                                          gradient:
                                                          LinearGradient(
                                                            colors: [
                                                              Color.fromRGBO(
                                                                  121,
                                                                  102,
                                                                  255,
                                                                  1),
                                                              Color.fromRGBO(
                                                                  134,
                                                                  143,
                                                                  231,
                                                                  1),
                                                              Color.fromRGBO(
                                                                  158,
                                                                  183,
                                                                  255,
                                                                  1),
                                                            ],
                                                          )),
                                                      padding: const EdgeInsets
                                                          .all(
                                                          14.0),
                                                      child: const Text(
                                                        'Cancel',
                                                        textAlign: TextAlign
                                                            .center,
                                                      ),
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ));
                                  },
                                );
                              },
                              child: const CircleAvatar(
                                  backgroundColor:
                                  Color.fromRGBO(0, 129, 207, 1),
                                  radius: 10,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 13,
                                  )),
                            )
                          ],
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          controller: cubit.nameController,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                        ),
                        const TextField(
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          decoration:
                          const InputDecoration(labelText: 'Phone number'),
                          controller: cubit.phoneController,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

// import 'package:cord_2/app/profile/cubit/PatientProile_cubit.dart';
// import 'package:cord_2/core/components/gradient_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/components/circular_button.dart';
//
// class EditProfile extends StatelessWidget {
//   const EditProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => PatientProileCubit(),
//         child: BlocConsumer<PatientProileCubit, PatientProileState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               return Scaffold(
//                 appBar: PreferredSize(
//                   preferredSize: Size.fromHeight(55.h),
//                   child: AppBar(
//                     actions: [
//                       Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 5.w),
//                         child: CircularButton2(onTap: () {
//                           Navigator.pop(context);
//                         },icon: Icons.check,),
//                       )
//
//                     ],
//                     leading: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.black,
//                         )),
//                     elevation: 0,
//                     title: const Text(
//                       'Edit Profile',
//                       style: TextStyle(
//                           color: Color.fromRGBO(0, 0, 0, 1), fontSize: 20),
//                     ),
//                     centerTitle: true,
//                     backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                 ),
//                 body: SingleChildScrollView(
//                   child: Container(
//                     padding:
//                         const EdgeInsets.only(top: 25, left: 25, right: 25),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       // ignore: prefer_const_literals_to_create_immutables
//                       children: [
//                         Stack(
//                           alignment: Alignment.bottomRight,
//                           children: [
//                             const CircleAvatar(
//                               radius: 38,
//                               backgroundColor: Color.fromRGBO(0, 129, 207, 1),
//                               child: CircleAvatar(
//                                 radius: 35,
//                                 backgroundImage:
//                                     AssetImage('assets/icons/Avatar.png'),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                         backgroundColor: Colors.transparent,
//                                         contentPadding: EdgeInsets.zero,
//                                         elevation: 0.0,
//                                         // title: Center(child: Text("Evaluation our APP")),
//                                         content: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Container(
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 30,
//                                                       vertical: 15),
//                                               decoration: const BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               10.0))),
//                                               child: const Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       ImageIcon(
//                                                         AssetImage(
//                                                             'assets/icons/icon6.png'),
//                                                         color: Color.fromRGBO(
//                                                             130, 128, 240, 1),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text('Add Frame')
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   Row(
//                                                     children: [
//                                                       ImageIcon(
//                                                         AssetImage(
//                                                             'assets/icons/icon7.png'),
//                                                         color: Color.fromRGBO(
//                                                             130, 128, 240, 1),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text(
//                                                           'Select Profile Picture')
//                                                     ],
//                                                   ),
//                                                   Divider(),
//                                                   Row(
//                                                     children: [
//                                                       ImageIcon(
//                                                         AssetImage(
//                                                             'assets/icons/icon7.png'),
//                                                         color: Color.fromRGBO(
//                                                             130, 128, 240, 1),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text('Take Picture')
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Container(
//                                               decoration: const BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               10.0))),
//                                               child: Center(
//                                                   child: MaterialButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 textColor: Colors.white,
//                                                 child: Container(
//                                                   width: double.infinity,
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           5)),
//                                                           gradient:
//                                                               LinearGradient(
//                                                             colors: [
//                                                               Color.fromRGBO(
//                                                                   121,
//                                                                   102,
//                                                                   255,
//                                                                   1),
//                                                               Color.fromRGBO(
//                                                                   134,
//                                                                   143,
//                                                                   231,
//                                                                   1),
//                                                               Color.fromRGBO(
//                                                                   158,
//                                                                   183,
//                                                                   255,
//                                                                   1),
//                                                             ],
//                                                           )),
//                                                   padding: const EdgeInsets.all(
//                                                       14.0),
//                                                   child: const Text(
//                                                     'Cancel',
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ),
//                                               )),
//                                             )
//                                           ],
//                                         ));
//                                   },
//                                 );
//                               },
//                               child: const CircleAvatar(
//                                   backgroundColor:
//                                       Color.fromRGBO(0, 129, 207, 1),
//                                   radius: 10,
//                                   child: Icon(
//                                     Icons.camera_alt_outlined,
//                                     size: 13,
//                                   )),
//                             )
//                           ],
//                         ),
//                         const TextField(
//                           decoration: InputDecoration(labelText: 'Name'),
//                         ),
//                         const TextField(
//                           decoration: InputDecoration(
//                               labelText: 'Password',
//                               suffixIcon: Icon(Icons.remove_red_eye_outlined)),
//                         ),
//                         const TextField(
//                           decoration: InputDecoration(
//                               labelText: 'Confirm Password',
//                               suffixIcon: Icon(Icons.remove_red_eye_outlined)),
//                         ),
//                         const TextField(
//                           decoration: InputDecoration(labelText: 'Email'),
//                         ),
//                         const TextField(
//                           decoration:
//                               InputDecoration(labelText: 'Phone number'),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
// }


/*





*/