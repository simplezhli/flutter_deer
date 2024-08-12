import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller:FlutterViewController = window.rootViewController as! FlutterViewController
    let versionChannel = FlutterMethodChannel(name: "version", binaryMessenger: controller as! FlutterBinaryMessenger)
    versionChannel.setMethodCallHandler { (call, result) in
        if "jumpAppStore" == call.method {
            let urlString = "https://itunes.apple.com/us/app/id444934666"
            let url = URL(string: urlString)
            if UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
