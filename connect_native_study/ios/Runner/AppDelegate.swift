import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let customChannel = FlutterMethodChannel(name: "example.com/value",
                                                  binaryMessenger: controller.binaryMessenger)
    print("CHLOE ? ")
    
    customChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getValue" {
                print("성공")
                result("성공!")
                return
            }
            
            result("실패" + call.method + (call.method == "getValue" ? "a" : "b"));
        })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
