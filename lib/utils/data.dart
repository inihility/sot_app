import '../models/island.dart';
import '../models/region.dart';
import '../models/location_animal.dart';

class Data{
  Data._privateConstructor();

  static final Data instance = Data._privateConstructor();

  List<Island> islands = new List();
  List<Region> regions = new List();
  List<LocationAnimal> location_chickens = new List();
  List<LocationAnimal> location_pigs = new List();
  List<LocationAnimal> location_snakes = new List();
}