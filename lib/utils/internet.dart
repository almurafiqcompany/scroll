
// class Internet {
//   static Future<ConnectionStatus> hasConnection() async {
//     final ConnectivityResult connectivityResult =
//     await Connectivity().checkConnectivity();
//     return (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi)
//         ? ConnectionStatus.HasConnection
//         : ConnectionStatus.NoConnection;
//   }
// }

enum ConnectionStatus { HasConnection, NoConnection }