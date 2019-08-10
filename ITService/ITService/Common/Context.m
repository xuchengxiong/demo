//
//  Context.m
//  BitLink
//
//  Created by 许成雄 on 2018/5/25.
//  Copyright © 2018年 km_nogo. All rights reserved.
//

#import "Context.h"

@implementation Context

+ (instancetype)sharedInstance {
    static Context *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [self initContext];
    }
    return self;
}

- (void)initContext {
    
}

#pragma mark - setter
- (void)setToken:(NSString *)token {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(token != nil) {
        [userDefaults setObject:token forKey:@"token"];
    } else {
        [userDefaults removeObjectForKey:@"token"];
    }
}

- (NSString *)token {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"token"];
    return token;
}

- (void)setUserId:(NSString *)userId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(userId != nil) {
        [userDefaults setObject:userId forKey:@"userId"];
    } else {
        [userDefaults removeObjectForKey:@"userId"];
    }
}

- (NSString *)userId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"userId"];
    return userId;
}



- (void)setUserInfo:(NSDictionary *)userInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(userInfo != nil) {
        NSDictionary *dict = userInfo;
        [userDefaults setObject:dict forKey:@"userInfo"];
    } else {
        [userDefaults removeObjectForKey:@"userInfo"];
    }
}

- (NSDictionary *)userInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = (NSDictionary *)[userDefaults objectForKey:@"userInfo"];
    if(!dict) {
        return nil;
    } else {
        NSDictionary *info = dict;
        return info;
    }
}

//版本号
-(void)setVersion:(NSString *)version{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(version != nil) {
        [userDefaults setObject:version forKey:@"version"];
    } else {
        [userDefaults removeObjectForKey:@"version"];
    }
}
-(NSString*)version{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [userDefaults objectForKey:@"version"];
    return version;
}

-(void)remoUserIdOutLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userId"];
    [userDefaults removeObjectForKey:@"userInfo"];

}
@end
