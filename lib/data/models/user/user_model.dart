class UserModel {
  String? sId;
  String? fullName;
  String? email;
  bool? isadmin;
  String? password;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.sId,
      this.fullName,
      this.email,
      this.isadmin,
      this.password,
      this.phoneNumber,
      this.address,
      this.city,
      this.state,
      this.profileProgress,
      this.id,
      this.updatedOn,
      this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    isadmin = json['isadmin'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['isadmin'] = this.isadmin;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['profileProgress'] = this.profileProgress;
    data['id'] = this.id;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
