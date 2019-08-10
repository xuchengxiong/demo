//
//  HomeNoticeCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "HomeNoticeCell.h"

@interface HomeNoticeCell()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation HomeNoticeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(TRANS_VALUE(4.0f));
            make.right.equalTo(self.contentView).offset(-TRANS_VALUE(4.0f));
            make.top.equalTo(self.contentView).offset(TRANS_VALUE(3.0f));
            make.height.equalTo(@(TRANS_VALUE(44.0f)));
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.textColor = I_COLOR_DARKGRAY;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return self;
}

- (void)setNotice:(NSString *)notice {
    _notice = notice;
    if(_notice) {
        self.titleLabel.text = _notice;
    } else {
        self.titleLabel.text = @"未知公告";
    }
}

@end
