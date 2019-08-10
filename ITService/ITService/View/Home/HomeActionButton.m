//
//  HomeActionButton.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "HomeActionButton.h"

@interface HomeActionButton()

@end

@implementation HomeActionButton

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
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setTitleColor:I_COLOR_BLACK forState:UIControlStateNormal];
        [self setTitleColor:I_COLOR_BLACK forState:UIControlStateHighlighted];
        [self setTitleColor:I_COLOR_BLACK forState:UIControlStateSelected];
    }
    self.backgroundColor = I_COLOR_WHITE;
    
    return self;
}

- (void)setTitle:(NSString *)title image:(NSString *)imageName {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleWith = SCREEN_WIDTH / 3;
    CGFloat titleHeight = TRANS_VALUE(20.0f);
    CGFloat originX = 0;
    CGFloat originY = TRANS_VALUE(56.0f);
    return CGRectMake(originX, originY, titleWith, titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageWith = TRANS_VALUE(48.0f);
    CGFloat imageHeight = TRANS_VALUE(48.0f);
    CGFloat originX = (SCREEN_WIDTH / 3 - imageWith) * 0.5f;
    CGFloat originY = TRANS_VALUE(6.0f);
    return CGRectMake(originX, originY, imageWith, imageHeight);
}

@end
