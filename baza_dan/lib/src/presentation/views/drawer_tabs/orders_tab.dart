import 'package:baza_dan/injector.dart';
import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/get_orders_bloc/get_orders_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_orders_bloc/get_orders_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_orders_bloc/get_orders_state.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class OrdersTab extends StatefulWidget {
  final User user;
  const OrdersTab({Key? key, required this.user}) : super(key: key);

  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  bool isHiding = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GetOrdersBloc>(context)..add(GetAllOrders(widget.user.id!)),
      child: Scaffold(
        body: buildBody(),
        appBar: buildAppbar(),
      ),
    );
  }

  Widget buildBody(){
    return BlocBuilder<GetOrdersBloc, GetOrdersState>(
        builder: (context, state){
          if(state is GetOrdersDone){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.ordersList!.length,
              itemBuilder: (context, index){
                return _buildPanel(state.ordersList![index]['order_id'], state.ordersList![index]['time'], state.ordersList![index]['total_price'], state.ordersList![index]['status']);
              }
          );
          }else if(state is GetOrdersLoading){
            return buildSpinner();
          }else if(state is GetOrdersEmpty){
            return Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                child: Column(
                  children: const [
                    Icon(
                      LineIcons.exclamationCircle,
                      size: 70,
                      color: mainOrange,
                    ),
                    Text(
                      'Jeszcze niczego nie zamówiłeś! Może skusisz się na małe co nieco?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: mainOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else{
            return Text('Coś poszło nie tak!');
          }
        }
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Historia zamówień',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPanel(String orderId, String date, String price, String status){
    return BlocProvider<GetDetailsBloc>(
      create: (getDetailsContext){
        return GetDetailsBloc(injector());
      },
      child: Builder(
        builder: (getDetailsContext) {
          return BlocProvider.value(
            value: BlocProvider.of<GetDetailsBloc>(getDetailsContext)..add(GetAllDetails(orderId)),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    LineIcons.shoppingBag,
                    color: mainOrange,
                    size: 60,
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nr. zamówienia: $orderId",
                        style: TextStyle(
                            color: mainOrange
                        ),
                      ),
                      Text(
                        "Data: $date",
                        style: TextStyle(
                            color: mainGrey
                        ),
                      ),
                      Text(
                        "Suma: $price" ,
                        style: TextStyle(
                            color: mainGrey
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "$status",
                            style: TextStyle(
                                color: (status == 'dostarczone') ? Colors.green : mainOrange
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<GetDetailsBloc, GetDetailsState>(
                        builder: (context, state){
                          if(state is GetDetailsDone){
                            return Card(
                              elevation: 0,
                              child: Column(
                                children: [
                                  Container(
                                    //height: MediaQuery.of(context).size.height/5,
                                    width: MediaQuery.of(context).size.width/2,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: state.details!.length,
                                        itemBuilder: (context, index){
                                          print(state.details![index]['price']);
                                          print(state.details![index]['amount']);
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.details![index]['amount'].toString()+' x '+state.details![index]['name'].toString(),
                                                style: TextStyle(
                                                    color: mainGrey
                                                ),
                                              ),
                                              Text(
                                                double.parse(state.details![index]['price']).toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: mainGrey
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else if(state is GetDetailsLoading){
                            return Center();
                          }else{
                            return Text('Coś poszło nie tak!');
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
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

}
