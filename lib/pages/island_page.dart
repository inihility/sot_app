import 'package:flutter/material.dart';
import 'package:sot_app/utils/data.dart';
import '../utils/db.dart';
import '../models/island.dart';
import '../models/region.dart';
import '../models/location_animal.dart';
import '../UI/island_listview.dart';
import '../utils/constants.dart' as Constants;

class IslandPage extends StatefulWidget {
  IslandPage({Key key}) : super(key: key);

  @override
  _IslandPageState createState() => _IslandPageState();
}

class _IslandPageState extends State<IslandPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: IslandListView()
      // child: Image.asset('assets/images/islands_full/ancient_spire_outpost.png')
    );
  }

  @override
  void initState() { 
    super.initState();
    print("<<< Initializing database data >>>");
    print("Loading islands from DB...");
    Db.instance.getIslands().then((List<Island> islands){
      print("Islands loaded.");
      islands.sort((a, b) => a.name.compareTo(b.name));
      Data.instance.islands = islands;
      print("Loading regions from DB...");
      Db.instance.getRegions().then((List<Region> regions){
        print("Regions loaded.");
        Data.instance.regions = regions;
        print("Loading chicken locations from DB...");
        Db.instance.getAnimal(Constants.LOCATION_CHICKEN_TABLE).then((List<LocationAnimal> chickens){
          print("Chicken locations loaded.");
          Data.instance.location_chickens = chickens;
          print("Loading pig locations from DB...");
          Db.instance.getAnimal(Constants.LOCATION_PIG_TABLE).then((List<LocationAnimal> pigs){
            print("Pig locations loaded.");
            Data.instance.location_pigs = pigs;
            print("Loading snake locations from DB...");
            Db.instance.getAnimal(Constants.LOCATION_SNAKE_TABLE).then((List<LocationAnimal> snakes){
              print("Snake locations loaded.");
              Data.instance.location_snakes = snakes;
              setState(() {
                print("<<< Database initialization complete >>>");
              });
            });
          });
        });
      });
    });
  }
}