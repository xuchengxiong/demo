//
//  HomeViewController.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "HomeViewController.h"
#import <HYBLoopScrollView/HYBLoopScrollView.h>
#import "HomeActionButton.h"
#import <RollingNotice/GYRollingNoticeView.h>
#import "HomeNoticeCell.h"
#import "QuestionTableViewCell.h"
#import "OrderBannerCell.h"
#import "OrderViewController.h"
#import "ReportViewController.h"
#import "AdviseViewController.h"
#import "QuestionViewController.h"
#import "QuestionDetailViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, GYRollingNoticeViewDelegate, GYRollingNoticeViewDataSource, OrderBannerCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) HYBLoopScrollView *loopView;            //轮播图
@property (strong, nonatomic) HomeActionButton *queryButton;          //工单查询
@property (strong, nonatomic) HomeActionButton *reportButton;         //故障申报
@property (strong, nonatomic) HomeActionButton *adviseButton;         //问题建议
@property (strong, nonatomic) GYRollingNoticeView *noticeView;        //公告栏
@property (strong, nonatomic) NSMutableArray *noticeArray;            //公告
@property (strong, nonatomic) UIButton *moreOrderButton;              //更多(工单)
@property (strong, nonatomic) NSMutableArray *orderArray;             //工单
@property (strong, nonatomic) UIButton *moreQuestionButton;           //更多(问题)
@property (strong, nonatomic) NSMutableArray *questionArray;          //常见问题

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"IT自助服务";
    
    [self createUI];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.loopView startTimer];
    [self.noticeView reloadDataAndStartRoll];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.loopView pauseTimer];
    [self.noticeView stopRoll];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDatasource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else {
        NSInteger count = self.questionArray != nil ? [self.questionArray count] : 0;
        return count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TRANS_VALUE(44.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(44.0f))];
    headerView.backgroundColor = I_COLOR_WHITE;
    UILabel *titleLabel = [[UILabel alloc] init];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(TRANS_VALUE(10.0f));
        make.centerY.equalTo(headerView.mas_centerY);
        make.width.equalTo(@(TRANS_VALUE(120.0f)));
        make.height.equalTo(@(TRANS_VALUE(40.0f)));
    }];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.textColor = I_COLOR_BLACK;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView);
        make.centerY.equalTo(headerView.mas_centerY);
        make.width.equalTo(@(TRANS_VALUE(44.0f)));
        make.height.equalTo(@(TRANS_VALUE(40.0f)));
    }];
    moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    moreButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [moreButton setImage:[UIImage imageNamed:@"ic_home_more"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"ic_home_more"] forState:UIControlStateSelected];
    [moreButton setImage:[UIImage imageNamed:@"ic_home_more"] forState:UIControlStateHighlighted];
    
    if(section == 0) {
        titleLabel.text = @"最新工单";
        moreButton.hidden = NO;
        self.moreOrderButton = moreButton;
        [self.moreOrderButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    } else if(section == 1) {
        titleLabel.text = @"常见问题";
        moreButton.hidden = NO;
        self.moreQuestionButton = moreButton;
        [self.moreQuestionButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        titleLabel.text = @"";
        moreButton.hidden = YES;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TRANS_VALUE(6.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(6.0f))];
    footerView.backgroundColor = I_COLOR_BACKGROUND;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return TRANS_VALUE(100.0f);
    } else {
        return TRANS_VALUE(54.0f);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        OrderBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderBannerCell"];
        if(!cell) {
            cell = [[OrderBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderBannerCell"];
        }
        if(self.orderArray != nil) {
            cell.data = self.orderArray;
        }
        cell.delegate = self;
        return cell;
    } else {
        QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionTableViewCell"];
        if(!cell) {
            cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionTableViewCell"];
        }
        if(indexPath.row < [self.questionArray count]) {
            NSString *question = [self.questionArray objectAtIndex:indexPath.row];
            cell.title = question;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        QuestionDetailViewController *questionDetailViewController = [[QuestionDetailViewController alloc] init];
        questionDetailViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:questionDetailViewController animated:YES];
    }
}

#pragma mark - OrderBannerCellDelegate
- (void)didSelectItemAtIndex:(NSInteger)index {
    //TODO -- 点击了工单
    
}

#pragma mark - GYRollingNoticeViewDelegate && GYRollingNoticeViewDataSource
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView {
    NSInteger count = self.noticeArray != nil ? self.noticeArray.count : 0;
    return count;
}

- (GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index {
    HomeNoticeCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"HomeNoticeViewCell"];
    if(!cell) {
        cell = [[HomeNoticeCell alloc] initWithReuseIdentifier:@"HomeNoticeViewCell"];
    }
    if(index < self.noticeArray.count) {
        NSString *noticeStr = [self.noticeArray objectAtIndex:index];
        cell.notice = noticeStr;
    }
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index {
    //点击了公告item
}

#pragma mark - UIButtonAction
- (void)buttonClickAction:(id)sender {
    if(sender == self.queryButton) {
        //工单查询
        OrderViewController *orderViewController = [[OrderViewController alloc] init];
        orderViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderViewController animated:YES];
    } else if(sender == self.reportButton) {
        //故障申报
        ReportViewController *reportViewController = [[ReportViewController alloc] init];
        reportViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reportViewController animated:YES];
    } else if(sender == self.adviseButton) {
        //问题建议
        AdviseViewController *adviseViewController = [[AdviseViewController alloc] init];
        adviseViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adviseViewController animated:YES];
    } else if(sender == self.moreOrderButton) {
        //更多工单
        OrderViewController *orderViewController = [[OrderViewController alloc] init];
        orderViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderViewController animated:YES];
    } else if(sender == self.moreQuestionButton) {
        //更多问题
        QuestionViewController *questionViewController = [[QuestionViewController alloc] init];
        questionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:questionViewController animated:YES];
    }
}

