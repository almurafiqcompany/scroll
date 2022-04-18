import 'package:flutter/material.dart';
import 'package:get/get.dart';
const Color kPrimaryColor = Color(0xFF03317C);
const Color kPrimaryDarkColor = Color(0xff006588);
const Color kSecondaryColor = Color(0xff040032);
const Color kAccentColor = Color(0xFF05B3D6);

const LinearGradient kBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0, 0.8],
  colors: [
    Color(0xff01B2CB),
    Color(0xff006588),
  ],
);
const LinearGradient kAdsHomeGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0, 0.8],
  colors: [
    Color(0xffFF8C48),
    Color(0xffFF5673),
  ],
);

const LinearGradient kButtonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0, 1],
  colors: [
    Color(0xff01B2CB),
    Color(0xff006588),
  ],
);
const TextStyle kHeaderStyle = TextStyle(
    fontSize: 22, fontFamily: 'TheSansArabic', fontWeight: FontWeight.bold);
const TextStyle kTextStyle =
    TextStyle(fontSize: 18.0, fontFamily: 'TheSansArabic');

enum PhotoType { Asset, Network, File }

const String kTestText =
   'يقع مقر .زاكس في الولايات المتحدة   شركة تكنولوجيا متعددة الجنسيات  لتي تتخصص في الإنترنت دمات.';
const String SourceDevice = 'Andorid';
const String BaseUrl = 'https://almurafiq.com/api';
const String ImgUrl = 'https://almurafiq.com';
const String TapUrl = 'https://almurafiq.com';
const String defaultImgUrl = 'https://www.pikpng.com/pngl/m/326-3261783_person-icon-default-user-image-jpg-clipart.png';
// const String defaultImgUrl = 'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg';


RegExp phoneExp = RegExp(r'^01[0-9]{9}$');
RegExp emailExp =
    RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
// RegExp urlExp =
//     RegExp(r'^((?:.|\n)?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;])?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');
RegExp urlExp =
    RegExp(r'^((?:.|\n)?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;])?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');

