//
//  RegexKit.h
//  BitLink
//
//  Created by 许成雄 on 2018/5/25.
//  Copyright (c) 2015年 xuchengxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexKit : NSObject
//邮箱
+ (BOOL)validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//用户名
+ (BOOL)validateUserName:(NSString *)name;

//密码
+ (BOOL)validatePassword:(NSString *)passWord;

//身份证号 开头是14位或者17位数字，结尾可以是数字或者是x或者是X
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

//真实姓名 只允许中文
+ (BOOL)validateRealname:(NSString *)realname;


@end
