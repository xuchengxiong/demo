//
//  OrderBannerCell.h
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderBannerCell;

@protocol OrderBannerCellDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface OrderBannerCell : UITableViewCell

@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) id<OrderBannerCellDelegate> delegate;

@end
