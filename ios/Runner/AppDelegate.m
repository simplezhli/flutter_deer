#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

  FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
    
  FlutterMethodChannel *logChannel = [FlutterMethodChannel methodChannelWithName:@"x_log" binaryMessenger:controller];
  FlutterMethodChannel *versionChannel = [FlutterMethodChannel methodChannelWithName:@"version" binaryMessenger:controller];
  
  [logChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
      NSString *tag = call.arguments[@"tag"];
      NSString *msg = call.arguments[@"msg"];
      if ([call.method isEqualToString:@"logJson"]) {
          NSData *jsonData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
          NSError *err;
          NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                              options:NSJSONReadingMutableContainers
                              error:&err];
          if(err){
              XLog(@"%@：%@", tag, msg);
          }else{
              XLog(@"%@：%@", tag, dic);
          }
          
      }else{
          XLog(@"%@：%@", tag, msg);
      }
      
  }];
    
  [versionChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
      if ([call.method isEqualToString:@"jumpAppStore"]) {
           NSURL *appUrl = [NSURL URLWithString:@"http://itunes.apple.com/us/app/id444934666"];
           [UIApplication.sharedApplication openURL:appUrl];
      }else{
           result(FlutterMethodNotImplemented);
      }
  }];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
