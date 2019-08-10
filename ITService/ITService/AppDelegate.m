//
//  AppDelegate.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@property (strong, nonatomic) TabBarViewController *tabBarController;

@end

@implementation AppDelegate

+ (id)sharedDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = I_COLOR_WHITE;
    
    //显示主页面
    [self showMainViewController];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [[UINavigationBar appearance] setBarTintColor:I_COLOR_WHITE];
    [[UINavigationBar appearance] setBackgroundColor:I_COLOR_WHITE];
    [[UINavigationBar appearance] setTintColor:I_COLOR_BLACK];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:I_COLOR_BLACK];
    [[UINavigationBar appearance] setTintColor:I_COLOR_BLACK];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:I_COLOR_BLACK forKey:NSForegroundColorAttributeName]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:I_COLOR_BLACK, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17.0f], NSFontAttributeName, nil]];
    
//    UIImage *colorImage = [self imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 0.5)];
//    [[UINavigationBar appearance] setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    //    [[UITabBar appearance] setBackgroundImage:colorImage];
    [[UINavigationBar appearance] setShadowImage:[self imageWithColor:UIColorFromRGB(0xe6e6e6) size:CGSizeMake(SCREEN_WIDTH, 0.5f)]];
    [[UITabBar appearance] setShadowImage:[self imageWithColor:UIColorFromRGB(0xe6e6e6) size:CGSizeMake(SCREEN_WIDTH, 0.5f)]];
    
    [SVProgressHUD setMinimumSize:CGSizeMake(TRANS_VALUE(120.0f), TRANS_VALUE(100.0))];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0f]];   //背景颜色
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Private Method
- (void)showMainViewController {
    if(!self.tabBarController) {
        self.tabBarController = [[TabBarViewController alloc] init];
    }
    self.window.rootViewController = self.tabBarController;
}

- (void)showLoginViewController {
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if(!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
