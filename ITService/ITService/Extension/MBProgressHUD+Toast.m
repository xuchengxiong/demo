//
//  MBProgressHUD+Toast.m
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import "MBProgressHUD+Toast.h"


@implementation MBProgressHUD (Toast)

+ (void)showToast:(NSString *)message initWithView:(UIView *)view {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.label.text = message;
    HUD.label.numberOfLines=0;
    HUD.contentColor = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1.0f];
    HUD.offset = CGPointMake(0.0f, TRANS_VALUE(200.0f));
    HUD.margin = 10.0f;
    [HUD showAnimated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hideAnimated:YES];
        });
    });
}

+ (void)showToast:(NSString *)message inTheView:(UIView *)view {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.label.text = message;
    HUD.contentColor = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1.0f];
    HUD.offset = CGPointMake(0.0f, TRANS_VALUE(180.0f));
    HUD.margin = 10.0f;
    [HUD showAnimated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Do something useful in the background and update the HUD periodically.
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hideAnimated:YES];
        });
    });
}

@end
