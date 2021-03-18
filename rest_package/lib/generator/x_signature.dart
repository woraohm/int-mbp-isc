import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:secure_random/secure_random.dart';

class XSignature {

  var _consumerKey = "dkDsmDHT6rQxx22tqYlyUL0SlmJe5FQX";
  var _secretKey = "aee9bUGE5ArZXjV9Ts-lD7UwW6NNXSC8";

  String generate(){
    var randomString = _generateRandomString();
    var message = _concatWithKey(randomString);
    var digest = _encodeBySHA256(message);
    var base64Data = _encodeBase64(digest);
    return _consumerKey + " " + randomString + " " + base64Data.toString();
  }
  String generateREQRefNo(){
    var randomString = _generateRandomStringREQRefNo();
    return randomString;
  }
  String _generateRandomStringREQRefNo(){
    var secureRandom = SecureRandom();
    var randomString = secureRandom.nextString(
      length: 4,
      charset: '0123456789'
    );
   
    // print("randomString=$randomString");
    return randomString;
  }

  String _generateRandomString(){
    var secureRandom = SecureRandom();
    var randomString = secureRandom.nextString(
        length: 32
    ).toLowerCase();
    // print("randomString=$randomString");
    return randomString;
  }

  String _concatWithKey(String randomString){
    var message = _consumerKey+randomString;
    // print("message=$message");
    return message;
  }

  Digest _encodeBySHA256(String message){
    var key = utf8.encode(_secretKey);
    var bytes = utf8.encode(message);
    // print("key encode utf8=$key");
    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    // print("HMAC digest=$digest");
    return digest;
  }

  String _encodeBase64(Digest digest){
    var base64Data = base64
        .encode(digest.bytes)
        .replaceAll('-', '+')
        .replaceAll('_', '/');
    // print("base64Data=${base64Data.toString()}");
    return base64Data;
  }
  
}