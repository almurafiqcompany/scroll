import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;


void setupLocator() {
  locator.registerLazySingleton(() => Dio());
  // locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
  locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());

  // locator.registerSingleton<ApiManager>(ApiManager());
  //
  // locator.registerLazySingleton<AppBloc>(() {
  //   final AppBloc appBloc = AppBloc();
  //   usedBlocs.add(appBloc);
  //   return appBloc;
  // });
  //
  // locator.registerLazySingleton<LoginBloc>(() {
  //   final LoginBloc loginBloc = LoginBloc();
  //   usedBlocs.add(loginBloc);
  //   return loginBloc;
  // });

  // locator.registerLazySingleton<ForgetPasswordBloc>(() {
  //   final ForgetPasswordBloc forgetPasswordBloc = ForgetPasswordBloc();
  //   usedBlocs.add(forgetPasswordBloc);
  //   return forgetPasswordBloc;
  // });

  // locator.registerLazySingleton<ForgotPasswordVerificationCodeBloc>(() {
  //   final ForgotPasswordVerificationCodeBloc
  //       forgotPasswordVerificationCodeBloc =
  //       ForgotPasswordVerificationCodeBloc();
  //   usedBlocs.add(forgotPasswordVerificationCodeBloc);
  //   return forgotPasswordVerificationCodeBloc;
  // });
  //
  // locator.registerLazySingleton<ChangePasswordBloc>(() {
  //   final ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();
  //   usedBlocs.add(changePasswordBloc);
  //   return changePasswordBloc;
  // });
  //
  // locator.registerLazySingleton<RegisterUserDelegateBloc>(() {
  //   final RegisterUserDelegateBloc registerUserDelegateBloc =
  //       RegisterUserDelegateBloc();
  //   usedBlocs.add(registerUserDelegateBloc);
  //   return registerUserDelegateBloc;
  // });
  //
  // locator.registerLazySingleton<RegisterMerchantBloc>(() {
  //   final RegisterMerchantBloc registerMerchantBloc = RegisterMerchantBloc();
  //   //usedBlocs.add(registerMerchantBloc);
  //   return registerMerchantBloc;
  // });
  //
  // locator.registerLazySingleton<AccountRepository>(() => AccountRepository());
}
