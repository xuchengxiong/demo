//
//  TagListView.h
//  Hobby
//
//  Created by yz on 16/8/14.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagButton.h"

/**
 *  YZTagList高度会自动跟随标题计算，默认标签会自动计算宽度
 */
@interface TagListView : UIView

//标签删除图片
@property (nonatomic, strong) UIImage *tagDeleteimage;

//标签间距,和距离左，上间距,默认10
@property (nonatomic, assign) CGFloat tagMargin;

//标签颜色，默认灰色
@property (nonatomic, strong) UIColor *tagColor;

//选中的标签颜色，默认橙色
@property (nonatomic, strong) UIColor *selectedTagColor;

//标签背景颜色
@property (nonatomic, strong) UIColor *tagBackgroundColor;

//标签背景图片
@property (nonatomic, strong) UIImage *tagBackgroundImage;

//标签字体，默认13
@property (nonatomic, assign) UIFont *tagFont;

//标签按钮内容间距，标签内容距离左上下右间距，默认5
@property (nonatomic, assign) CGFloat tagButtonMargin;

//标签圆角半径,默认为5
@property (nonatomic, assign) CGFloat tagCornerRadius;

//标签列表的高度
@property (nonatomic, assign) CGFloat tagListH;

//边框宽度
@property (nonatomic, assign) CGFloat borderWidth;

//边框颜色
@property (nonatomic, strong) UIColor *borderColor;

//边框颜色
@property (nonatomic, strong) UIColor *selectedBorderColor;

//获取所有标签
@property (nonatomic, strong, readonly) NSMutableArray *tagArray;

//是否需要自定义tagList高度，默认为Yes
@property (nonatomic, assign) BOOL isFitTagListH;

//是否需要排序功能
@property (nonatomic, assign) BOOL isSort;

//在排序的时候，放大标签的比例，必须大于1
@property (nonatomic, assign) CGFloat scaleTagInSort;

/******自定义标签按钮******/
//必须是按钮类
@property (nonatomic, assign) Class tagClass;

/******自定义标签尺寸******/
@property (nonatomic, assign) CGSize tagSize;

/******标签列表总列数 默认4列******/
//标签间距会自动计算
@property (nonatomic, assign) NSInteger tagListCols;


//添加标签
- (void)addTag:(NSString *)tagStr;

//添加标签
- (void)addTag:(NSString *)tagStr withColor:(UIColor *)color;

//添加多个标签
- (void)addTags:(NSArray *)tagStrs;

//添加多个标签
- (void)addTags:(NSArray *)tagStrs colors:(NSArray *)colors;

//删除标签
- (void)deleteTag:(NSString *)tagStr;

//删除标签
- (void)clearTags;

//点击标签，执行Block
@property (nonatomic, strong) void(^clickTagBlock)(NSString *tag);

//点击标签，执行Block
@property (nonatomic, strong) void(^clickTagButtonBlock)(TagButton *button);

//长按标签，执行Block
@property (nonatomic, strong) void(^longPressTagBlock)(NSString *tag);

@property (strong, nonatomic) NSArray *selectedTags;

@end
