import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_state.dart';
import 'package:baza_dan/src/presentation/widgets/recommended_food_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class MainViewTab extends StatefulWidget {
  final User user;
  const MainViewTab({Key? key, required this.user}) : super(key: key);

  @override
  _MainViewTabState createState() => _MainViewTabState();
}

class _MainViewTabState extends State<MainViewTab> {
  DateTime currentTime = DateTime.now();
  late String currentTimeOfDay;
  late int currH;
  List<String> carrouselPhotos = ["assets/carrousel/carrousel1.jpg",
    "assets/carrousel/carrousel2.jpg",
    "assets/carrousel/carrousel3.jpg",
    "assets/carrousel/carrousel5.jpg",
  ];

  @override
  void initState() {
    String currentHour = DateFormat('HH').format(currentTime);
    currH = int.parse(currentHour);
    currentTimeOfDay = getCurrentTimeOfDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GetRandomFoodBloc>(context)..add(GetRandomFood()),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              Text(
                currentTimeOfDay,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: mainOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Polecane:",
                    style: const TextStyle(
                        color: mainOrange,
                        fontSize: 20,
                        letterSpacing: 2
                    ),
                  ),
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height/5)+30,
                child: BlocBuilder<GetRandomFoodBloc, GetRandomFoodState>(
                  builder: (context, state){
                    if(state is GetRandomFoodDone){
                      print(state.foodMap);
                      return _buildFoodsList(state.foodMap!);
                    }else if(state is GetRandomFoodLoading){
                      return buildSpinner();
                    }else{
                      return Text('Coś poszło nie tak!');
                    }
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "O nas:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20,
                        letterSpacing: 2
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Najważniejsze trzy słowa dla Polski, Polaków, naszej kultury, filozofii: wódka, wojna i kiełbasa są rodzaju żeńskiego”\n"
                      "~Robert Makłowicz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainGrey,
                    fontSize: 15,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: CarouselSlider.builder(
                    itemCount: carrouselPhotos.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(carrouselPhotos[itemIndex]),
                              fit: BoxFit.fitHeight
                            )
                          ),
                        ),
                    options:CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 0.5
                    ),
                  ),
                ),
              ),
              Text(
                "Kiedy ostatni raz przechodziłeś obok wszystkich tych wykwintnych restauracji i myślałeś sobie"
                    "\"kurczę, nie ma tu nic do jedzenia!\"? Nas też to często dotykało. Właśnie z takim zamysłem powstała"
                    " Baza Dań. Ma być szybko, smacznie, dla każdego i w miarę tanio (kwestia dyskusyjna). Mamy nadzieję, że nasze "
                    " dopracowane receptury przypadną wszystkim łasuchom do gustu. Mamy w ofercie frytki, więc twój dzieciak będzie"
                    " miał co zjeść. Jedyna wegańska opcja to sałatka. Restauracja mieści się niedaleko centrum Krakowa, żeby "
                    " każdy mieszkaniec miasta miał blisko. W ciagu kilku lat naszej działalności mieliśmy przyjemność gościć"
                    " takie osobistości jak Ewa Wachowicz, Magda Gessler czy Robert Makłowicz. Ten ostatni, który jako jedyny "
                    " zasmakował w naszych potrawach jest patronem naszego przybytku.",
                style: TextStyle(
                    color: mainOrange,
                    fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Kontakt:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20,
                        letterSpacing: 2
                    ),
                  ),
                ),
              ),
              buildAddressDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressDetails(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Baza Dań",
                    style: TextStyle(
                        color: mainOrange,
                      fontSize: 20
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(LineIcons.map,
                    color: mainOrange,
                  ),
                  Text(
                    'ul. Wrocławska 30',
                    style: TextStyle(
                        color: mainGrey,
                        fontSize: 20
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(LineIcons.mapMarker,
                    color: mainOrange,
                  ),
                  Text(
                    '30-011, Kraków',
                    style: TextStyle(
                        color: mainGrey,
                        fontSize: 20
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(LineIcons.phone,
                    color: mainOrange,
                  ),
                  Text(
                    '12 433-27-18',
                    style: TextStyle(
                        color: mainGrey,
                        fontSize: 20
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(LineIcons.at,
                    color: mainOrange,
                  ),
                  Text(
                    'bazadan@kontakt.pl',
                    style: TextStyle(
                        color: mainGrey,
                        fontSize: 20
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(LineIcons.clock,
                    color: mainOrange,
                  ),
                  Text(
                    'pon-nd: 10-22',
                    style: TextStyle(
                        color: mainGrey,
                        fontSize: 20
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  String getCurrentTimeOfDay(){
    print(currH);
    if(currH >6 && currH <=12){
      return "Pora na śniadanie, ${widget.user.name}!";
    }else if(currH > 12 && currH <=18){
      return "Co wybierzesz dzisiaj na obiad, ${widget.user.name}?";
    }else{
      return "Czas na smaczną kolację, ${widget.user.name}!";
    }
  }

  Widget _buildFoodsList(List<Map<String, dynamic>> foodList){
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: foodList.length,
          itemBuilder: (context, index){
          print(foodList[index]['name']);
          print(foodList[index]["food_img"]);
            return RecommendedFoodWidget(foodName: foodList[index]['name'], foodImg: foodList[index]['food_img']);
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
