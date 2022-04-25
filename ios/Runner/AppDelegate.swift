import UIKit
import Flutter
import GoogleMaps
import Firebase
//import flutter_downloader


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA")
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
//    var flutter_native_splash = 1
//    UIApplication.shared.isStatusBarHidden = false


    GeneratedPluginRegistrant.register(with: self)
//    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    private func registerPlugins(registry: FlutterPluginRegistry) {
//        if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//           FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
//        }
//    }
}
