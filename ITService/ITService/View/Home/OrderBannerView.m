//
//  OrderBannerView.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "OrderBannerView.h"
#import "UIImageView+WebCache.h"

@interface OrderBannerView()

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation OrderBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self pictureImageView];
        [self statusLabel];
        [self timeLabel];
        [self titleLabel];
    }
    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.mainImageView);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_top).offset(TRANS_VALUE(15.0f));
        make.left.equalTo(self.pictureImageView).offset(TRANS_VALUE(10.0f));
        make.width.equalTo(@(TRANS_VALUE(80.0f)));
        make.height.equalTo(@(TRANS_VALUE(20.0f)));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_top).offset(TRANS_VALUE(15.0f));
        make.right.equalTo(self.pictureImageView.mas_right).offset(-TRANS_VALUE(10.0f));
        make.width.equalTo(@(TRANS_VALUE(100.0f)));
        make.height.equalTo(@(TRANS_VALUE(20.0f)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_left);
        make.right.equalTo(self.timeLabel.mas_right);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(TRANS_VALUE(5.0f));
        make.bottom.equalTo(self.pictureImageView.mas_bottom).offset(-TRANS_VALUE(10.0f));
    }];
}


- (UIImageView *)pictureImageView {
    if(!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
        _pictureImageView.contentScaleFactor = [UIScreen mainScreen].scale;
        _pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        _pictureImageView.autoresizingMask = UIViewAutoresizingNone;
        _pictureImageView.clipsToBounds = YES;
        _pictureImageView.layer.cornerRadius = TRANS_VALUE(2.0f);
        [self.mainImageView addSubview:_pictureImageView];
    }
    return _pictureImageView;
}

- (UILabel *)statusLabel {
    if(!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = I_COLOR_WHITE;
        _statusLabel.font = [UIFont systemFontOfSize:16.0f];;
        _statusLabel.numberOfLines = 1;
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.text = @"已受理";
        [self.mainImageView addSubview:_statusLabel];
    }
    return _statusLabel;
}

- (UILabel *)timeLabel {
    if(!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = I_COLOR_WHITE;
        _timeLabel.font = [UIFont systemFontOfSize:14.0f];
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"2017.01.03";
        [self.mainImageView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = I_COLOR_WHITE;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.text = @"区块链技术应用落地推动资产数字化";
        [self.mainImageView addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (void)setOrderInfo:(NSDictionary *)orderInfo {
    _orderInfo = orderInfo;
    if(_orderInfo != nil) {
        NSString *title = _orderInfo[@"title"];
        _titleLabel.text = title;
        NSString *time = _orderInfo[@"time"];
        _timeLabel.text = time;
        NSString *status = _orderInfo[@"status"];
        if([status isEqualToString:@"1"]){
            //已受理
            _statusLabel.text = @"已受理";
            _pictureImageView.image = [UIImage imageNamed:@"ic_home_gd_ysl"];
        } else if([status isEqualToString:@"2"]){
            //已处理
            _statusLabel.text = @"已处理";
            _pictureImageView.image = [UIImage imageNamed:@"ic_home_gd_ycl"];
        }
    }
    
}


@end
