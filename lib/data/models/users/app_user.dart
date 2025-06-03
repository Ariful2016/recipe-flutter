class AppUser {
  final String uid;
  final String name;
  final String email;
  final String contactNo;
  final String address;
  final String photoUrl;

  AppUser(
      {required this.uid,
      required this.name,
      required this.email,
      required this.contactNo,
      required this.address,
      required this.photoUrl});

  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'name': name,
      'email': email,
      'contactNo': contactNo,
      'address': address,
      'photoUrl': photoUrl
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map){
    return AppUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      contactNo: map['contactNo'],
      address: map['address'],
      photoUrl: map['photoUrl']
    );
  }
}
