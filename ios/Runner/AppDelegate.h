#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG

#define XLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define XLog(FORMAT, ...) nil

#endif

@interface AppDelegate : FlutterAppDelegate

@end
