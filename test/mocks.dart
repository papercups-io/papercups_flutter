// define a call method for Sc so that Sc can be
// mocked as a function.
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

abstract class Sc {
  void call(Object conv);
}

class MockClient extends Mock implements http.Client {}

class MockSc extends Mock implements Sc {}
