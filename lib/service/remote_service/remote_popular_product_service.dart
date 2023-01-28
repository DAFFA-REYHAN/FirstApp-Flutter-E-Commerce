import 'package:http/http.dart' as http;
import 'package:flutter_application/const.dart';

class RemotePopularProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/popular-products';

  Future<dynamic> get() async {
    var response =
        await client.get(Uri.parse('$remoteUrl?populate=image,product.images'));
    return response;
  }
}
