// define a call method for Sc so that Sc can be
// mocked as a function.
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([Sc, http.Client])
abstract class Sc {
  void call(Object conv);
}
