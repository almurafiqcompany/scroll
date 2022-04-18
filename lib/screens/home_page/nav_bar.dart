import 'package:al_murafiq/screens/home_page/favorate/favorate_screen.dart';
import 'package:al_murafiq/screens/home_page/home_page.dart';
import 'package:al_murafiq/screens/home_page/search/search_screen.dart';
import 'package:al_murafiq/screens/home_page/special_ads/special_ads_screen.dart';
import 'package:al_murafiq/screens/home_page/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' ;
class BottomNavBar extends StatefulWidget {
   int page;

   BottomNavBar({Key key, this.page=0}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final List<Widget> _tabItems = [
    HomePageScreen(),
    SpecialAdsScreen(),
    SearchScreen(),
    FavorateScreen(),
    SettingScreen(),
  ];
  // int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('quit_app'.tr), actions: <Widget>[
                RaisedButton(
                    child: Text('Exit'.tr),
                    onPressed: () => Navigator.of(context).pop(true)),
                RaisedButton(
                    child: Text('bt_cancel'.tr),
                    onPressed: () => Navigator.of(context).pop(false)),
              ])),
          // () => _popCamera(context),
      child: Scaffold(
        //appBar: const GradientAppbar(),
        bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            // index: 0,
            index: widget.page,
            height: 70.0,
            items: <Widget>[

              Icon(
                Icons.home,
                size: 30,
                // color: _page == 0 ? Colors.white : Colors.grey,
                color: widget.page == 0 ? Colors.white : Colors.grey,
              ),
              Icon(
                Icons.stars_sharp,
                size: 30,
                color: widget.page == 1 ? Colors.white : Colors.grey,
              ),
              Icon(
                Icons.search,
                size: 30,
                color: widget.page == 2 ? Colors.white : Colors.grey,
              ),
              Icon(
                Icons.favorite,
                size: 30,
                color: widget.page == 3 ? Colors.white : Colors.grey,
              ),
              Icon(
                Icons.list,
                size: 30,
                color: widget.page == 4 ? Colors.white : Colors.grey,
              ),
            ],
            color: Color(0xffFFFFFF),
            buttonBackgroundColor: Color(0xff03186B), //#707070
            backgroundColor: const Color(0xFFF1F4FB),
            //Color(0xffB2B2B2),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                widget.page = index;
              });
            }),
        body: _tabItems[widget.page],
      ),
    );
  }
   Future<bool> _popCamera(BuildContext context) {
    debugPrint("_popCamera");
    showDialog(
        context: context,
        builder: (_) => ExitCameraDialog(),
        barrierDismissible: true);

    return Future.value(false);
  }
}


class ExitCameraDialog extends StatelessWidget {
  const ExitCameraDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Leaving camera forever'),
      content:
      Text('Are you S-U-R-E, S-I-R?'),
      actions: <Widget>[
        FlatButton(
          child: Text('no'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          //yes button
          child: Text('yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}