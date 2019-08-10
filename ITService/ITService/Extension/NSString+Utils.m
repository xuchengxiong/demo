//
//  NSString+Utils.m
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonCrypto.h>
#import <Base64/MF_Base64Additions.h>

#define gkey @"w3sflink@0123x100$#365#$"
#define gIv  @"01234567"

@implementation NSString (Utils)

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [myData base64String];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText {
    NSData *encryptData = [NSData dataWithBase64String:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}

// 去除首尾空字符串
+ (NSString *)trim:(NSString *)originStr {
    return [originStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

//判断是否是电话号码
+ (BOOL)phoneNumberIsTrue:(NSString *)phoneNumber{
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNumber];
    
}
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

//获取最近时间(刚刚、5分钟前、1小时前...)
+ (NSString *)recentTime:(NSString *)timeStr {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:timeStr];
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = - timeInterval;
    NSString *result;
    if(timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    } else if(timeInterval/60 < 60){
        result = [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval/60];
    } else if(timeInterval/3600 > 1 && timeInterval/3600 < 24){
        result = [NSString stringWithFormat:@"%ld小时前", (long)timeInterval/3600 ];
    } else if (timeInterval/3600 >= 24 && timeInterval/3600 < 48){
        result = [NSString stringWithFormat:@"昨天"];
    } else if (timeInterval/3600 >= 48 && timeInterval/3600 < 72){
        result = [NSString stringWithFormat:@"前天"];
    } else if (timeInterval/3600 >= 72 && timeInterval/3600 < 7 * 24){
        result = [NSString stringWithFormat:@"%ld天前", (long)(timeInterval/3600) / 24 ];
    } else if (timeInterval/3600 >= 7 * 24 && timeInterval/3600 < 30 * 24){
        result = [NSString stringWithFormat:@"%ld周前", (long)(timeInterval/3600) / (7 * 24)];
    } else if (timeInterval/3600 >= 30 * 24 && timeInterval/3600 < 365 * 24) {
        result = [NSString stringWithFormat:@"%ld月前", (long)(timeInterval/3600) / (30 * 24)];
    } else {
        result = timeStr;
    }
    return result;
}

//带逗号的价格格式字符串
+ (NSString *)formatPriceString:(NSString *)priceStr {
    if(!priceStr || [NSString isBlankString:priceStr]) {
        return @"0";
    } else {
        NSMutableString *formatStr = [[NSMutableString alloc] init];
        NSRange pointRange = [priceStr rangeOfString:@"."];
        NSString *integerStr = nil;
        NSString *decimalsStr = nil;
        if(pointRange.location != NSNotFound && pointRange.length == 1) {
            NSArray *strArray = [priceStr componentsSeparatedByString:@"."];
            integerStr = [strArray objectAtIndex:0];
            decimalsStr = [strArray objectAtIndex:1];
        } else {
            integerStr = priceStr;
            decimalsStr = nil;
        }
        NSInteger originCount = integerStr.length;
        NSMutableString *currentStr = [NSMutableString stringWithString:integerStr];
        if(originCount % 3 != 0) {
            if(originCount % 3 == 1) {
                [currentStr insertString:@"XX" atIndex:0];
            } else {
                [currentStr insertString:@"X" atIndex:0];
            }
        }
        NSMutableArray *subArray = [NSMutableArray array];
        NSInteger count = currentStr.length;
        NSString *tempStr = nil;
        for(NSInteger index = 0; index < count; index = index + 3) {
            tempStr = [currentStr substringWithRange:NSMakeRange(index, 3)];
            [subArray addObject:tempStr];
        }
        NSString *resultStr = [subArray componentsJoinedByString:@","];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"X" withString:@""];
        [formatStr appendString:resultStr];
        
        if(decimalsStr != nil) {
            [formatStr appendString:@"."];
            [formatStr appendString:decimalsStr];
        }
        return formatStr;
    }
}
+(NSString*)convertToJSONData:(id)infoDict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

@end
