import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class ReservationDrawerTab extends StatefulWidget {
  final User user;
  const ReservationDrawerTab({Key? key, required this.user}) : super(key: key);

  @override
  _ReservationDrawerTabState createState() => _ReservationDrawerTabState();
}

class _ReservationDrawerTabState extends State<ReservationDrawerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return BlocProvider.value(
      value: BlocProvider.of<GetReservationsBloc>(context)..add(GetAllReservations(widget.user.id!)),
      child: BlocBuilder<GetReservationsBloc, GetReservationsState>(
          builder: (context, state){
            if(state is GetReservationsDone){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.reservations!.length,
                  itemBuilder: (context, index){
                    return _buildPanel(state.reservations![index]['reserv_id'], state.reservations![index]['time'],state.reservations![index]['reserv_table']);
                  }
              );
            }else if(state is GetReservationsLoading){
              return buildSpinner();
            }else{
              return Text('Coś poszło nie tak!');
            }
          }
      ),
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Moje rezerwacje',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSpinner(){
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: SpinKitCircle(
        color: mainOrange,
        size: 20,
      ),
    );
  }

  Widget _buildPanel(String reservationId, String date, String tableNr){
    print(date);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          const Icon(
            LineIcons.calendarWithDayFocus,
            color: mainOrange,
            size: 60,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nr. rezerwacji: $reservationId",
                style: TextStyle(
                    color: mainOrange
                ),
              ),
              Text(
                "Data: ${date.substring(0,11)}",
                style: TextStyle(
                    color: mainGrey
                ),
              ),
              Text(
                "Godzina: ${date.substring(11, date.length)}",
                style: TextStyle(
                    color: mainGrey
                ),
              ),
              Text(
                "Nr. stolika: $tableNr" ,
                style: TextStyle(
                    color: mainGrey
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    DateTime.parse(date).isAfter(DateTime.now()) ? 'oczekująca' : 'zrealizowana',
                    style: TextStyle(
                        color: DateTime.parse(date).isAfter(DateTime.now()) ? mainOrange : mainGrey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
