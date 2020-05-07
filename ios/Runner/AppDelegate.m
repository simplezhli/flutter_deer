#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

  FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
  FlutterMethodChannel *versionChannel = [FlutterMethodChannel methodChannelWithName:@"version" binaryMessenger: controller];
    
  [versionChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
      if ([call.method isEqualToString:@"jumpAppStore"]) {
           NSURL *appUrl = [NSURL URLWithString:@"http://itunes.apple.com/us/app/id444934666"];
           [UIApplication.sharedApplication openURL:appUrl];
      } else {
           result(FlutterMethodNotImplemented);
      }
  }];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
