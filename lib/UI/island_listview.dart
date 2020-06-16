import 'package:flutter/material.dart';
import 'package:sot_app/utils/data.dart';
import '../models/island.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

class IslandListView extends StatefulWidget {
  IslandListView({Key key}) : super(key: key);

  @override
  _IslandListViewState createState() => _IslandListViewState();
}

class _IslandListViewState extends State<IslandListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Data.instance.islands,
      builder: (context, snapshot, ){
         switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container(
              alignment: Alignment.center,
              child: Text("Loading"),
            );
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              // return whatever you'd do for this case, probably an error
              return Container(
                alignment: Alignment.center,
                child: Text("Error: ${snapshot.error}"),
              );
            }
            List<Island> data = snapshot.data;
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return Container(
                  child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                      childAspectRatio: 0.75),
                    reverse: false,
                    itemBuilder: (_, int index) => EachList(data[index]),
                    itemCount: data.length,
                  ),
                );
              },
            );
            break;
        }
      },
    );
  }
}

class EachList extends StatelessWidget {
  final Island island;
  EachList(this.island);
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
        child: new Container(
          padding: EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              // new CircleAvatar(
              //   radius: 64,
              //   child: Image.asset(path),
              // ),
              Image.asset(path),
              new Padding(padding: EdgeInsets.only(right: 10.0)),
              new Text(
                island.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
      )
    );
  }
}