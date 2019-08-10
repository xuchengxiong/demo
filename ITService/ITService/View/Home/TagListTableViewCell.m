//
//  TagListTableViewCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "TagListTableViewCell.h"

@interface TagListTableViewCell()

@end

@implementation TagListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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

//设置tagList
- (void)setTagList:(TagListView *)tagList {
    _tagList = tagList;
    [self.contentView addSubview:tagList];
}

@end
