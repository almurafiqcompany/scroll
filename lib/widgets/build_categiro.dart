import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/screens/home_page/home_page_bloc.dart';
import 'package:al_murafiq/screens/home_page/sub_categores/sub_categorie_scteen.dart';
import 'package:al_murafiq/screens/home_page/sub_categorie_home_scteen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BulidCategiro extends StatelessWidget {
 final String? name;
 final String? image;
 final String? color;
 final int? id;

  const BulidCategiro({Key? key,  this.name, this.image, this.color, this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () async {
          HomePageBloc _bloc = HomePageBloc();
          await _bloc.fetchDataAllSubCategories(id!);
          await Get.to(SubCategorieHomeScreen(name_Categories: name!,id: id!,bloc: _bloc,));

        },
        child: Container(
          height: Get.height*0.2,
          width: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
             // gradient: kAdsHomeGradient,
             //  color: Color(int.parse('0xff${color}')),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.8],
                colors: [
                  Color(int.parse('0xff${color}')),
                  Colors.black.withOpacity(0.8),
                ],
              ),
              image: DecorationImage(
                image: NetworkImage(image != null
                    ? '$ImgUrl${image}'
                    : '$defaultImgUrl'),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      // ignore: unnecessary_string_interpolations
                      '$name',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold,),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
