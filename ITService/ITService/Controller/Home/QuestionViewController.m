//
//  QuestionViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "QuestionViewController.h"
#import "ZJScrollPageView.h"
#import "QuestionSubViewController.h"

@interface QuestionViewController () <ZJScrollPageViewDelegate>

@property (strong, nonatomic) ZJScrollPageView *scrollPageView;
@property (strong, nonatomic) NSMutableArray *childViewControllers;
@property (strong, nonatomic) NSMutableArray *titles;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"常见问题";
    [self setBackNavgationItem];
    
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

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    NSInteger count = self.titles != nil ? self.titles.count : 0;
    return count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childViewController = reuseViewController;
    if(!childViewController || ![childViewController isKindOfClass:[QuestionSubViewController class]]) {
        childViewController = [[QuestionSubViewController alloc] init];
    }
    if( index > 0 && index < self.titles.count) {
        ((QuestionSubViewController *)childViewController).typeId = @"1";
    }
    [((QuestionSubViewController *)childViewController) reloadData];
    return childViewController;
}

#pragma mark - Private Method
- (void)createUI:(NSArray *)titles {
    
    ZJSegmentStyle *segmentStyle = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    segmentStyle.showLine = YES;
    //颜色渐变
    segmentStyle.gradualChangeTitleColor = YES;
    //显示黄色光影
    segmentStyle.showShadow = YES;
    
    segmentStyle.titleFont = [UIFont boldSystemFontOfSize:15.0f];
    segmentStyle.selectedTitleColor = I_COLOR_BLUE;
    segmentStyle.normalTitleColor = I_COLOR_GRAY;
    segmentStyle.scrollLineColor = I_COLOR_BLUE;
    
    CGFloat titleWidths = 0.0f;
    for(NSInteger index = 0, count = titles.count; index < count; index++) {
        titleWidths += [self sizeOfTitle:titles[index] fontSize:15.0f].width;
    }
    CGFloat titleMargin = (SCREEN_WIDTH - titleWidths) * 1.0 / (titles.count + 1);
    segmentStyle.titleMargin = titleMargin;
    segmentStyle.segmentHeight = 44.0f;
    
    self.scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(TRANS_VALUE(0.0f), TRANS_VALUE(0.0f), SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f) segmentStyle:segmentStyle titles:titles parentViewController:self delegate:self];
    [self.view addSubview:self.scrollPageView];
    
}

- (CGSize)sizeOfTitle:(NSString *)title fontSize:(CGFloat)fontSize {
    CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 44.0f) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit;
}

- (void)loadData {
    if(!_titles) {
        _titles = [NSMutableArray array];
    }
    [_titles removeAllObjects];
    [_titles addObjectsFromArray:@[@"上报",@"已受理", @"已处理", @"已完成"]];
    //资讯类型列表
    [self createUI:_titles];
}

@end
