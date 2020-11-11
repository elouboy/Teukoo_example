import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teukoo_code/models/user.dart';



class Challenger{
final String challengeId;
final String challengerId;
final String userId;
final String reward;
int voteCount;
final DateTime voteOn;
Challenger({this.challengeId, this.challengerId,this.voteCount, this.userId, this.reward, this.voteOn});

 Challenger.fromData(Map<String, dynamic> data)
:  challengeId = data['challengeId'],
   challengerId = data['challengerId'],
   voteCount = data['voteCount'],
   userId = data['userId'],
   reward = data['reward'],
   voteOn = data['voteOn'];

Map<String, dynamic> toJson() {
      return{
      'challengeId': challengeId,
      'challengerId': challengerId,
      'voteCount': voteCount,
      'userId': userId,
      'reward': reward,
      'voteOn':voteOn,
      };

}
}





final CollectionReference _challengerCollectionReference =
      FirebaseFirestore.instance.collection('challenge');




Future createChallenger(Challenger challenger) async{
  try {
    _challengerCollectionReference.doc(challenger.challengeId).collection(challenger.challengerId);
  } catch (e) {
    return e.message;
  }
}

Future createVoter(Challenger challenger, Users user) async {
  try {
       _challengerCollectionReference.doc(challenger.challengeId).collection(challenger.challengerId).doc(user.id).set({
         
           "voteOn": Timestamp.now(),
         
       });
  } catch (e) {
    return e.message;
  }
}

Future deleteVoter(Challenger challenger , Users user) async {
  try {
    _challengerCollectionReference.doc(challenger.challengeId).collection(challenger.challengerId).doc(user.id).delete();
  } catch (e) {
    return e.message;
  }
}


Future setReward(Challenger challenger, String reward) async {
  try {
    _challengerCollectionReference.doc(challenger.challengeId).collection(challenger.challengerId).doc(challenger.challengeId).set({
      "reward" : reward,
    });
  } catch (e) {
    return e.message;
  }
}