import 'networking.dart'; // NetworkHelper now throws HttpException

const swApiUrl = 'https://swapi.dev/api';

class SwApi {
  // Fetches data for a specific filter and page (e.g., a list of people)
  Future<String> getData(String filter, int page) async {
    String swApiFilterUrl = '$swApiUrl/$filter/?page=$page'; // Added trailing slash for consistency
    NetworkHelper networkHelper = NetworkHelper(swApiFilterUrl);
    // NetworkHelper.getData() now returns Future<String> and can throw HttpException
    var resultsData = await networkHelper.getData();
    return resultsData;
  }

  // Fetches data from a complete URL (e.g., a specific person, planet, species, vehicle)
  Future<String> getDataByFullUrl(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    // NetworkHelper.getData() now returns Future<String> and can throw HttpException
    var resultsData = await networkHelper.getData();
    return resultsData;
  }

  // getDataPerson method is removed.
}
