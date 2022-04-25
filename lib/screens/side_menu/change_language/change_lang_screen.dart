import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/screens/side_menu/change_language/change_lang_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_loading_dialog.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  ChangeLanguageBloc _bloc = ChangeLanguageBloc();
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  @override
  void initState() {
    _bloc.fetchAllCountries(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppbar(
        title: 'side_language_country'.tr,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _bloc.fetchAllCountries(context);
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: Stack(children: <Widget>[
          const BGLinearGradient(),
          SingleChildScrollView(
              physics: iosScrollPhysics(),
              child: Container(
                width: Get.width,
                height: Get.height * 0.88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      Assets.APP_LOGO,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   // context.translate('select_country'),
                    //     'select_country'.tr,
                    //     style: TextStyle(color: Colors.white, fontSize: 20))
                    //     .addPaddingOnly(top: 50),
                    // Text(
                    //     'p_choose_country'.tr,
                    //     // context.translate('p_choose_country'),
                    //     style: TextStyle(color: Colors.white, fontSize: 16))
                    //     .addPaddingOnly(top: 5, bottom: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: StreamBuilder<List<CountriesData>>(
                                  stream: _bloc.allCountriesSubject.stream,
                                  builder: (context, countriesSnapshot) {
                                    if (countriesSnapshot.hasData) {
                                      return StreamBuilder<CountriesData>(
                                          stream: _bloc.selectedCountry.stream,
                                          builder: (context, snapshot) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              child: DropdownButton<
                                                      CountriesData>(
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor: Colors.grey,
                                                  iconSize: 32,
                                                  elevation: 3,
                                                  icon: Icon(Icons
                                                      .arrow_drop_down_outlined),
                                                  items: countriesSnapshot.data!
                                                      .map((item) {
                                                    return DropdownMenuItem<
                                                            CountriesData>(
                                                        value: item,
                                                        child: Row(
                                                          children: [
                                                            item.icon != null
                                                                ? Image.network(
                                                                    '$ImgUrl${item.icon}',
                                                                    width: 32,
                                                                    height: 32,
                                                                  )
                                                                : SizedBox(),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              item.name,
                                                              style: kTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18),
                                                              minFontSize: 14,
                                                              maxFontSize: 18,
                                                            ),
                                                          ],
                                                        ));
                                                  }).toList(),
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: [
                                                      Icon(Icons.emoji_flags),
                                                      Text(
                                                        'select_country'.tr,
                                                        // context.translate('select_country'),
                                                        style:
                                                            kTextStyle.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                  style: kTextStyle.copyWith(
                                                      color: Colors.black),
                                                  underline: SizedBox(),
                                                  value: snapshot.data,
                                                  onChanged:
                                                      (CountriesData? item) {
                                                    // _bloc.selectedLanguage.sink.add(null);
                                                    _bloc.selectedCountry.sink
                                                        .add(item!);
                                                  }),
                                            );
                                          });
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  kAccentColor),
                                        )),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: StreamBuilder<List<Languages>>(
                                  stream: _bloc.allLanguageSubject.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return StreamBuilder<Languages>(
                                          stream: _bloc.selectedLanguage.stream,
                                          builder: (context, langSnapshot) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              child: DropdownButton<Languages>(
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor: Colors.grey,
                                                  iconSize: 32,
                                                  elevation: 3,
                                                  icon: Icon(Icons
                                                      .arrow_drop_down_outlined),
                                                  items: snapshot.data!
                                                      .map((item) {
                                                    return DropdownMenuItem<
                                                            Languages>(
                                                        value: item,
                                                        child: AutoSizeText(
                                                          item.name,
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 18),
                                                          minFontSize: 14,
                                                          maxFontSize: 18,
                                                        ));
                                                  }).toList(),
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: [
                                                      Icon(
                                                          Icons.language_sharp),
                                                      Text(
                                                        'select_language'.tr,
                                                        // context.translate('select_language'),
                                                        style:
                                                            kTextStyle.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                  style: kTextStyle.copyWith(
                                                      color: Colors.black),
                                                  underline: SizedBox(),
                                                  value: langSnapshot.data,
                                                  onChanged: (Languages? item) {
                                                    _bloc.selectedLanguage.sink
                                                        .add(item!);
                                                  }),
                                            );
                                          });
                                    } else
                                      return SizedBox();
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white),
                    //           child: StreamBuilder<CountriesData>(
                    //               stream: _bloc.selectedCountry.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   return StreamBuilder<Languages>(
                    //                       stream: _bloc.selectedLanguage.stream,
                    //                       builder: (context, langSnapshot) {
                    //                         return Padding(
                    //                           padding: const EdgeInsets.symmetric(
                    //                               horizontal: 10, vertical: 2),
                    //                           child: DropdownButton<Languages>(
                    //                               dropdownColor: Colors.white,
                    //                               iconEnabledColor: Colors.grey,
                    //                               iconSize: 32,
                    //                               elevation: 3,
                    //                               icon: Icon(Icons
                    //                                   .arrow_drop_down_outlined),
                    //                               items: snapshot.data.languages
                    //                                   .map((item) {
                    //                                 return DropdownMenuItem<
                    //                                         Languages>(
                    //                                     value: item,
                    //                                     child: AutoSizeText(
                    //                                       item.name,
                    //                                       style:
                    //                                           kTextStyle.copyWith(
                    //                                               fontSize: 18),
                    //                                       minFontSize: 14,
                    //                                       maxFontSize: 18,
                    //                                     ));
                    //                               }).toList(),
                    //                               isExpanded: true,
                    //                               hint: Row(
                    //                                 children: [
                    //                                   Icon(Icons.language_sharp),
                    //                                   Text(
                    //                                     'Select Languages',
                    //                                     style:
                    //                                         kTextStyle.copyWith(
                    //                                             color:
                    //                                                 Colors.black),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               style: kTextStyle.copyWith(
                    //                                   color: Colors.black),
                    //                               underline: SizedBox(),
                    //                               value:  langSnapshot.data,
                    //                               onChanged: (Languages item) {
                    //                                 print(item.name);
                    //                                 _bloc.selectedLanguage.sink
                    //                                     .add(item);
                    //                                 print(_bloc
                    //                                     .selectedLanguage.value);
                    //                               }),
                    //                         );
                    //                       });
                    //                 } else
                    //                   return SizedBox();
                    //               }),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: RoundedLoadingButton(
                        child: Text(
                          'bt_change'.tr,
                          // context.translate('bt_done'),
                          style: kTextStyle.copyWith(
                              fontSize: 20, color: Color(0xffFFFFFF)),
                        ),
                        height: 50,
                        controller: _bloc.loadingButtonController,
                        color: Colors.blue.shade800,
                        onPressed: () async {
                          _bloc.loadingButtonController.start();
                          int? idCountry = _bloc.selectedCountry.value.id;
                          await helper.setCountryId(idCountry!);
                          String? codeLang = _bloc.selectedLanguage.value.code;
                          await helper.setCodeLang(codeLang!);

                          Get.updateLocale(Locale(codeLang));

                          Get.back();
                          _bloc.loadingButtonController.stop();

                          _bloc.loadingButtonController.stop();
                        },
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 25),
                    //     child: FlatButton(
                    //
                    //       height: 60,
                    //       minWidth: Get.width-100,
                    //       child: Text(context.translate('bt_done'), style: kTextStyle.copyWith(fontSize: 25)),
                    //       color: Colors.blue.shade800,
                    //       textColor: Color(0xffFFFFFF),
                    //       onPressed: () async {
                    //         if(_bloc.selectedCountry.value != null&&_bloc.selectedLanguage.value!= null){
                    //           await _bloc.helper.setCountryId(_bloc.selectedCountry.value.id);
                    //           await _bloc.helper.setLangId(_bloc.selectedLanguage.value.id);
                    //           await _bloc.helper.setCodeLang(_bloc.selectedLanguage.value.code);
                    //           await _bloc.helper.setDefaultLang(_bloc.selectedCountry.value.default_lang);
                    //           print('wee${_bloc.selectedCountry.value.id}');
                    //           print(await _bloc.helper.getCountryId());
                    //           print(await _bloc.helper.getCodeLang());
                    //           // _bloc.loadingButtonController.start();
                    //            Get.off(BottomNavBar());
                    //
                    //
                    //           //_bloc.loadingButtonController.stop();
                    //         }
                    //       },
                    //       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
