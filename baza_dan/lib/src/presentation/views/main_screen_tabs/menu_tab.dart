import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_event.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_state.dart';
import 'package:baza_dan/src/presentation/widgets/food_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';

class MenuTab extends StatefulWidget {
  List<Food>? cart;
  List<int>? cartAmounts;
  MenuTab({Key? key, this.cart, this.cartAmounts}) : super(key: key);

  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  final List <bool> _isOpen=[true, true, true, true, true, true, true];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FastFoodBloc>(context)..add(GetFastFood('fast')),
      child: BlocProvider.value(
        value: BlocProvider.of<BurgerBloc>(context)..add(GetSandwiches('kanapka')),
        child: BlocProvider.value(
          value: BlocProvider.of<DishListBloc>(context)..add(GetDishes('danie')),
          child: BlocProvider.value(
            value: BlocProvider.of<PastaListBloc>(context)..add(GetPasta('makaron')),
            child: BlocProvider.value(
              value: BlocProvider.of<PizzaBloc>(context)..add(GetPizza('pizza')),
              child: BlocProvider.value(
                value: BlocProvider.of<DrinksBloc>(context)..add(GetDrinks('napoje')),
                child: BlocProvider.value(
                  value: BlocProvider.of<ExtrasBloc>(context)..add(GetExtras('dodatki')),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      child: _buildExpandedList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedList() {
    return ExpansionPanelList(
        children: [
          _buildFastPanel(),
          _buildBurgerPanel(),
          _buildDishPanel(),
          _buildPastaPanel(),
          _buildPizzaPanel(),
          _buildExtraPanel(),
          _buildDrinksPanel()
        ],
        expansionCallback: (i, isOpen) =>
            setState(() =>
            _isOpen[i] = !isOpen
            )
    );
  }

  ExpansionPanel _buildFastPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.drumstickWithBiteTakenOut,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Szybkie kąski',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<FastFoodBloc, FastFoodState>(
        builder: (context, state){
          if(state is FastListDone){
            return _buildFoodsList(state.food!);
          }else if(state is FastListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[0],
      canTapOnHeader: true,

    );
  }

  Widget _buildFoodsList(List<Food> foodList){
    return Container( // ← this guy
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
          itemCount: foodList.length,
          itemBuilder: (context, index){
            return FoodWidget(
              food: foodList[index],
            );
          }
      ),
    );
  }

  ExpansionPanel _buildBurgerPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.hamburger,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Kanapki',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<BurgerBloc, BurgerState>(
        builder: (context, state){
          if(state is BurgerListDone){
            return _buildFoodsList(state.food!);
          }else if(state is BurgerListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[1],
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildDishPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.fish,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Dania',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<DishListBloc, DishState>(
        builder: (context, state){
          if(state is DishListDone){
            return _buildFoodsList(state.food!);
          }else if(state is DishListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[2],
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildPastaPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.pastafarianism,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Makarony',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<PastaListBloc, PastaState>(
        builder: (context, state){
          if(state is PastaListDone){
            return _buildFoodsList(state.food!);
          }else if(state is PastaListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[3],
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildPizzaPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.pizzaSlice,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Pizze',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<PizzaBloc, PizzaState>(
        builder: (context, state){
          if(state is PizzaListDone){
            return _buildFoodsList(state.food!);
          }else if(state is PizzaListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[4],
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExtraPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.lemon,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Dodatki',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<ExtrasBloc, ExtrasState>(
        builder: (context, state){
          if(state is ExtrasListDone){
            return _buildFoodsList(state.food!);
          }else if(state is ExtrasListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[5],
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildDrinksPanel(){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: 10),
            Icon(
              LineIcons.glassWhiskey,
              color: mainOrange,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Napoje',
              style: TextStyle(
                color: mainOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      body: BlocBuilder<DrinksBloc, DrinksState>(
        builder: (context, state){
          if(state is DrinksListDone){
            return _buildFoodsList(state.food!);
          }else if(state is DrinksListLoading){
            return buildSpinner();
          }else{
            return Text('Coś poszło nie tak!');
          }
        },
      ),
      isExpanded: _isOpen[6],
      canTapOnHeader: true,
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
