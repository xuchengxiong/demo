//
//  OrderBannerCell.m
//  ITService
//
//  Created by 许成雄 on 2019/1/7.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "OrderBannerCell.h"
#import "NewPagedFlowView.h"
#import "OrderBannerView.h"

@interface OrderBannerCell() <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
    
@property (strong, nonatomic) NewPagedFlowView *flowView;
    
@end

@implementation OrderBannerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.backgroundColor = I_COLOR_WHITE;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _flowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(TRANS_VALUE(0.0f), TRANS_VALUE(0.0f), SCREEN_WIDTH, TRANS_VALUE(92.0f))];
    _flowView.delegate = self;
    _flowView.dataSource = self;
    _flowView.minimumPageAlpha = 0.3;
    _flowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _flowView.isCarousel = YES;
    _flowView.isDragable = YES;
    _flowView.isOpenAutoScroll = YES;
    _flowView.leftRightMargin = 15.0f;
    _flowView.topBottomMargin = 0.0f;
    [self.contentView addSubview:_flowView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
- (void)setData:(NSArray *)data {
    _data = data;
    if(_data != nil) {
        [self.flowView reloadData];
    }
}
    
#pragma mark - NewPagedFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 2 * TRANS_VALUE(25.0f), TRANS_VALUE(102.0f));
}
    
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    //TODO -- banner item 点击事件
    if(subIndex < 0 || subIndex >= _data.count) {
        return;
    }
    if(_delegate != nil && [_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [_delegate didSelectItemAtIndex:subIndex];
    }
}
    
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    //    NSLog(@"ViewController 滚动到了第%ld页",(long)pageNumber);
}
    
#pragma mark - PagedFlowView Datasource
    //返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    NSInteger count = self.data != nil ? self.data.count : 0;
    return count;
}
    
//返回给某列使用的View
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    OrderBannerView *bannerView = (OrderBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[OrderBannerView alloc] init];
    }
    if(index < self.data.count) {
        NSDictionary *item = [self.data objectAtIndex:index];
        bannerView.orderInfo = item;
    }
    return bannerView;
}


@end
