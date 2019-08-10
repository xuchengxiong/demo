//
//  Report2ViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "Report2ViewController.h"
#import "MBProgressHUD+Toast.h"

@interface Report2ViewController () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *placeHolder;
@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation Report2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"问题申报";
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

#pragma mark - UITextViewDelegate
//正在改变
- (void)textViewDidChange:(UITextView *)textView {
    
    self.placeHolder.hidden = YES;
    //允许提交按钮点击操作

    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeHolder.hidden = NO;
    }
}

#pragma mark - UIButtonAction
- (void)submitButtonAction:(id)sender {
    NSString *adviseStr = self.textView.text;
    if(!adviseStr || [adviseStr isEqualToString:@""]) {
        [MBProgressHUD showToast:@"请添加您申报的问题" inTheView:self.view];
        return;
    }
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
        make.height.equalTo(@(TRANS_VALUE(200.0f)));
    }];
    bgView.backgroundColor = I_COLOR_WHITE;
    
    self.textView = [[UITextView alloc] init];
    [bgView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(TRANS_VALUE(10.0f));
        make.right.equalTo(bgView.mas_right).offset(-TRANS_VALUE(10.0f));
        make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(5.0f));
        make.bottom.equalTo(bgView.mas_bottom).offset(-TRANS_VALUE(5.0f));
    }];
    self.textView.font = [UIFont systemFontOfSize:15.0f];
    self.textView.textColor = I_COLOR_BLACK;
    self.textView.tintColor = I_COLOR_DARKGRAY;
    self.textView.delegate = self;
    
    self.placeHolder = [[UILabel alloc] init];
    [bgView addSubview:self.placeHolder];
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(TRANS_VALUE(15.0f));
        make.right.equalTo(bgView.mas_right).offset(-TRANS_VALUE(15.0f));
        make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(8.0f));
        make.height.equalTo(@(TRANS_VALUE(40.0f)));
    }];
    self.placeHolder.font = [UIFont systemFontOfSize:15.0f];
    self.placeHolder.textColor = I_COLOR_GRAY;
    self.placeHolder.textAlignment = NSTextAlignmentLeft;
    self.placeHolder.numberOfLines = 2;
    self.placeHolder.text = @"请填写您申报的问题, 内容尽可能详尽, 以便我们及时排查和修复、高效优质服务~";
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(TRANS_VALUE(15.0f));
        make.right.equalTo(self.view.mas_right).offset(-TRANS_VALUE(15.0f));
        make.top.equalTo(bgView.mas_bottom).offset(TRANS_VALUE(56.0f));
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
    
}

@end
