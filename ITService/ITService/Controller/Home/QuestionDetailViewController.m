//
//  QuestionDetailViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "MBProgressHUD+Toast.h"

@interface QuestionDetailViewController ()

@property (strong, nonatomic) UIButton *helpfulButton;
@property (strong, nonatomic) UIButton *helplessButton;
@property (strong, nonatomic) UIButton *serviceButton;

@end

@implementation QuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_WHITE;
    self.navigationItem.title = @"问题详情";
    [self setBackNavgationItem];
    
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

#pragma mark - UIButton Action
- (void)buttonClickAction:(id)sender {
    if(sender == self.helpfulButton) {
        [MBProgressHUD showToast:@"有帮助!" inTheView:self.view];
    } else if(sender == self.helplessButton) {
        [MBProgressHUD showToast:@"没帮助!" inTheView:self.view];
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
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(TRANS_VALUE(436)));
    }];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"bg_detail"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(150.0f)));
        make.height.equalTo(@(TRANS_VALUE(20.0f)));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(imageView.mas_bottom).offset(TRANS_VALUE(40.0f));
    }];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = I_COLOR_BLACK;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"以上方案对您是否有帮助";
    
    UIView *leftDivider = [[UIView alloc] init];
    [self.view addSubview:leftDivider];
    [leftDivider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5f));
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(titleLabel.mas_left);
    }];
    leftDivider.backgroundColor = I_COLOR_DIVIDER;
    
    UIView *rightDivider = [[UIView alloc] init];
    [self.view addSubview:rightDivider];
    [rightDivider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5f));
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(titleLabel.mas_right);
        make.right.equalTo(self.view.mas_right);
    }];
    rightDivider.backgroundColor = I_COLOR_DIVIDER;
    
    self.helpfulButton = [self buttonWithTitle:@"有帮助" titleColor:UIColorFromRGB(0x1859d3) image:@"ic_question_helpful"];
    [self.view addSubview:self.helpfulButton];
    [self.helpfulButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(120.0f)));
        make.height.equalTo(@(TRANS_VALUE(40.0f)));
        make.left.equalTo(self.view.mas_left).offset(TRANS_VALUE(40.0f));
        make.top.equalTo(titleLabel.mas_bottom).offset(TRANS_VALUE(6.0f));
    }];
    [self.helpfulButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.helplessButton = [self buttonWithTitle:@"没帮助" titleColor:UIColorFromRGB(0xa8b9cd) image:@"ic_question_helpless"];
    [self.view addSubview:self.helplessButton];
    [self.helplessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(120.0f)));
        make.height.equalTo(@(TRANS_VALUE(40.0f)));
        make.right.equalTo(self.view.mas_right).offset(-TRANS_VALUE(40.0f));
        make.top.equalTo(titleLabel.mas_bottom).offset(TRANS_VALUE(6.0f));
    }];
    [self.helplessButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *title = @"问题仍未解决? 联系客服";
    self.serviceButton = [self buttonWithTitle:title titleColor:I_COLOR_BLACK image:@"ic_home_more"];
    CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(CGFLOAT_MAX, TRANS_VALUE(30.0f)) lineBreakMode:NSLineBreakByWordWrapping];
    [self.serviceButton setImageEdgeInsets:UIEdgeInsetsMake(0, sizeToFit.width + 26, 0, 0)];
    [self.serviceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -26.0f, 0, 0)];
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xa6a6a6) range:NSMakeRange(0,7)];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:I_COLOR_BLACK range:NSMakeRange(7,title.length - 7)];
    [self.serviceButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [self.serviceButton setAttributedTitle:attributedTitle forState:UIControlStateHighlighted];
    [self.serviceButton setAttributedTitle:attributedTitle forState:UIControlStateSelected];
    
    [self.view addSubview:self.serviceButton];
    [self.serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TRANS_VALUE(200.0f)));
        make.height.equalTo(@(TRANS_VALUE(30.0f)));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.helpfulButton.mas_bottom).offset(TRANS_VALUE(5.0f));
    }];
    [self.serviceButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color image:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    return button;
}

- (void)loadData {
    
}

@end
