import 'package:bus_stop_develop_admin/models/destination/destination.dart';
import 'package:flutter/cupertino.dart';

class LocationsProvider extends ChangeNotifier{
  Destination? _destinationFrom;
  Destination? _destinationTo;

  Destination? get destinationFrom => _destinationFrom;
  Destination? get destinationTo => _destinationTo;

  setDestinationFrom(Destination dest){
    _destinationFrom = dest;
    notifyListeners();
  }

  setDestinationTo(Destination dest){
    _destinationTo = dest;
    notifyListeners();
  }

}