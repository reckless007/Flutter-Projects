import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/great_places.dart';
import './map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {

  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlaces = Provider.of<GreatPlaces>(context).findbyId(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlaces.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlaces.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlaces.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    intialLocation: selectedPlaces.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
