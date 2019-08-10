//
//  SettingTableViewCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *headImageView;

@end

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self titleLabel];
        [self contentLabel];
        [self headImageView];
    }
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundColor = I_COLOR_WHITE;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if(_title) {
        _titleLabel.text = _title;
    } else {
        _titleLabel.text = @"未知";
    }
}

- (void)setContent:(NSString *)content {
    _content = content;
    if(_content) {
        _contentLabel.text = _content;
    } else {
        _contentLabel.text = @"未知";
    }
}

- (void)setHeadImage:(UIImage *)headImage {
    _headImage = headImage;
    if(_headImage) {
        _headImageView.hidden = NO;
        _contentLabel.hidden = YES;
        _headImageView.image = _headImage;
    } else {
        _headImageView.hidden = YES;
        _contentLabel.hidden = NO;
        _headImageView.image = nil;
    }
}

#pragma mark - Setter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(TRANS_VALUE(14.0f));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(@(TRANS_VALUE(160.0f)));
            make.height.equalTo(@(TRANS_VALUE(40.0f)));
        }];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = I_COLOR_BLACK;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(2.0f));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(@(TRANS_VALUE(200.0f)));
            make.height.equalTo(@(TRANS_VALUE(40.0f)));
        }];
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.textColor = UIColorFromRGB(0xacacac);
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (UIImageView *)headImageView {
    if(!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(2.0f));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(@(TRANS_VALUE(54.0f)));
            make.height.equalTo(@(TRANS_VALUE(54.0f)));
        }];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = TRANS_VALUE(54.0f) / 2;
        _headImageView.backgroundColor = I_COLOR_GRAY;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClickAction)];
    [_headImageView addGestureRecognizer:tap];
    
    return _headImageView;
}

- (void)headerClickAction {
    if(_delegate != nil && [_delegate respondsToSelector:@selector(avatarClickAction)]) {
        [_delegate avatarClickAction];
    }
}


@end