// Map<String,String> te={
//   "new_user": "مستخدم جديد",
//   "Marketer": "مسوق",
//   "dealer": "تاجر",
//   "email": "البريد الإلكتروني",
//   "are you": "هل أنت ؟",
//   "question_login": "هل لديك حساب بالفعل ؟",
//   "login": " تسجيل دخول",
//   "new account": "حساب جديد",
//   "language": "اللغة",
//   "full name": "الاسم بالكامل",
//   "number": "رقم الهوية الوطنية / رقم الاقامة",
//   "birth": "تاريخ الميلاد",
//   "sex": "الجنس",
//   "cont": "استمرار",
//   "sagel": "تسجيل",
//   "go": "ارسال",
//   "sure": "تأكيد",
//   "face login": "تسجيل الدخول بالفيس بوك",
//   "google login": "تسجيل الدخول بالجيميل",
//   "pass": "انشاء رقم سري",
//   "enter-pass": "ادخال رقم سري",
//   "new pass": "الرقم السري الجديد",
//   "re-pass": "اعادة ادخال الرقم السري",
//   "hatef": "رقم الهاتف ",
//   "re-hatef": "رقم الهاتف تأكيدي" ,
//   "phone": "رقم التليفون",
//   "num1": "رقم المحمول",
//   "num2": "رقم المحمول2",
//   "code": "الكود",
//   "change": "تغيير",
//   "message": "سنقوم بارسال كود الي هذا البريد",
//   "big-text1": "الرجاء ادخال\n البريد الالكتروني",
//   "big-text2": "الرجاء ادخال\n الكود المرسل",
//   "big-text3": "الرجاء ادخال\n الرقم السري الجديد",
//   "again": "اعادة ارسال الكود ؟",
//   "change-mail": "تغيير البريد الالكتروني",
//   "online-payment": "اختار الطريقة\n المناسبة للدفع",
//   "offline-payment": "اختار الطريقة\n المناسبة للدفع\n الاوفلاين",
//   "how": "اختار الطريقة المناسبة للدفع",
//   "online": "دفع أونلاين",
//   "offline": "دفع أوفلاين",
//   "btn-offline": "ادفع أوفلاين",
//   "bank": "تحويل بنكي",
//   "kash": "كاش",
//   "kind": "التصنيف",
//   "place": "اسم المكان",
//   "enoan": "العنوان",
//   "city": "المدينة",
//   "desc": "الوصف",
//   "faks": "فاكس",
//   "whats": "رقم الواتس آب",
//   "facelink": "رابط الفيس بوك",
//   "sociallink": "رابط موقع تواصل اجتماعي آخر",
//   "weblink": "رابط الموقع الالكتروني",
//   "forgot_password?": "هل نسيت كلمة المرور؟",
//   "please_wait": "الرجاء الانتظار..",
//   "ok": "حسنا",
//   "bank1": "المعلومات المناسبة\n للتحويل البنكي",
//   "bank2": "المعلومات اللازمة للحساب البنكي",
//   "bank_info_1": "اسم البنك",
//   "bank_info_2": "رقم الحساب",
//   "bank_info_3": "اسم مالك الحساب",
//   "bank_info_4": "اسم الفرع",
//   "bank_info_5": "السويفت كود",
//   "pay1": "اختار خطتك و\n الباقة المناسبة\n  للدفع",
//   "pay2": "اختار الباقه المناسبة لعملك الشهريه",
//   "plan1": "الخطة الذهبية",
//   "plan2": "اختار هذه الخطة",
//   "const": "\$8.25/شهريا",
//   "do1": "وقت تحميل غير محدود من اي نوع صوت",
//   "do2": "تخزين وتنزيل Hd بدون فقدان",
//   "do3": "جدولة الإصدارات الخاصة بك",
//   "my-plan1": "خطتك الحالية",
//   "my-plan2": "تغيير هذه الخطة",
//   "my-plan3": "الباقة المختارة لعملك الشهريه",
//   "eshtrak": "ميعاد الاشتراك",
//   "tagdeed": "ميعاد التجديد",
//   "appo1": "15 2020 يناير",
//   "appo2": "15 2020 فبراير",
//   "ads-title": "اختار خطتك و \nنوع الإعلان المناسب لك",
//   "ads-sub": "اختار نوع الاعلان المميز المناسب لعملك",
//   "ads-btn": "اختار هذا الاعلان",
//   "ads1": "سليدر رئيسي",
//   "ads2": "بانر رئيسي",
//   "ads3": "اعلان مميز",
//   "ads4": "سليدر قسم",
//   "call1": "تم ارسال طلبك بنجاح",
//   "call2": "سنقوم بالتواصل معك",
//   "eshtrakaty": "اشتركاتي",
//   "e3lan": "طلب اعلان مميز",
//   "da3m": "الدعم الفني",
//   "policy": "البنود والظروف",
//   "who us": "من نحن",
//   "logout": "تسجيل الخروج",
//   "customers": "العملاء",
//   "reach-point": "نقطة الوصول",
//   "favourite": "المفضله",
//   "serach": "سجل البحث",
//   "add-branch": "إضافة فرع",
//   "ask?": "هل لديك سؤال",
//   "po1": "اتفاقية الشروط والأحكام  ليست مطلوبة قانونيا. ومع ذلك ، فإن الحصول علي واحدة يأتي مع عدد من الفوائد المهمة لك وللمستخدمين / العملاء.",
//   "po2": "تشمل الفوائد زايدة سيطرتك علي عملك / منصتك ، مع مساعدة المستخدمين لديك علي فهم القواعد والمتطلبات والقيود الخاصة بك.",
//   "po3": "اتفاقية الشروط والأحكام ليست مطلوبة قانونيا. ومع ذلك ، فإن امتلاك واحد يأتي مع عدد من الفوائد المهمة لك وللمستخدمين / العملاء.",
//   "po4": "تشمل الفوائد زيادة سيطرتك علي عملك / منصتك ، مع مساعدة المستخدمين لديك علي فهم القواعد والمتطلبات والقيود الخاصة بك."
//
//
// };

 const List<String> LIST_LANGUAGE = <String>[
  'ar',
  'en',
];
//  const List<String> LIST_DAYS = <String>[
//   'السبت',
//   'الاحد',
//   'الاثنين',
//   'الثلاثاء',
//   'الاربعاء',
//   'الخميس',
//   'الجمعة',
// ];

//  List<String> LIST_DAYS= <String>[
//   'Saturday'.tr,
//   'Sunday'.tr,
//   'Monday'.tr,
//   'Tuesday'.tr,
//   'Wednesday'.tr,
//   'Thursday'.tr,
//   'Friday'.tr,
// ];
 const List<String> countriesName = <String>[];

//  const List<String> LIST_KIND = <String>[
//   'Male',
//   'Female',
// ];

