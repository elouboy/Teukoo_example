class Challenge{

  final String id;
  final String name;
  final String cover;
  final String description;
  final int startDate;
  final int endDate;
  final String reward;
  

  Challenge({this.id, this.name,this.description,  this.startDate, this.endDate, this.reward, this.cover});

factory Challenge.fromJson(Map<String, dynamic> json){
  return Challenge(
    id: json['id'] as String,
    name: json['name'] as String,
    cover: json['cover'] as String,
    description: json['description'] as String,
    startDate: json['startDate'] as int,
    endDate: json['endDate'] as int,
    reward: json['reward'] as String,

  );

}

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'cover': cover,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'reward': reward,
    };


  }

}