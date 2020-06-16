import 'db.dart';
import '../models/island.dart';

class Data{
  Data._privateConstructor();

  static final Data instance = Data._privateConstructor();

  static List<Island> _islands;

  Future<List<Island>> get islands async{
    if(_islands != null) return _islands;
    _islands = await Db.instance.getIslands();
    _islands.sort((a, b) => a.name.compareTo(b.name));
    return _islands;
  }
}