#pragma mark - Private Method
- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = I_COLOR_BACKGROUND;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [self tableHeaderView];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:@"QuestionTableViewCell"];
    [self.tableView registerClass:[OrderBannerCell class] forCellReuseIdentifier:@"OrderBannerCell"];
}

- (void)loadData {
    if(!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    [_noticeArray removeAllObjects];
    [_noticeArray addObject:@"2017年12月29日凌晨对办公自动化系统进行系统升级改造。次日8点系统恢复正常。"];
    [_noticeArray addObject:@"2017年12月29日凌晨对办公自动化系统进行系统升级改造。次日8点系统恢复正常。"];
    [_noticeArray addObject:@"2017年12月29日凌晨对办公自动化系统进行系统升级改造。次日8点系统恢复正常。"];
    [_noticeArray addObject:@"2017年12月29日凌晨对办公自动化系统进行系统升级改造。次日8点系统恢复正常。"];
    [self.noticeView reloadDataAndStartRoll];
    
    if(!_questionArray) {
        _questionArray = [NSMutableArray array];
    }
    [_questionArray removeAllObjects];
    [_questionArray addObject:@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"];
    [_questionArray addObject:@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"];
    [_questionArray addObject:@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"];
    [_questionArray addObject:@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"];
    [_questionArray addObject:@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    
    if(!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    [_orderArray removeAllObjects];
    [_orderArray addObject:@{@"status":@"1", @"time":@"2018.01.03", @"title":@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"}];
    [_orderArray addObject:@{@"status":@"2", @"time":@"2018.01.03", @"title":@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"}];
    [_orderArray addObject:@{@"status":@"1", @"time":@"2018.01.03", @"title":@"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误......"}];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Private Method
- (UIView *)tableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(330.0f))];
    headerView.backgroundColor = I_COLOR_WHITE;
    //添加轮播图
    NSString *url = @"http://test.meirongzongjian.com/imageServer/user/3/42ccb9c75ccf5e910cd6f5aaf0cd1200.jpg";
    NSArray *images = @[@"http://s0.pimg.cn/group5/M00/5B/6D/wKgBfVaQf0KAMa2vAARnyn5qdf8958.jpg?imageMogr2/strip/thumbnail/1200%3E/quality/95",
                        @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/QQ20160322-0@2x.png",
                        @"ic_ad_default",
                        @"http://s0.pimg.cn/group6/M00/45/84/wKgBjVZVjYCAEIM4AAKYJZIpvWo152.jpg?imageMogr2/strip/thumbnail/1200%3E/quality/95",
                        url
                        ];
    self.loopView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(TRANS_VALUE(12.0f), TRANS_VALUE(10.0f), SCREEN_WIDTH - 2 * TRANS_VALUE(12.0f), TRANS_VALUE(138.0f)) imageUrls:images timeInterval:3.0f didSelect:^(NSInteger atIndex) {
    
    } didScroll:^(NSInteger toIndex) {
        
    }];
    self.loopView.clipsToBounds = YES;
    self.loopView.layer.cornerRadius = 4.0f;
    self.loopView.shouldAutoClipImageToViewSize = NO;
    self.loopView.backgroundColor = [UIColor whiteColor];
    self.loopView.shouldAutoClipImageToViewSize = NO;
    self.loopView.placeholder = [UIImage imageNamed:@"ic_ad_default"];
    
    self.loopView.alignment = kPageControlAlignCenter;
    self.loopView.adTitles = nil;
    [headerView addSubview:self.loopView];
    
    //添加【工单查询】【故障申报】【问题建议】按钮
    self.reportButton = [[HomeActionButton alloc] init];
    [headerView addSubview:self.reportButton];
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH / 3));
        make.height.equalTo(@(TRANS_VALUE(80.0f)));
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(self.loopView.mas_bottom).offset(TRANS_VALUE(10.0f));
    }];
    [self.reportButton setTitle:@"故障申报" image:@"ic_home_gzsb"];
    [self.reportButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.queryButton = [[HomeActionButton alloc] init];
    [headerView addSubview:self.queryButton];
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH / 3));
        make.height.equalTo(@(TRANS_VALUE(80.0f)));
        make.centerY.equalTo(self.reportButton.mas_centerY);
        make.left.equalTo(headerView.mas_left);
    }];
    [self.queryButton setTitle:@"工单查询" image:@"ic_home_gdcx"];
    [self.queryButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.adviseButton = [[HomeActionButton alloc] init];
    [headerView addSubview:self.adviseButton];
    [self.adviseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH / 3));
        make.height.equalTo(@(TRANS_VALUE(80.0f)));
        make.centerY.equalTo(self.reportButton.mas_centerY);
        make.right.equalTo(headerView.mas_right);
    }];
    [self.adviseButton setTitle:@"问题建议" image:@"ic_home_wtjy"];
    [self.adviseButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = I_COLOR_DIVIDER;
    [headerView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.height.equalTo(@(0.5f));
        make.top.equalTo(self.reportButton.mas_bottom).offset(TRANS_VALUE(6.0f));
    }];
    
    //公告栏
    UIView *noticeBar = [[UIView alloc] init];
    [headerView addSubview:noticeBar];
    [noticeBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(dividerView.mas_bottom).offset(TRANS_VALUE(5.0f));
        make.bottom.equalTo(headerView.mas_bottom).offset(-TRANS_VALUE(6.0f));
    }];
    noticeBar.backgroundColor = I_COLOR_WHITE;
    
    UIImageView *noticeImageView = [[UIImageView alloc] init];
    [noticeBar addSubview:noticeImageView];
    [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(42.0f)));
        make.height.equalTo(@(TRANS_VALUE(42.0f)));
        make.centerY.equalTo(noticeBar.mas_centerY);
        make.left.equalTo(noticeBar.mas_left).offset(TRANS_VALUE(10.0f));
    }];
    noticeImageView.contentMode = UIViewContentModeScaleAspectFit;
    noticeImageView.image = [UIImage imageNamed:@"ic_home_notice"];
    
    UIView *verticalDivider = [[UIView alloc] init];
    [noticeBar addSubview:verticalDivider];
    [verticalDivider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(1.0f));
        make.height.equalTo(@(TRANS_VALUE(30.0f)));
        make.centerY.equalTo(noticeBar.mas_centerY);
        make.left.equalTo(noticeBar.mas_left).offset(TRANS_VALUE(62.0f));
    }];
    verticalDivider.backgroundColor = I_COLOR_DIVIDER;
    
    self.noticeView = [[GYRollingNoticeView alloc] initWithFrame:CGRectZero];
    [noticeBar addSubview:self.noticeView];
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeBar.mas_left).offset(TRANS_VALUE(72.0f));
        make.right.equalTo(noticeBar.mas_right).offset(-TRANS_VALUE(10.0f));
        make.centerY.equalTo(noticeBar.mas_centerY);
        make.height.equalTo(@(TRANS_VALUE(50.0f)));
    }];
    [self.noticeView registerClass:[HomeNoticeCell class] forCellReuseIdentifier:@"HomeNoticeCell"];
    self.noticeView.backgroundColor = I_COLOR_WHITE;
    self.noticeView.delegate = self;
    self.noticeView.dataSource = self;
    self.noticeView.stayInterval = 4.0f;
    [self.noticeView reloadDataAndStartRoll];
    
    UIView *bottomDivider = [[UIView alloc] init];
    [headerView addSubview:bottomDivider];
    [bottomDivider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headerView);
        make.height.equalTo(@(TRANS_VALUE(6.0f)));
    }];
    bottomDivider.backgroundColor = I_COLOR_BACKGROUND;
    
    return headerView;
}

@end
