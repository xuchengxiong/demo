//
//  Question2TableViewCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "Question2TableViewCell.h"

@interface Question2TableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation Question2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(TRANS_VALUE(10.0f));
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(self.contentView.mas_top).offset(TRANS_VALUE(5.0f));
            make.height.equalTo(@(TRANS_VALUE(40.0f)));
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = I_COLOR_BLACK;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(TRANS_VALUE(80.0f)));
            make.height.equalTo(@(TRANS_VALUE(20.0f)));
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-TRANS_VALUE(5.0f));
           
        }];
        self.timeLabel.font = [UIFont systemFontOfSize:14.0f];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.textColor = I_COLOR_BLACK;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
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

- (void)setQuestion:(NSDictionary *)question {
    _question = question;
    if(_question) {
        self.titleLabel.text = _question[@"title"];
        self.timeLabel.text = _question[@"time"];
    } else {
        self.titleLabel.text = @"未知常见问题";
        self.timeLabel.text = @"0000-00-00";
    }
}

@end
