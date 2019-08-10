//
//  QuestionSubViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "QuestionSubViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "Question2TableViewCell.h"
#import "QuestionDetailViewController.h"

@interface QuestionSubViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *questionArray;

@end

@implementation QuestionSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
}

- (void)reloadData {
    [self loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - ZJScrollPageViewChildVcDelegate
- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    
    [self createUI];
    [self loadData];
    
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index {
    
}

- (void)zj_viewDidAppearForIndex:(NSInteger)index {
    
}

- (void)zj_viewWillDisappearForIndex:(NSInteger)index {
    
}
- (void)zj_viewDidDisappearForIndex:(NSInteger)index {
    
}

#pragma mark - UITableViewDatasource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.questionArray != nil ? self.questionArray.count : 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TRANS_VALUE(80.0f);
}

- (Question2TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Question2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Question2TableViewCell"];
    if(!cell) {
        cell = [[Question2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Question2TableViewCell"];
    }
    if(indexPath.row < [self.questionArray count]) {
        cell.question = [self.questionArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDetailViewController *questionDetailViewController = [[QuestionDetailViewController alloc] init];;
    [self.navigationController pushViewController:questionDetailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


#pragma mark - Private Method
- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(TRANS_VALUE(0.0f), TRANS_VALUE(0.0f), SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f - 44.0f) style:UITableViewStylePlain];
    self.tableView.backgroundColor = I_COLOR_WHITE;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.separatorColor = I_COLOR_DIVIDER;
    
    [self.tableView registerClass:[Question2TableViewCell class] forCellReuseIdentifier:@"Question2TableViewCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

//获取数据
- (void)loadData {
    if(!self.questionArray) {
        self.questionArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [self.questionArray removeAllObjects];
    
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    [self.questionArray addObject:@{@"title" : @"Excel文件用WPS打开可以正常打开, 但用office打开时就提示向程序发送命令出现错误.....", @"time" : @"2019.01.03"}];
    
    [self.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    
}

@end
