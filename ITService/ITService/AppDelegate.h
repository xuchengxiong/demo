//
//  AppDelegate.h
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (id)sharedDelegate;

- (void)showLoginViewController;

@end

