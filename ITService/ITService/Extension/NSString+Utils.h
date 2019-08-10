//
//  NSString+Utils.h
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

// 去除首尾空字符串
+ (NSString *)trim:(NSString *)originStr;

//判断是否是空字符窜
+ (BOOL)isBlankString:(NSString *)string;

//判断是否是电话号码
+ (BOOL)phoneNumberIsTrue:(NSString *)phoneNumber;

//去除文本中的html标签
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

//是否含有表情字符
+ (BOOL)isContainsEmoji:(NSString *)string;

//获取最近时间(刚刚、5分钟前、1小时前...)
+ (NSString *)recentTime:(NSString *)timeStr;

//带逗号的价格格式字符串
+ (NSString *)formatPriceString:(NSString *)priceStr;
//json字符串
+(NSString*)convertToJSONData:(id)infoDict;
@end
