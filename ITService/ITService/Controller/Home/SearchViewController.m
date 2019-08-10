//
//  SearchViewController.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "SearchViewController.h"
#import "TagListView.h"
#import "TagListTableViewCell.h"
#import "NSString+Utils.h"
#import "MBProgressHUD+Toast.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) UITextField *searchTextField;
@property (strong, nonatomic) UIBarButtonItem *searchButton;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TagListView *tagList;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableDictionary *selectTagDict;
@property (strong, nonatomic) UIButton *clearHistoryButton;
@property (strong, nonatomic) NSString *searchHistoriesCachePath;
@property (strong, nonatomic) NSMutableArray *searchHistories;
@property (nonatomic, assign) BOOL isSelect;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_WHITE;
    [self setBackNavgationItem];
    
    [self createUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
     [self.searchTextField becomeFirstResponder];
    self.searchTextField.text = @"";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private Method
- (void)createUI {
    //搜索按钮
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * TRANS_VALUE(44.0f), 30.0f)];
    searchTextField.font = [UIFont systemFontOfSize:16.0f];
    searchTextField.textColor = I_COLOR_33BLACK;
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.placeholder = @"输入你想搜索的内容...";
    searchTextField.tintColor = I_COLOR_DARKGRAY;
    self.navigationItem.titleView = searchTextField;
    self.searchTextField = searchTextField;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    
    //搜索按钮
    self.searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_information_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonAction)];
    self.navigationItem.rightBarButtonItem = self.searchButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TagListTableViewCell class] forCellReuseIdentifier:@"TagListTableViewCell"];
}

#pragma mark - UIButtonAction
- (void)searchButtonAction {
    //TODO --
    [self.view endEditing:YES];
    NSString *keywordStr = self.searchTextField.text;
    if([NSString isBlankString:keywordStr]) {
        [MBProgressHUD showToast:@"请输入查询关键字" initWithView:self.view];
        return;
    } else {
        if (self.isSelect == false) {
            self.isSelect = true;
            //保存搜索关键字
            [self.searchHistories addObject:keywordStr];
            if (self.searchHistories.count<=0) {
                return;
            }
//            [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
//            NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:0];
//            [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

//(清空历史记录)
- (void)clearHistoryButtonAction {
    NSString *message = @"是否清空历史记录?";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"清空" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self clearHistorySearches];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//清空历史记录
- (void)clearHistorySearches {
    [self.searchHistories removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
}

- (void)loadData {
    //搜索历史
    self.searchHistoriesCachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SearchHistories.plist"];
    NSArray *tags = @[@"OA系统", @"网络不稳定", @"4A系统"];
    [self.tagList addTags:tags];
    NSIndexSet *indexSex1 = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSex1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //TODO -- 搜索
    [textField resignFirstResponder];
    [self searchButtonAction];
    return YES;
}

#pragma mark - Table view data source
- (NSMutableDictionary *)selectTagDict {
    if (_selectTagDict == nil) {
        _selectTagDict = [NSMutableDictionary dictionary];
    }
    return _selectTagDict;
}

- (TagListView *)tagList {
    if (_tagList == nil) {
        _tagList = [[TagListView alloc] initWithFrame:CGRectMake(TRANS_VALUE(15.0f), 0, SCREEN_WIDTH - 2 * TRANS_VALUE(15.0f), 0)];
        _tagList.tagBackgroundColor = UIColorFromRGB(0xf5f5f5);;
        _tagList.tagCornerRadius = 4;
        __weak typeof(self) weakSelf = self;
        _tagList.clickTagBlock = ^(NSString *tag){
            [weakSelf clickTag:tag atTagListView:weakSelf.tagList];
        };
        _tagList.tagColor = I_COLOR_BLACK;
        
    }
    return _tagList;
}

- (void)deleteHistoryTag:(NSString *)tag {
    [_searchHistories removeObject:tag];
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    // 刷新第1组
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
}

- (void)clickTag:(NSString *)tag atTagListView:(TagListView *)tagListView {
    if(tagListView == _tagList) {
        self.searchTextField.text = tag;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(300 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [self searchButtonAction];
        });
    } else {
        self.searchTextField.text = tag;
        //TODO -- 跳转到结果界面
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(300 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            //调用查询
            [self searchButtonAction];
        });
    }
}

- (NSMutableArray *)searchHistories {
    if (!_searchHistories) {
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    }
    return _searchHistories;
}

#pragma mark - Table view data source
//返回多少个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 返回每一组有多少个标签组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TagListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagListTableViewCell"];
        cell.tagList = self.tagList;
        return cell;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return _tagList.tagListH;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TRANS_VALUE(44.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(44.0f))];
        headerView.backgroundColor = UIColorFromRGB(0xffffff);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TRANS_VALUE(15.0f), TRANS_VALUE(10.0f), TRANS_VALUE(160.0f), TRANS_VALUE(24.0f))];
        titleLabel.textColor = I_COLOR_BLACK;
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.text = @"热门搜索";
        [headerView addSubview:titleLabel];
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(44.0f))];
        headerView.backgroundColor = UIColorFromRGB(0xffffff);
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5f)];
        dividerView.backgroundColor = UIColorFromRGB(0xe6e6e6);
        [headerView addSubview:dividerView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TRANS_VALUE(15.0f), TRANS_VALUE(10.0f), TRANS_VALUE(160.0f), TRANS_VALUE(24.0f))];
        titleLabel.textColor = I_COLOR_BLACK;
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.text = @"历史记录";
        [headerView addSubview:titleLabel];
     
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - TRANS_VALUE(15.0f) - TRANS_VALUE(60.0f), TRANS_VALUE(6.0f), TRANS_VALUE(60.0f), TRANS_VALUE(32.0f))];
        button.titleLabel.font = RegularFont(TRANS_VALUE(16.0f));
        [button setImage:[UIImage imageNamed:@"ic_button_delete"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ic_button_delete"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"ic_button_delete"] forState:UIControlStateHighlighted];
        [headerView addSubview:button];
        self.clearHistoryButton = button;
        //清除历史数据
        [self.clearHistoryButton addTarget:self action:@selector(clearHistoryButtonAction) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 0) {
        return TRANS_VALUE(15.0f);
    } else {
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(20.0f))];
        footerView.backgroundColor = UIColorFromRGB(0xffffff);
        return footerView;
    } else {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(0.0f))];
        footerView.backgroundColor = UIColorFromRGB(0xffffff);
        return footerView;
    }
}


@end
