class GetPostApiData {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;

  GetPostApiData({this.id, this.name, this.email, this.gender, this.status});

  GetPostApiData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    gender = json['gender'] ?? "";
    status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['status'] = this.status;
    return data;
  }
}
