import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    GMSServices.provideAPIKey("AIzaSyAHSGbUz27Aeozuwp5Hku37OsPaJxfI9jM")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
