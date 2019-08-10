//
//  OrderTableViewCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell()

@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(TRANS_VALUE(10.0f));
            make.right.equalTo(self.contentView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(self.contentView.mas_top).offset(TRANS_VALUE(5.0f));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-TRANS_VALUE(5.0f));
        }];
        bgView.backgroundColor = I_COLOR_WHITE;
        bgView.clipsToBounds = YES;
        bgView.layer.cornerRadius = TRANS_VALUE(3.0f);
        
        UILabel *numberTitleLabel = [[UILabel alloc] init];
        [bgView addSubview:numberTitleLabel];
        [numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left).offset(TRANS_VALUE(10.0f));
            make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
            make.width.equalTo(@(TRANS_VALUE(60.0f)));
            make.height.equalTo(@(TRANS_VALUE(20.0f)));
        }];
        numberTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        numberTitleLabel.textColor = I_COLOR_DARKGRAY;
        numberTitleLabel.textAlignment = NSTextAlignmentLeft;
        numberTitleLabel.text = @"工单编号: ";
        
        self.numberLabel = [[UILabel alloc] init];
        [bgView addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numberTitleLabel.mas_right).offset(TRANS_VALUE(10.0f));
            make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
            make.width.equalTo(@(TRANS_VALUE(100.0f)));
            make.height.equalTo(@(TRANS_VALUE(20.0f)));
        }];
        self.numberLabel.font = [UIFont systemFontOfSize:15.0f];
        self.numberLabel.textColor = I_COLOR_BLACK;
        self.numberLabel.textAlignment = NSTextAlignmentLeft;
        self.numberLabel.text = @"1006";
        
        
        self.statusLabel = [[UILabel alloc] init];
        [bgView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
            make.width.equalTo(@(TRANS_VALUE(40.0f)));
            make.height.equalTo(@(TRANS_VALUE(20.0f)));
        }];
        self.statusLabel.font = [UIFont systemFontOfSize:15.0f];
        self.statusLabel.textColor = I_COLOR_BLACK;
        self.statusLabel.textAlignment = NSTextAlignmentLeft;
        self.statusLabel.text = @"1006";
        
        UILabel *statusTitleLabel = [[UILabel alloc] init];
        [bgView addSubview:statusTitleLabel];
        [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.statusLabel.mas_left).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
            make.width.equalTo(@(TRANS_VALUE(60.0f)));
            make.height.equalTo(@(TRANS_VALUE(20.0f)));
        }];
        statusTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        statusTitleLabel.textColor = I_COLOR_DARKGRAY;
        statusTitleLabel.textAlignment = NSTextAlignmentRight;
        statusTitleLabel.text = @"状态: ";
        
        self.contentLabel = [[UILabel alloc] init];
        [bgView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left).offset(TRANS_VALUE(10.0f));
            make.right.equalTo(bgView.mas_right).offset(-TRANS_VALUE(10.0f));
            make.top.equalTo(self.numberLabel.mas_bottom).offset(TRANS_VALUE(5.0f));
            make.bottom.equalTo(bgView.mas_bottom).offset(-TRANS_VALUE(5.0f));
        }];
        self.contentLabel.font = [UIFont systemFontOfSize:14.0f];
        self.contentLabel.textColor = I_COLOR_BLACK;
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.text = @"内容:";
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
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

- (void)setOrder:(NSDictionary *)order {
    _order = order;
    if(_order) {
        self.numberLabel.text = _order[@"number"];
        NSString *status = _order[@"status"];
        if([status isEqualToString:@"0"]) {
            self.statusLabel.textColor = I_COLOR_ORANGE;
            self.statusLabel.text = @"请求";
        } else if([status isEqualToString:@"1"]) {
            self.statusLabel.textColor = I_COLOR_BLUE;
            self.statusLabel.text = @"受理";
        } else if([status isEqualToString:@"2"]) {
            self.statusLabel.textColor = I_COLOR_GREEN;
            self.statusLabel.text = @"关闭";
        } else {
            self.statusLabel.textColor = I_COLOR_BLACK;
            self.statusLabel.text = @"其他";
        }
        self.contentLabel.text = [NSString stringWithFormat:@"内容: %@", _order[@"content"]];
    } else {
        self.numberLabel.text = @"0000";
        self.statusLabel.textColor = I_COLOR_BLACK;
        self.statusLabel.text = @"其他";
        self.contentLabel.text = [NSString stringWithFormat:@"内容: %@", @"未知内容"];
    }
}

@end
