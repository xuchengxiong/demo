//
//  Context.h
//  BitLink
//
//  Created by 许成雄 on 2018/5/25.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UserInfo.h"
@interface Context : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *userId;                 //用户ID

@property (strong, nonatomic) NSDictionary *userInfo;           //用户信息

//删除userid
-(void)remoUserIdOutLogin;

@end
