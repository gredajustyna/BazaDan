import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_event.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_state.dart';
import 'package:baza_dan/src/presentation/views/splash_screens/register_success_view.dart';
import 'package:baza_dan/src/presentation/views/splash_screens/reservation_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ReservationSummaryView extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedTable;
  final User user;
  const ReservationSummaryView({Key? key,required this.user,required this.selectedDate, required this.selectedTime, required this.selectedTable}) : super(key: key);

  @override
  _ReservationSummaryViewState createState() => _ReservationSummaryViewState();
}

class _ReservationSummaryViewState extends State<ReservationSummaryView> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomContainer(),
    );
  }


  Widget buildBody(){
    return BlocListener<ReserveBloc, ReserveState>(
      listener: (context, state){
        if(state is ReserveError){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Ups! Wystąpił błąd!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }else if(state is ReserveLoading){
          context.loaderOverlay.show();
        }else if(state is ReserveDone){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ReservationSuccessView(user: widget.user)), (route) => false);
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Szczegóły rezerwacji:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildReservationDetails(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dane osobowe:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildAddressDetails(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Uwagi do rezerwacji:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildComments(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReservationDetails(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(LineIcons.calendar,
                  color: mainGrey,
                ),
                Text(
                  "Data rezerwacji: ${widget.selectedDate}",
                  style: TextStyle(
                      color: mainOrange
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time,
                  color: mainGrey,
                ),
                Text(
                  "Godzina rezerwacji: ${widget.selectedTime}",
                  style: TextStyle(
                      color: mainGrey
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.chair,
                  color: mainGrey,
                ),
                Text(
                  "Numer stolika: ${widget.selectedTable}" ,
                  style: TextStyle(
                      color: mainGrey
                  ),
                ),
              ],
            ),
          ],
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
        'Podsumowanie',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildAddressDetails(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(LineIcons.userAlt,
                  color: mainGrey,
                ),
                Text(
                  widget.user.name+' '+widget.user.lastname,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.phone,
                  color: mainGrey,
                ),
                Text(
                  widget.user.phoneNumber.substring(0,3)+'-'+widget.user.phoneNumber.substring(3,6)+'-'+widget.user.phoneNumber.substring(6,9),
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.at,
                  color: mainGrey,
                ),
                Text(
                  widget.user.email,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomContainer(){
    return BottomAppBar(
      child: Container(
        height: 60.0,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: mainGrey, width: 1.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildReserveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReserveButton(){
    return RawMaterialButton(
      onPressed: (){
        if(commentController.text.isNotEmpty){
          Map<String, String> orderMap = {
            "user_id" : widget.user.id!,
            "wanted_time" : widget.selectedDate +' '+ widget.selectedTime,
            "table_id" : widget.selectedTable,
            "comments" : commentController.text
          };
          BlocProvider.of<ReserveBloc>(context).add(ReserveTable(orderMap));
        }else{
          Map<String, String> orderMap = {
            "user_id" : widget.user.id!,
            "wanted_time" : widget.selectedDate +' '+ widget.selectedTime,
            "table_id" : widget.selectedTable,
          };
          BlocProvider.of<ReserveBloc>(context).add(ReserveTable(orderMap));
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text('Rezerwuj'),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontSize: 17,
      ),
      elevation: 0,
      fillColor: mainOrange,
    );
  }

  Widget buildComments(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Chcesz nam coś przekazać? To idealny moment!",
                style: TextStyle(
                    color: mainGrey
                ),
              ),
            ),
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
                    labelText: "Dodaj uwagi do rezerwacji",
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
                  controller: commentController,
                  maxLines: 10,
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
    );
  }

}
