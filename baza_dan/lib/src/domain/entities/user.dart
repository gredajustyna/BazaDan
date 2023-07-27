import 'dart:core';

class User{
  String? id;
  String name;
  String lastname;
  String email;
  String street;
  String houseNr;
  String? apartmentNr;
  String postalCode;
  String city;
  String phoneNumber;

  User({
    this.id,
      required this.name,
      required this.lastname,
      required this.email,
      required this.street,
      required this.houseNr,
      this.apartmentNr,
      required this.postalCode,
      required this.city,
      required this.phoneNumber});

  // factory User.fromJson(Map<String, dynamic> jsonData) {
  //   return User(
  //     userId: jsonData['user_id'] as int,
  //     name: jsonData['name'] as String,
  //     lastname: jsonData['lastname'] as String,
  //     email: jsonData['email'] as String,
  //     street: jsonData['street'] as String,
  //     houseNr: jsonData['house_nr'] as String,
  //     apartmentNr: jsonData['apartment_nr'] as String,
  //     postalCode: jsonData['postal_code'] as String,
  //     city: jsonData['city'] as String,
  //     phoneNumber: jsonData['phone_nr'] as String
  //   );
  // }

  User.fromJson(Map<String, dynamic> jsonData)
      :
      id = jsonData['user_id'],
        name=  jsonData['name'],
        lastname= jsonData['lastname'],
        email = jsonData['email'],
      street = jsonData['street'] ,
      houseNr = jsonData['house_nr'],
      apartmentNr= jsonData['apartment_nr'],
      postalCode= jsonData['postal_code'],
      city= jsonData['city'],
      phoneNumber=  jsonData['phone_nr'];


  }
