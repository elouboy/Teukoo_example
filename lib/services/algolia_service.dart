import 'package:algolia/algolia.dart';

class AlgoliaService{
  static final Algolia algolia = Algolia.init(
    applicationId: '0K99U99', //ApplicationID
    apiKey: '008JI88N78N', //search-only api key in flutter code
  );
}