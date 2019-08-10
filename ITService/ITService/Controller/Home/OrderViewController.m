//
//  OrderViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "SearchViewController.h"

@interface OrderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIBarButtonItem *searchButton;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *orderArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"工单查询";
    [self setBackNavgationItem];
    
    
    [self createUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.orderArray != nil ? [self.orderArray count] : 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TRANS_VALUE(100.0f);
}

- (OrderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    if(!cell) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTableViewCell"];
    }
    if(indexPath.row < [self.orderArray count]) {
        NSDictionary *order = [self.orderArray objectAtIndex:indexPath.row];
        cell.order = order;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIButton Action
- (void)searchButtonAction {
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

#pragma mark - Private Method
- (void)createUI {
    
    self.searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonAction)];
    self.navigationItem.rightBarButtonItem = self.searchButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = I_COLOR_BACKGROUND;
    self.tableView.tableFooterView = [UIView new];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(5.0f))];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"OrderTableViewCell"];
}

- (void)loadData {
    if(!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    [_orderArray removeAllObjects];
    
    [_orderArray addObject:@{@"number" : @"1006", @"status" : @"0", @"content" : @"此项为测试信息，无实际意义，可通过此信息知晓内容字节及排版。"}];
    [_orderArray addObject:@{@"number" : @"1005", @"status" : @"1", @"content" : @"此项为测试信息，无实际意义，可通过此信息知晓内容字节及排版。"}];
    [_orderArray addObject:@{@"number" : @"1004", @"status" : @"1", @"content" : @"此项为测试信息，无实际意义，可通过此信息知晓内容字节及排版。"}];
    [_orderArray addObject:@{@"number" : @"1003", @"status" : @"2", @"content" : @"此项为测试信息，无实际意义，可通过此信息知晓内容字节及排版。"}];
    
    [self.tableView reloadData];
}

@end
