import 'package:flutter/material.dart';
import 'package:sot_app/utils/data.dart';
import '../models/island.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../utils/db.dart';

class IslandListView extends StatefulWidget {
  IslandListView({Key key}) : super(key: key);

  @override
  _IslandListViewState createState() => _IslandListViewState();
}

class _IslandListViewState extends State<IslandListView> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
    builder: (BuildContext context, Orientation orientation) {
        return Container(
          child: new GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              childAspectRatio: 0.7),
            reverse: false,
            itemBuilder: (_, int index) => EachCell(Data.instance.islands[index]),
            itemCount: Data.instance.islands.length,
          ),
        );
      },
    );
  }
}

class EachCell extends StatelessWidget {
  final Island island;
  EachCell(this.island);
  @override
  Widget build(BuildContext context) {
    // print(island.id);
    String path = 'assets/images/islands_full/' + island.id + '.png';
    if (!island.has_image){
      path = 'assets/images/islands_full/default.png';
    }
    return new Card(
      child: InkWell(
        onTap: () => showBarModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context, scrollController) =>
                                Image.asset(path),
                          ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset('assets/images/map/island_bg01.png'),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(path))
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(right: 10.0)),
              SizedBox(
                height: 4,
              ),
              Text(
                island.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      island.coord,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Spacer(),
                  ] + getAnimalIcons(island.id),
                ),
              ),
              // Row(
              //   children: <Widget>[
              //     Text(
              //       island.coord,
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 16.0),
              //     ),
              //     Spacer(),
              //   ] + getAnimalIcons(island.id),
              // ),
              // Text(
              //   island.coord,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 16.0),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: getAnimalIcons(island.id),
              // )
            ],
          ),
        ),
      )
    );
  }

  List<Widget> getAnimalIcons(String id){
    List<Widget> icons = List();
    double iconSize = 32;
    if ((Data.instance.location_chickens.singleWhere((it) => it.id == id,
      orElse: () => null)) != null) {
        icons.add(Image.asset('assets/images/icon_chicken.png', height: iconSize, width: iconSize));
    }
    if ((Data.instance.location_pigs.singleWhere((it) => it.id == id,
      orElse: () => null)) != null) {
        icons.add(Image.asset('assets/images/icon_pig.png', height: iconSize, width: iconSize));
    }
    if ((Data.instance.location_snakes.singleWhere((it) => it.id == id,
      orElse: () => null)) != null) {
        icons.add(Image.asset('assets/images/icon_snake.png', height: iconSize, width: iconSize));
    }
    return icons;
  }
}