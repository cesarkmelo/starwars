import 'networking.dart';

const swApiUrl = 'https://swapi.dev/api';

class SwApi {
  Future<dynamic> getData(String filter, int page) async {
    String swApiFilterUrl = '$swApiUrl/$filter?page=$page';
    NetworkHelper networkHelper = NetworkHelper(swApiFilterUrl);
    var resultsData = await networkHelper.getData();
    return resultsData;
  }

  Future<dynamic> getDataPerson(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var resultsData = await networkHelper.getDataPerson();
    return resultsData;
  }
}
