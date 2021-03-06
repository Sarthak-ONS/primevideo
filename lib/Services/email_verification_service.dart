import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prime_video/Screens/verify_mail_screen.dart';
import 'package:prime_video/routes.dart';

import '../private_variable.dart';

class SendEmailVerificationMail {
  static int? otp;

  generateOTP() {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var randomizer = Random();
    var rNum = min + randomizer.nextInt(max - min);
    otp = rNum;
    print(rNum);
  }

  Future sendEmailVerificaionMail(
      {String? name,
      String? email,
      String? message,
      String? subject,
      context}) async {
    generateOTP();
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

    try {
      final response = await http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        },
        body: jsonEncode({
          "user_id": userID,
          'service_id': serviceId,
          'template_id': templateID,
          'template_params': {
            'to_name': name,
            'to_email': email,
            'user_subject': subject,
            'otp': otp
          }
        }),
      )
          .then(((v) {
        Navigator.of(context).push(
          createRoute(
            VerifyEmailScreen(
              name: name,
              otp: otp,
              email: email,
            ),
          ),
        );
      }));

      print(response.body);
      print(response.statusCode);
      return;
    } on SocketException catch (e) {
      print("Error From Email Send Method For reset");
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
