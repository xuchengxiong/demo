//
//  QuestionTableViewCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "QuestionTableViewCell.h"

@interface QuestionTableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation QuestionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(TRANS_VALUE(10.0f));
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(self.contentView.mas_top).offset(TRANS_VALUE(5.0f));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-TRANS_VALUE(5.0f));
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = I_COLOR_BLACK;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
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
        self.titleLabel.text = _title;
    } else {
        self.titleLabel.text = @"未知常见问题";
    }
}

@end
