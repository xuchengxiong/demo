//
//  QuestionSubViewController.h
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionSubViewController : UIViewController <ZJScrollPageViewChildVcDelegate>

@property (strong, nonatomic) NSString *typeId;               //类型ID

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
