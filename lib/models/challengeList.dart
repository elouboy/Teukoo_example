
import 'package:teukoo_code/models/challenge.dart';



class ChallengeList {
  final List<Challenge> challenge;

  ChallengeList({
    this.challenge,
  });


  factory ChallengeList.fromJson(List<dynamic> parsedJson) {

    List<Challenge> challenge = new List<Challenge>();
    challenge = parsedJson.map((i)=>Challenge.fromJson(i)).toList();
    return new ChallengeList(
       challenge: challenge,
    );
  }
}