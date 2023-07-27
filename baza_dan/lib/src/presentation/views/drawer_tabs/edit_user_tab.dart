import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_event.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditUserTab extends StatefulWidget {
  User user;
  EditUserTab({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserTabState createState() => _EditUserTabState();
}

class _EditUserTabState extends State<EditUserTab> {
  late User user;
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    phoneController.text = user.phoneNumber;
    streetController.text = user.street;
    homeController.text = user.houseNr;
    if(user.apartmentNr != null){
      apartmentController.text = user.apartmentNr!;
    }
    nameController.text = user.name;
    lastNameController.text = user.lastname;
    codeController.text = user.postalCode;
    cityController.text = user.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return BlocListener<EditUserBloc, EditUserState>(
      listener: (context, state){
        if(state is EditUserError){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Coś poszło nie tak! Czy wypełniłeś poprawnie wszystkie pola?'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }else if(state is EditUserDone){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Zaktualizowano dane użytkownika!'), backgroundColor: mainOrange, duration: Duration(milliseconds: 400),));
          user.name = nameController.text;
          user.lastname =  lastNameController.text;
          user.street =  streetController.text;
          user.houseNr = homeController.text;
          if(apartmentController.text.isNotEmpty){
            user.apartmentNr = apartmentController.text;
          }
          user.postalCode = codeController.text;
          user.city = cityController.text;
          user.phoneNumber= phoneController.text;
        }else if(state is EditUserLoading){
          context.loaderOverlay.show();
        }
      },
      child: LoaderOverlay(
        overlayOpacity: 0.8,
        overlayColor: lightOrange,
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: mainOrange,
            size: 50.0,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: Text('Przeprowadziłeś się? Nic nie szkodzi! Baza dań jest zawsze tam gdzie ty!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainOrange,
                      fontSize: 20,
                    ),
                  ),
                ),
                buildEditForm(),
                buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Edytuj dane',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildEditForm(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ThemeData().colorScheme.copyWith(
                        primary: mainOrange,
                      ),
                      fontFamily: 'Montserrat',
                    ),
                    child: TextFormField(
                      //EDIT TEXT CONTROLLER
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Imię",
                        prefixIcon: const Icon(Icons.account_box_outlined, size: 24),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      controller: nameController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onFieldSubmitted: (String value){

                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 110,
                    child: Theme(
                      data: ThemeData(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: mainOrange,
                        ),
                        fontFamily: 'Montserrat',
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: mainOrange,
                          ),
                          labelText: "Nazwisko",
                          prefixIcon: const Icon(Icons.account_box, size: 24),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainGrey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainOrange,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: lastNameController,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        onFieldSubmitted: (String value){

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ThemeData().colorScheme.copyWith(
                        primary: mainOrange,
                      ),
                      fontFamily: 'Montserrat',
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Ulica",
                        prefixIcon: const Icon(Icons.map, size: 24),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      controller: streetController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onFieldSubmitted: (String value){

                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 110,
                    child: Theme(
                        data: ThemeData(
                          colorScheme: ThemeData().colorScheme.copyWith(
                            primary: mainOrange,
                          ),
                          fontFamily: 'Montserrat',
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 330,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  floatingLabelStyle: const TextStyle(
                                    color: mainOrange,
                                  ),
                                  labelText: "Nr. domu",
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainGrey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainOrange,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                controller: homeController,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                                onFieldSubmitted: (String value){

                                },
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width - 330,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  floatingLabelStyle: const TextStyle(
                                    color: mainOrange,
                                  ),
                                  labelText: "Nr. miesz.",
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainGrey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainOrange,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                controller: apartmentController,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                                onFieldSubmitted: (String value){

                                },
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width - 293,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  floatingLabelStyle: const TextStyle(
                                    color: mainOrange,
                                  ),
                                  labelText: "Kod",
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainGrey,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: mainOrange,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                controller: codeController,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                                onFieldSubmitted: (String value){

                                },
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ThemeData().colorScheme.copyWith(
                        primary: mainOrange,
                      ),
                      fontFamily: 'Montserrat',
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Miasto",
                        prefixIcon: const Icon(Icons.location_city, size: 24),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      controller: cityController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onFieldSubmitted: (String value){

                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 110,
                    child: Theme(
                      data: ThemeData(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: mainOrange,
                        ),
                        fontFamily: 'Montserrat',
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: mainOrange,
                          ),
                          labelText: "Numer telefonu",
                          prefixIcon: const Icon(Icons.phone, size: 24),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainGrey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainOrange,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: phoneController,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        onFieldSubmitted: (String value){

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSaveButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RawMaterialButton(
        onPressed: (){
          late Map<String, String> credentials;
          if(apartmentController.text.isNotEmpty){
            credentials = {
              'user_id':user.id!,
              'name':nameController.text,
              'lastname' : lastNameController.text,
              'street' : streetController.text,
              'house_nr' : homeController.text,
              'apartment_nr': apartmentController.text,
              'postal_code': codeController.text,
              'city' : cityController.text,
              'phone_nr' : phoneController.text
            };
          }else{
            credentials = {
              'user_id':user.id!,
              'name':nameController.text,
              'lastname' : lastNameController.text,
              'street' : streetController.text,
              'house_nr' : homeController.text,
              'postal_code': codeController.text,
              'city' : cityController.text,
              'phone_nr' : phoneController.text
            };
          }
          BlocProvider.of<EditUserBloc>(context).add(EditUser(credentials));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Zapisz'),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontSize: 17,
        ),
        elevation: 0,
        fillColor: mainOrange,
      ),
    );
  }

}
