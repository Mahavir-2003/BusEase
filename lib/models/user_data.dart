class UserData {
//   {
//     "_id": "66011bb9040f2f5bf488873a",
//     "firstName": "Mahavir",
//     "middleName": "Manubhai",
//     "lastName": "Patel",
//     "dob": "2003-10-20T00:00:00.000Z",
//     "gender": "male",
//     "phoneNumber": "6353231139",
//     "email": "mp@mail.com",
//     "aadharCardNumber": "123412341234",
//     "role": "user"
// }

  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String aadharCardNumber;
  final String role;


  UserData({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.aadharCardNumber,
    required this.role,
  });



  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      id: json["_id"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      dob: DateTime.parse(json["dob"]),
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      aadharCardNumber: json['aadharCardNumber'],
      role: json['role'],
    );
  }

}