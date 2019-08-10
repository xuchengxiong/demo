//
//  SettingTableViewCell.h
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SettingTableViewCell;

@protocol SettingTableViewCellDelegate <NSObject>

@optional
- (void)avatarClickAction;

@end

@interface SettingTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) UIImage *headImage;

@property (weak, nonatomic) id<SettingTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
