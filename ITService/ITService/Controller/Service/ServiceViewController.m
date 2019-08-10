//
//  ServiceViewController.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "ServiceViewController.h"
#import "UIImage+Color.h"
#import "Report2ViewController.h"
#import "QuestionDetailViewController.h"

@interface ServiceViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITextField *searchTextField;         //搜索框
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *reportButton;
@property (strong, nonatomic) UIButton *changeButton;
@property (strong, nonatomic) UIButton *serviceButton;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_WHITE;
    self.navigationItem.title = @"智能客服";
    
    [self createUI];
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


#pragma mark - UITableViewDelegate && UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataArray != nil ? self.dataArray.count : 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TRANS_VALUE(50.0f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.row < [self.dataArray count]) {
        NSString *title = [self.dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDetailViewController *detailViewController = [[QuestionDetailViewController alloc] init];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //TODO -- 搜索查询条件
    
    return YES;
}

#pragma mark - UIButton Action
- (void)buttonClickAction:(id)sender {
    if(sender == self.reportButton) {
        //TODO -- 上报问题
        Report2ViewController *reportViewController = [[Report2ViewController alloc] init];
        reportViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reportViewController animated:YES];
        
    } else if(sender == self.changeButton) {
        //TODO -- 换一换
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray addObject:@"OA系统"];
            [self.dataArray addObject:@"网络不稳定"];
            [self.dataArray addObject:@"4A系统"];
            [self.tableView reloadData];
        });
    } else {
        //TODO -- 联系客服
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请拨打「10000」联系人工客服" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alerController addAction:alertAction];
        [self presentViewController:alerController animated:YES completion:^{
        }];
    }
    
}

#pragma mark - Private Method
- (void)createUI {
    UIView *searchBar = [[UIView alloc] init];
    searchBar.clipsToBounds = YES;
    searchBar.layer.cornerRadius = TRANS_VALUE(32.0f) / 2;
    searchBar.backgroundColor = UIColorFromRGB(0xf4f6f7);
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(TRANS_VALUE(10.0f));
        make.right.equalTo(self.view).offset(-TRANS_VALUE(10.0f));
        make.top.equalTo(self.view).offset(TRANS_VALUE(10.0f));
        make.height.equalTo(@(TRANS_VALUE(32.0f)));
    }];
    
    self.searchTextField = [[UITextField alloc] init];
    [searchBar addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBar.mas_left).offset(TRANS_VALUE(16.0f));
        make.right.equalTo(searchBar.mas_right).offset(-TRANS_VALUE(16.0f));
        make.top.bottom.equalTo(searchBar);
    }];
    
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TRANS_VALUE(24.0f), TRANS_VALUE(16.0f))];
    searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    searchImageView.image = [UIImage imageNamed:@"ic_search"];
    self.searchTextField.leftView = searchImageView;
    self.searchTextField.tintColor = I_COLOR_33BLACK;
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.placeholder = @"请输入查询关键字";
    self.searchTextField.font = [UIFont systemFontOfSize:16.0f];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = I_COLOR_DIVIDER;
    [self.view addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(searchBar.mas_bottom).offset(TRANS_VALUE(10.0f));
        make.height.equalTo(@(0.5f));
    }];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = I_COLOR_WHITE;
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(TRANS_VALUE(60.0f)));
    }];
    
    self.changeButton = [self buttonWithTitle:@"换一换" imageNamed:@"ic_button_change" backgroundColor:I_COLOR_GREEN];
    [footerView addSubview:self.changeButton];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(100)));
        make.height.equalTo(@(TRANS_VALUE(34.0f)));
        make.center.equalTo(footerView);
    }];
    [self.changeButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.reportButton = [self buttonWithTitle:@"申报问题" imageNamed:@"ic_button_report" backgroundColor:I_COLOR_BLUE];
    [footerView addSubview:self.reportButton];
    [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(100)));
        make.height.equalTo(@(TRANS_VALUE(34.0f)));
        make.centerY.equalTo(footerView.mas_centerY);
        make.left.equalTo(footerView.mas_left).offset(TRANS_VALUE(10.0f));
    }];
    [self.reportButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.serviceButton = [self buttonWithTitle:@"联系客服" imageNamed:@"ic_button_service" backgroundColor:I_COLOR_PURPLE];
    [footerView addSubview:self.serviceButton];
    [self.serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(100)));
        make.height.equalTo(@(TRANS_VALUE(34.0f)));
        make.centerY.equalTo(footerView.mas_centerY);
        make.right.equalTo(footerView.mas_right).offset(-TRANS_VALUE(10.0f));
    }];
    [self.serviceButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(dividerView.mas_bottom);
        make.bottom.equalTo(footerView.mas_top);
    }];
    self.tableView.backgroundColor = I_COLOR_WHITE;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)loadData {
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@"网络中断, 无法访问业务系统"];
    [self.dataArray addObject:@"OA系统"];
    [self.dataArray addObject:@"网络不稳定"];
    [self.dataArray addObject:@"4A系统"];
    [self.dataArray addObject:@"网络中断, 无法访问业务系统"];
    [self.dataArray addObject:@"OA系统"];
    [self.dataArray addObject:@"网络不稳定"];
    [self.dataArray addObject:@"4A系统"];
    
    [self.tableView reloadData];
}

- (UIButton *)buttonWithTitle:(NSString *)title imageNamed:(NSString *)imageName backgroundColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:I_COLOR_WHITE forState:UIControlStateNormal];
    [button setTitleColor:I_COLOR_WHITE forState:UIControlStateHighlighted];
    [button setTitleColor:I_COLOR_WHITE forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = TRANS_VALUE(34.0f) / 2;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    return button;
}


@end
