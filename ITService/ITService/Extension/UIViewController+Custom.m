//
//  UIViewController+Custom.m
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import "UIViewController+Custom.h"

@implementation UIViewController (Custom)

- (void)setBackNavgationItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popBack)];
}

- (void)popBack {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
 

}

@end
