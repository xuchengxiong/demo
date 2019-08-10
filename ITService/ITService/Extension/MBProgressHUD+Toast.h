//
//  MBProgressHUD+Toast.h
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Toast)

+ (void)showToast:(NSString *)message initWithView:(UIView *)view;

+ (void)showToast:(NSString *)message inTheView:(UIView *)view;

@end
