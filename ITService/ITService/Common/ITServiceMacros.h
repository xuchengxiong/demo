//
//  BitLinkMacros.h
//  BitLink
//
//  Created by 许成雄 on 2018/5/3.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#ifndef ITServiceMacros_h
#define ITServiceMacros_h

//引入类别文件
#import "NSString+Utils.h"
#import "Context.h"
#import "MBProgressHUD+Toast.h"

#define BitLinkErrorDomain @"com.hanyun.apps.ios.ITService"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//根据屏幕转化的对应值
#define TRANS_VALUE(x) (![[UIDevice currentDevice].model isEqualToString:@"iPad"] ? ceil(SCREEN_WIDTH * x / 375) : ceil(x))

//自定义字体
#define LightFont(x)   ([UIFont fontWithName:@"PingFangSC-Light" size:x] ? [UIFont fontWithName:@"PingFangSC-Light" size:x] : [UIFont fontWithName:@".PingFang-SC-Light" size:x])
#define MediumFont(x)  ([UIFont fontWithName:@"PingFangSC-Medium" size:x] ? [UIFont fontWithName:@"PingFangSC-Medium" size:x]:[UIFont fontWithName:@".PingFang-SC-Regular" size:x])
#define BoldFont(x)    ([UIFont fontWithName:@"PingFangSC-Semibold" size:x] ? [UIFont fontWithName:@"PingFangSC-Semibold" size:x] : [UIFont fontWithName:@".PingFang-SC-Regular" size:x])
#define RegularFont(x) ([UIFont fontWithName:@"PingFangSC-Regular" size:x] ? [UIFont fontWithName:@"PingFangSC-Regular" size:x] : [UIFont fontWithName:@".PingFang-SC-Regular" size:x])

#define IS_IOS_10  (floor([[UIDevice currentDevice].systemVersion floatValue]) >= 10.0f ? 1 : 0)

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define I_COLOR_YELLOW    UIColorFromRGB(0xf0821e)
#define I_COLOR_WHITE     RGBACOLOR(255, 255, 255, 1.0f)             //白色
#define I_COLOR_BLACK     RGBACOLOR(20, 20, 20, 1.0f)                //黑色
#define I_COLOR_BLUE      UIColorFromRGB(0x2477de)                   //蓝色
#define I_COLOR_RED       RGBACOLOR(247, 77, 74, 1.0f)               //红色
#define I_COLOR_GREEN     UIColorFromRGB(0x3bc477)                   //绿色
#define I_COLOR_PURPLE    UIColorFromRGB(0x4f61ce)                   //紫色
#define I_COLOR_LIGHT_BLUE      RGBACOLOR(206, 229, 252, 1.0f)       //浅蓝色
#define I_COLOR_LIGHT_RED      RGBACOLOR(253, 220, 220, 1.0f)        //浅红色
#define I_COLOR_LIGHT_GREEN    RGBACOLOR(110, 192, 156, 0.5f)        //浅绿色
#define I_COLOR_ORANGE   UIColorFromRGB(0xffb400)                   //橙色

#define I_COLOR_33BLACK  UIColorFromRGB(0x333333)                    //浅黑色
#define I_COLOR_DARKGRAY  RGBACOLOR(94, 94, 94, 1.0f)                   //深灰色
#define I_COLOR_TABLE_HAEDER  UIColorFromRGB(0x999999)               //表头颜色
#define I_COLOR_GRAY      RGBACOLOR(204, 204, 204, 1.0f)             //灰色
#define I_COLOR_BACKGROUND  RGBACOLOR(245, 245, 245, 1.0f)           //背景颜色
#define I_COLOR_DIVIDER  UIColorFromRGB(0xDBE1E8)                    //分割条颜色
#define I_COLOR_TAB_BACKGROUND  RGBACOLOR(240, 240, 240, 1.0f)       //灰白色


#define I_COLOR_TEXT_BLACK  UIColorFromRGB(0xF8B62C)                   //黑色文字
#define I_COLOR_TEXT_GRAY   UIColorFromRGB(0xAEAEAE)                   //灰色文字

//消息文字
#define CUSTOM_ERROR_CODE             (-1)
#define MSG_USER_NOT_LOGIN            @"用户未登录联机宝"
#define MSG_DATA_PARSE_ERROR          @"数据解析错误"
#define MSG_NETWORK_REQUEST_ERROR     @"网络请求错误"
#define MSG_DATA_NULL_ERROR           @"数据为空错误"
#define MSG_TOKEN_INVALID             @"token失效，请重新登录"
#define MSG_LOGIN_FAILED              @"用户名或密码错误"
#define MSG_URL_NOT_FOUND             @"网络请求错误, URL不正确"
#define MSG_INNER_SERVER_ERROR        @"服务器内部错误"

//通知
#define ZJParentTableViewDidLeaveFromTopNotification  @"ZJParentTableViewDidLeaveFromTopNotification"

//类型
#define ITEM_TYPE_POST                @"topic"           //帖子
#define ITEM_TYPE_NEWS                @"news"            //新闻
#define ITEM_TYPE_FLASH               @"fast"            //快讯

#define KLINE_STANDARD_INTERNATIONAL  @"GIRD"            //国际标准(绿涨红跌)
#define KLINE_STANDARD_INLAND         @"GDRI"            //国内标准(绿跌红涨)

//通知
#define kNotificationAuthorFollowStateChanged     @"kNotificationAuthorFollowStateChanged"
#define kNotificationPostPublished                @"kNotificationPostPublished"
#define kNotificationPostStateChanged             @"kNotificationPostStateChanged"



#endif /* ITServiceMacros_h */
