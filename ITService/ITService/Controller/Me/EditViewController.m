//
//  EditViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "EditViewController.h"
#import "MBProgressHUD+Toast.h"
#import "Context.h"

@interface EditViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"信息编辑";
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - UIButtonAction
- (void)submitButtonAction:(id)sender {
    NSString *messageStr = [NSString stringWithFormat:@"请输入您的%@!", self.type];
    NSString *textStr = self.textField.text;
    if(!textStr || [textStr isEqualToString:@""]) {
        [MBProgressHUD showToast:messageStr inTheView:self.view];
        return;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[Context sharedInstance].userInfo];
    if(self.type != nil && ![self.type isEqualToString:@""]) {
        [userInfo setValue:textStr forKey:self.type];
    }
    [Context sharedInstance].userInfo = userInfo;
    
    [MBProgressHUD showToast:@"提交成功" inTheView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - Private Method
- (void)createUI {
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(TRANS_VALUE(10.0f));
        make.height.equalTo(@(TRANS_VALUE(50.0f)));
    }];
    bgView.backgroundColor = I_COLOR_WHITE;
    
    self.textField = [[UITextField alloc] init];
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(TRANS_VALUE(10.0f));
        make.right.equalTo(bgView.mas_right).offset(-TRANS_VALUE(10.0f));
        make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
        make.bottom.equalTo(bgView.mas_bottom).offset(-TRANS_VALUE(10.0f));
    }];
    self.textField.font = [UIFont systemFontOfSize:15.0f];
    self.textField.textColor = I_COLOR_BLACK;
    self.textField.tintColor = I_COLOR_DARKGRAY;
    self.textField.delegate = self;
    self.textField.placeholder = @"请输入您的信息";
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(TRANS_VALUE(15.0f));
        make.right.equalTo(self.view.mas_right).offset(-TRANS_VALUE(15.0f));
        make.top.equalTo(bgView.mas_bottom).offset(TRANS_VALUE(100.0f));
        make.height.equalTo(@(TRANS_VALUE(42.0f)));
    }];
    self.submitButton.backgroundColor = UIColorFromRGB(0x1652cd);
    self.submitButton.clipsToBounds = YES;
    self.submitButton.layer.cornerRadius = TRANS_VALUE(3.0f);
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.submitButton setTitleColor:I_COLOR_WHITE forState:UIControlStateNormal];
    [self.submitButton setTitleColor:I_COLOR_WHITE forState:UIControlStateSelected];
    [self.submitButton setTitleColor:I_COLOR_WHITE forState:UIControlStateHighlighted];
    [self.submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提 交" forState:UIControlStateSelected];
    [self.submitButton setTitle:@"提 交" forState:UIControlStateHighlighted];
    
    [self.submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData {
    if(!_type) {
        self.navigationItem.title = @"信息编辑";
        self.textField.placeholder = @"请输入您的信息";
    } else {
        self.navigationItem.title = [NSString stringWithFormat:@"%@(编辑)", _type];
        NSString *messageStr = [NSString stringWithFormat:@"请输入您的%@", self.type];
        self.textField.placeholder = messageStr;
    }
}

@end
