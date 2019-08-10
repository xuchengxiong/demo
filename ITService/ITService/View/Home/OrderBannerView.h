//
//  OrderBannerView.h
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGIndexBannerSubiew.h"

@interface OrderBannerView : PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame;

@property (strong, nonatomic) NSDictionary *orderInfo;

@end
