import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
        if let registrar = self.registrar(forPlugin: "LoggerPlugin") {
            LoggerPlugin.register(with: registrar)
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
