import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_state.dart';
import 'package:baza_dan/src/presentation/views/reservation_summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class ReservationTab extends StatefulWidget {
  final User user;
  const ReservationTab({Key? key, required this.user}) : super(key: key);

  @override
  _ReservationTabState createState() => _ReservationTabState();
}

class _ReservationTabState extends State<ReservationTab> {
  String _selectedDate = 'Naciśnij, aby wybrać';
  String _selectedTime = 'Naciśnij, aby wybrać';
  String _selectedtable = 'Nie wybrano';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _buildExpandedList(),
          ),
        ),
        Container(
          height: 60.0,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: mainGrey, width: 1.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Wybrany stolik: '+_selectedtable,
                  style: TextStyle(
                      color: mainGrey,
                      fontSize: 15
                  ),
                ),
                buildReserveButton()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedList() {
    if(_selectedDate != "Naciśnij, aby wybrać" && _selectedTime != "Naciśnij, aby wybrać"){
      return BlocProvider.value(
        value: BlocProvider.of<GetTablesBloc>(context)..add(GetTables(_selectedDate +' '+ _selectedTime)),
        child: ExpansionPanelList(
            children: [
              _buildDatePanel(),
              _buildHourPanel(),
              _buildTablePanel()
            ],
            expansionCallback: (i, isOpen) =>
                setState(() =>
                    print('x')
                )
        ),
      );
    }else{
      return ExpansionPanelList(
          children: [
            _buildDatePanel(),
            _buildHourPanel(),
            _buildBackupTablePanel()
          ],
          expansionCallback: (i, isOpen) =>
              setState(() =>
                  print('x')
              )
      );
    }
    
  }

  ExpansionPanel _buildBackupTablePanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.chair,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              '3. Wybierz stolik',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: Text(
        "Wybierz najpierw datę i godzinę!"
      )
    );
  }

  ExpansionPanel _buildDatePanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.calendar,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              '1. Wybierz datę',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: mainGrey),
                    left: BorderSide(width: 1.0, color: mainGrey),
                    right: BorderSide(width: 1.0, color: mainGrey),
                    bottom: BorderSide(width: 1.0, color: mainGrey),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                          _selectedDate,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: mainGrey)
                      ),
                      onTap: (){
                        _selectDate(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today,
                        color: mainGrey,
                      ),
                      tooltip: 'Naciśnij, aby otworzyć okno wyboru daty',
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      isExpanded: true,
      canTapOnHeader: true,

    );
  }

  ExpansionPanel _buildHourPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(Icons.access_time,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              '2. Wybierz godzinę',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: mainGrey),
                    left: BorderSide(width: 1.0, color: mainGrey),
                    right: BorderSide(width: 1.0, color: mainGrey),
                    bottom: BorderSide(width: 1.0, color: mainGrey),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                          _selectedTime,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: mainGrey)
                      ),
                      onTap: (){
                        _selectTime(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time,
                        color: mainGrey,
                      ),
                      tooltip: 'Naciśnij, aby otworzyć okno wyboru godziny',
                      onPressed: () {
                        _selectTime(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      isExpanded: true,
      canTapOnHeader: true,

    );
  }

  ExpansionPanel _buildTablePanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.chair,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              '3. Wybierz stolik',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<GetTablesBloc, GetTablesState>(
        builder: (context, state){
          if(state is GetTablesDone){
            print("THE 3RD TABLE IS ${state.data!['3']}");
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    height: MediaQuery.of(context). size.height/3,
                    decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: mainGrey),
                          left: BorderSide(width: 1.0, color: mainGrey),
                          right: BorderSide(width: 1.0, color: mainGrey),
                          bottom: BorderSide(width: 1.0, color: mainGrey),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            //STOLIK 10
                            Positioned(
                                right: MediaQuery.of(context).size.height/30,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: 0,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/43)*1.5 + MediaQuery.of(context).size.width/6,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30,
                                top: MediaQuery.of(context).size.height/20 +MediaQuery.of(context).size.height/43,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: MediaQuery.of(context).size.height/20 + MediaQuery.of(context).size.height/43,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30,
                                top: MediaQuery.of(context).size.height/40,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['10']!='0'){
                                      setState(() {
                                        _selectedtable = '10';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.width/6,
                                    color: getColor(state, '10'),
                                  ),
                                )
                            ),


                            //STOLIK 11
                            Positioned(
                                right: (MediaQuery.of(context).size.height/43)*2.7 + MediaQuery.of(context).size.width/6,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/43)*3.9 + (MediaQuery.of(context).size.width/6)*2,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*1.6,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*1.6 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*1.6,
                                top: MediaQuery.of(context).size.height/43 +MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*1.6 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: MediaQuery.of(context).size.height/43+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*1.6,
                                top: MediaQuery.of(context).size.height/40,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['11']!='0'){
                                      setState(() {
                                        _selectedtable = '11';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.width/6,
                                    color: getColor(state, '11'),
                                  ),
                                )
                            ),


                            //STOLIK 12
                            Positioned(
                                right: (MediaQuery.of(context).size.height/43)*5.4 + (MediaQuery.of(context).size.width/6)*2,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/43)*6.8 + (MediaQuery.of(context).size.width/6)*3,
                                top: MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/55,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*3,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*3 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: 0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*3,
                                top: MediaQuery.of(context).size.height/43+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*3 +MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/43,
                                top: MediaQuery.of(context).size.height/43+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '12'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: (MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.width/6)*3,
                                top: MediaQuery.of(context).size.height/40,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['12']!='0'){
                                      setState(() {
                                        _selectedtable = '12';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.width/6,
                                    color: getColor(state, '12'),
                                  ),
                                )

                            ),

                            //STOLIK 7

                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '7'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '7'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30,
                                top: MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['7']!='0'){
                                      setState(() {
                                        _selectedtable = '7';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.height/20,
                                    color:getColor(state, '7'),
                                  ),
                                )
                            ),

                            //STOLIK 8
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '8'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color:getColor(state, '8'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/30)*2,
                                top: MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['8']!='0'){
                                      setState(() {
                                        _selectedtable = '8';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.height/20,
                                    color: getColor(state, '8'),
                                  ),
                                )
                            ),

                            //STOLIK 9
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*2 + (MediaQuery.of(context).size.height/30)*4+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '9'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*2 + (MediaQuery.of(context).size.height/30)*4+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '9'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*2 + (MediaQuery.of(context).size.height/30)*4,
                                top: MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['9']!='0'){
                                      setState(() {
                                        _selectedtable = '9';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.height/20,
                                    color: getColor(state, '9'),
                                  ),
                                )
                            ),

                            //STOLIK 1
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+MediaQuery.of(context).size.height/20,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '1'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*2+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '1'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6,
                                top: MediaQuery.of(context).size.height/40 + MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['1']!='0'){
                                      setState(() {
                                        _selectedtable = '1';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.height/20,
                                    color: getColor(state, '1'),
                                  ),
                                )
                            ),

                            //STOLIK 2
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*3+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '2'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6+ MediaQuery.of(context).size.height/86,
                                top: (MediaQuery.of(context).size.height/43)*4+(MediaQuery.of(context).size.height/20)*3.7,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '2'),
                                  ),
                                )
                            ),
                            Positioned(
                                right: MediaQuery.of(context).size.height/30 + (MediaQuery.of(context).size.height/20)*3 + (MediaQuery.of(context).size.height/30)*6,
                                top: MediaQuery.of(context).size.height/40 + (MediaQuery.of(context).size.height/20)*2 + (MediaQuery.of(context).size.height/40)*4,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['2']!='0'){
                                      setState(() {
                                        _selectedtable = '2';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    width: MediaQuery.of(context).size.height/20,
                                    color: getColor(state, '2'),
                                  ),
                                )
                            ),

                            //STOLIK 13
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  MediaQuery.of(context).size.height/43,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  MediaQuery.of(context).size.height/43,
                                bottom:MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  MediaQuery.of(context).size.height/43,
                                bottom:(MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/86)*2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  (MediaQuery.of(context).size.height/43)*2 + MediaQuery.of(context).size.height/15,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  (MediaQuery.of(context).size.height/43)*2 + MediaQuery.of(context).size.height/15,
                                bottom:MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  (MediaQuery.of(context).size.height/43)*2 + MediaQuery.of(context).size.height/15,
                                bottom:(MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/86)*2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  MediaQuery.of(context).size.height/43 + MediaQuery.of(context).size.height/20,
                                top: (MediaQuery.of(context).size.height/43)*3+(MediaQuery.of(context).size.height/20)*2.6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*2,
                                bottom:-8,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['13']!='0'){
                                      setState(() {
                                        _selectedtable = '13';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/10,
                                    width: MediaQuery.of(context).size.height/15,
                                    color: getColor(state, '13'),
                                  ),
                                )
                            ),

                            //STOLIK 4
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  (MediaQuery.of(context).size.height/43)*3.1 + MediaQuery.of(context).size.height/15,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '4'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +MediaQuery.of(context).size.height/15+  (MediaQuery.of(context).size.height/43)*4.3 + MediaQuery.of(context).size.height/15,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '4'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*4 + MediaQuery.of(context).size.height/15,
                                bottom:-8,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['4']!='0'){
                                      setState(() {
                                        _selectedtable = '4';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/30,
                                    width: MediaQuery.of(context).size.height/15,
                                    color: getColor(state, '4'),
                                  ),
                                )
                            ),

                            //STOLIK 5
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +MediaQuery.of(context).size.height/15+  (MediaQuery.of(context).size.height/43)*5.4 + MediaQuery.of(context).size.height/15,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '5'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +(MediaQuery.of(context).size.height/15)*2+  (MediaQuery.of(context).size.height/43)*6.5 + MediaQuery.of(context).size.height/15,
                                bottom:0,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '5'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*6 +(MediaQuery.of(context).size.height/15)*2,
                                bottom:-8,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['5']!='0'){
                                      setState(() {
                                        _selectedtable = '5';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/30,
                                    width: MediaQuery.of(context).size.height/15,
                                    color: getColor(state, '5'),
                                  ),
                                )
                            ),

                            //STOLIK 6
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +MediaQuery.of(context).size.height/15+  (MediaQuery.of(context).size.height/43)*5.4 + MediaQuery.of(context).size.height/15,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '6'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +(MediaQuery.of(context).size.height/15)*2+  (MediaQuery.of(context).size.height/43)*6.5 + MediaQuery.of(context).size.height/15,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '6'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*4 + MediaQuery.of(context).size.height/15,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['6']!='0'){
                                      setState(() {
                                        _selectedtable = '6';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/30,
                                    width: MediaQuery.of(context).size.height/15,
                                    color: getColor(state, '6'),
                                  ),
                                )
                            ),



                            //STOLIK 3
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +  (MediaQuery.of(context).size.height/43)*3.1 + MediaQuery.of(context).size.height/15,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '3'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 +MediaQuery.of(context).size.height/15+  (MediaQuery.of(context).size.height/43)*4.3 + MediaQuery.of(context).size.height/15,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2 + MediaQuery.of(context).size.height/86,
                                child: Container(
                                  height: MediaQuery.of(context).size.height/43,
                                  width: MediaQuery.of(context).size.height/43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: getColor(state, '3'),
                                  ),
                                )
                            ),
                            Positioned(
                                left: MediaQuery.of(context).size.height/20 + (MediaQuery.of(context).size.height/40)*6 +(MediaQuery.of(context).size.height/15)*2,
                                bottom:-8 + (MediaQuery.of(context).size.height/30)*2,
                                child: InkWell(
                                  onTap: (){
                                    if(state.data!['3']!='0'){
                                      setState(() {
                                        _selectedtable = '3';
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/30,
                                    width: MediaQuery.of(context).size.height/15,
                                    color: getColor(state, '3'),
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            );
          }else if(state is GetTablesLoading){
            return buildSpinner();
          }else if(state is GetTablesWrongHour){
            return Text('Prosimy o wybranie terminu w godzinach otwarcia restauracji! (10-22)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainGrey
              ),
            );
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: true,
      canTapOnHeader: true,

    );
  }

  Widget buildSpinner(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: const SpinKitCircle(
        color: mainOrange,
        size: 20,
      ),
    );
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 14)),
    );
    if (d != null) {
      setState(() {
        _selectedDate = new DateFormat('yyyy-MM-dd').format(d).toString();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? d = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),

    );
    if (d != null) {
      setState(() {
        _selectedTime = d.format(context).toString();
        _selectedTime = _selectedTime + ":00";
        // DateTime date= DateFormat.jm().parse(_selectedTime);
        // String tempDate =(DateFormat("HH:mm").format(date));
        // _selectedTime = tempDate;
      });
    }
  }

  Widget buildReserveButton(){
    return RawMaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ReservationSummaryView(user: widget.user, selectedDate: _selectedDate, selectedTable: _selectedtable,selectedTime: _selectedTime,)));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text('Podsumowanie'),
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

  Color getColor(GetTablesState state, String index){
    print('THE DATA INDEX STATE IS ${state.data![index]}');
    //print(int.parse(state.data!['$index']));
    if(state.data!["$index"].toString() == '1' && _selectedtable.toString() != index){
      print('this one!');
      return Colors.green;
    }else if(_selectedtable.toString() == index){
      return mainOrange;
    }else{
      print('weszło tutaj');
      return mainGrey;
    }
  }

}
