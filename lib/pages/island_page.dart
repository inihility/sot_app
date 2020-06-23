import 'package:flutter/material.dart';
import 'package:sot_app/utils/data.dart';
import '../utils/db.dart';
import '../models/island.dart';
import '../models/region.dart';
import '../models/location_animal.dart';
import '../UI/island_listview.dart';
import '../utils/constants.dart' as Constants;
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class IslandPage extends StatefulWidget {
  IslandPage({Key key}) : super(key: key);

  @override
  _IslandPageState createState() => _IslandPageState();
}

class _IslandPageState extends State<IslandPage> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //  child: IslandListView()
    //   // child: Image.asset('assets/images/islands_full/ancient_spire_outpost.png')
    // );
    return GestureDetector(
      onTap: () {
        dismissKeyboard();
      },
      onPanDown: (_) {
        dismissKeyboard();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBar<Island>(
              debounceDuration: Duration(milliseconds: 50),
              crossAxisCount: 2,
              onSearch: search,
              onItemFound: (Island island, int index) {
                return EachCell(island);
              },
              placeHolder: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: Data.instance.islands.length,
                // shrinkWrap: widget.shrinkWrap,
                staggeredTileBuilder: (int index) => ScaledTile.fit(1),
                // scrollDirection: widget.scrollDirection,
                // mainAxisSpacing: widget.mainAxisSpacing,
                // crossAxisSpacing: widget.crossAxisSpacing,
                addAutomaticKeepAlives: true,
                itemBuilder: (BuildContext context, int index) {
                  return EachCell(Data.instance.islands[index]);
                },
              ),
              minimumChars: 1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("<<< Initializing database data >>>");
    print("Loading islands from DB...");
    Db.instance.getIslands().then((List<Island> islands) {
      print("Islands loaded.");
      islands.sort((a, b) => a.name.compareTo(b.name));
      Data.instance.islands = islands;
      print("Loading regions from DB...");
      Db.instance.getRegions().then((List<Region> regions) {
        print("Regions loaded.");
        Data.instance.regions = regions;
        print("Loading chicken locations from DB...");
        Db.instance
            .getAnimal(Constants.LOCATION_CHICKEN_TABLE)
            .then((List<LocationAnimal> chickens) {
          print("Chicken locations loaded.");
          Data.instance.location_chickens = chickens;
          print("Loading pig locations from DB...");
          Db.instance
              .getAnimal(Constants.LOCATION_PIG_TABLE)
              .then((List<LocationAnimal> pigs) {
            print("Pig locations loaded.");
            Data.instance.location_pigs = pigs;
            print("Loading snake locations from DB...");
            Db.instance
                .getAnimal(Constants.LOCATION_SNAKE_TABLE)
                .then((List<LocationAnimal> snakes) {
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

  void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<List<Island>> search(String search) async {
    // await Future.delayed(Duration(seconds: 0));
    List<Island> newList = new List();
    for (final island in Data.instance.islands) {
      if (Constants.EMOJI_CHICKENS.contains(search.trim())) {
        for (final chicken in Data.instance.location_chickens) {
          if (chicken.id == island.id) {
            newList.add(island);
            break;
          }
        }
      } else if (Constants.EMOJI_SNAKES.contains(search.trim())) {
        for (final snake in Data.instance.location_snakes) {
          if (snake.id == island.id) {
            newList.add(island);
            break;
          }
        }
      } else if (Constants.EMOJI_PIGS.contains(search.trim())) {
        for (final pig in Data.instance.location_pigs) {
          if (pig.id == island.id) {
            newList.add(island);
            break;
          }
        }
      } else if (Constants.EMOJI_DEVILS_ROAR.contains(search.trim()) &&
          island.region == Constants.REGION_DEVILS_ROAR) {
        newList.add(island);
      } else if (search.trim().toLowerCase() == Constants.ISLAND_TYPE_SEAPOST &&
          island.type == Constants.ISLAND_TYPE_SEAPOST) {
        newList.add(island);
      } else if (search.contains(' ') && search.length > 2) {
        if (island.name.toLowerCase().contains(search.toLowerCase())) {
          newList.add(island);
        }
      } else {
        List<String> words = island.name.split(' ');
        for (final word in words) {
          if (word.toLowerCase().startsWith(search.toLowerCase())) {
            newList.add(island);
            break;
          }
        }
      }
    }
    return newList;
  }
}
