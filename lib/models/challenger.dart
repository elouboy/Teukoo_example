class Challenger {
  final String userId;
  final String description;
  final String challengeId;
  final String cover;
  final DateTime takeOn;
  final String video;

  Challenger({this.userId, this.description, this.challengeId, this.cover, this.takeOn, this.video});


  factory Challenger.fromJson(Map<String, dynamic> json){
  return Challenger(
    userId: json['userId'] as String,
    challengeId: json['challengeId'] as String,
    video: json['video'] as String,
    cover: json['cover'] as String,
    description: json['text'] as String,
    takeOn: json['takeOn'] as DateTime

  );

}

  Map<String, dynamic> toJson(){
    return{
      'userId': userId,
      'challengeId': challengeId,
      'video': video,
      'cover': cover,
      'text': description,
      'takeOn': takeOn,
    };


  }

  
}