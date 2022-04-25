// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // Your api key storage.
// // import 'keys.dart';

// class MapTest extends StatefulWidget {
//   const MapTest({Key? key}) : super(key: key);

//   static final kInitialPosition = LatLng(30.128500174665863, 31.33010426275912);

//   @override
//   _MapTestState createState() => _MapTestState();
// }

// class _MapTestState extends State<MapTest> {
//   PickResult selectedPlace;
//   LocationResult _pickedLocation;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Google Map Place Picer Demo"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               RaisedButton(
//                 child: Text("Load Google Map"),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return PlacePicker(
//                           apiKey: 'AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA',
//                           initialPosition: MapTest.kInitialPosition,
//                           useCurrentLocation: true,
//                           selectInitialPosition: true,

//                           //usePlaceDetailSearch: true,
//                           onPlacePicked: (result) {
//                             selectedPlace = result;
//                             Navigator.of(context).pop();
//                             setState(() {});
//                           },
//                           //forceSearchOnZoomChanged: true,
//                           //automaticallyImplyAppBarLeading: false,
//                           //autocompleteLanguage: "ko",
//                           //region: 'au',
//                           //selectInitialPosition: true,
//                           // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
//                           //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
//                           //   return isSearchBarFocused
//                           //       ? Container()
//                           //       : FloatingCard(
//                           //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
//                           //           leftPosition: 0.0,
//                           //           rightPosition: 0.0,
//                           //           width: 500,
//                           //           borderRadius: BorderRadius.circular(12.0),
//                           //           child: state == SearchingState.Searching
//                           //               ? Center(child: CircularProgressIndicator())
//                           //               : RaisedButton(
//                           //                   child: Text("Pick Here"),
//                           //                   onPressed: () {
//                           //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
//                           //                     //            this will override default 'Select here' Button.
//                           //                     print("do something with [selectedPlace] data");
//                           //                     Navigator.of(context).pop();
//                           //                   },
//                           //                 ),
//                           //         );
//                           // },
//                           // pinBuilder: (context, state) {
//                           //   if (state == PinState.Idle) {
//                           //     return Icon(Icons.favorite_border);
//                           //   } else {
//                           //     return Icon(Icons.favorite);
//                           //   }
//                           // },
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               selectedPlace == null
//                   ? Container()
//                   : Text(selectedPlace.formattedAddress ?? ""),
//               RaisedButton(
//                 onPressed: () async {
//                   LocationResult result = await showLocationPicker(
//                     context,
//                     'AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA',
//                     initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                     myLocationButtonEnabled: true,
//                     // requiredGPS: true,
//                     layersButtonEnabled: true,
//                     countries: ['AE', 'NG'],

// //                      resultCardAlignment: Alignment.bottomCenter,
//                     desiredAccuracy: LocationAccuracy.best,
//                   );
//                   print("result = $result");
//                   print("result = ${result.latLng.longitude}");
//                   print("result = ${result.address}");
//                   setState(() => _pickedLocation = result);
//                 },
//                 child: Text('Pick location'),
//               ),
//               Text(_pickedLocation.toString()),
//             ],
//           ),
//         ));
//   }
// }
