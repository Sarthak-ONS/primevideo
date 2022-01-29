import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptApi {
  static final key = encrypt.Key.fromLength(32);

  static final iv = encrypt.IV.fromLength(16);

  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptusingAES(String text) {
    final encryptedText = encrypter.encrypt(text, iv: iv);

    print(encryptedText);
  }

  static decryptusingAES(text) {
    return encrypter.decrypt(text, iv: iv);
  }
}
