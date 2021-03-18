class HeaderConstant{

  static const contentType = 'Content-Type';
  static const xSignature = 'X-Signature';
  static const xToken = 'X-Token';
  static const cookie = 'cookie';

  static var valueContentType = 'application/json';

  static Map<String, String> getBasicHeader(){
    return <String, String> {
      contentType: valueContentType,
      cookie: 'JSESSIONID=7881783F91032F567B18FFDF5D4AB120'
    };
  }

}