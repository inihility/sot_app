import 'package:flutter/material.dart';
import 'package:sot_app/utils/data.dart';
import '../utils/db.dart';
import '../models/island.dart';
import '../UI/island_listview.dart';

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
    // Data.instance.islands.then((value) => value.forEach((element) {
    //   print(element.name);
    // }));
    // Db.instance.listIslands();
    // Db.instance.listTables();
  }
}