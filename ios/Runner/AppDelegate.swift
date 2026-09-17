import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let versionChannel = FlutterMethodChannel(
      name: "version",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    versionChannel.setMethodCallHandler { (call, result) in
      if "jumpAppStore" == call.method {
        let urlString = "https://itunes.apple.com/us/app/id444934666"
        let url = URL(string: urlString)
        if UIApplication.shared.canOpenURL(url!) {
          UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
