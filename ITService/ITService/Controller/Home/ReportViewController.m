//
//  ReportViewController.m
//  ITService
//
//  Created by 许成雄 on 2019/1/8.
//  Copyright © 2019 hanyun. All rights reserved.
//

#import "ReportViewController.h"
#import "HXPhotoPicker.h"

@interface ReportViewController () <UITextViewDelegate, HXPhotoViewDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *placeHolder;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) NSMutableArray *imageArray;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"故障申报";
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
- (void)textViewDidChange:(UITextView *)textView {
    
    self.placeHolder.hidden = YES;
    //允许提交按钮点击操作
    
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeHolder.hidden = NO;
    }
}

#pragma mark - HXPhotoViewDelegate
- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 4;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 4;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        _manager.configuration.requestImageAfterFinishingSelection = YES;
        __weak typeof(self) weakSelf = self;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:image];
        } else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithImage:image];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url];
        }else {
            HXPhotoModel *model = [HXPhotoModel photoModelWithVideoURL:url];
            if (self.manager.configuration.useCameraComplete) {
                self.manager.configuration.useCameraComplete(model);
            }
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
}

- (void)photoView:(HXPhotoView *)photoView imageChangeComplete:(NSArray<UIImage *> *)imageList {
    NSSLog(@"%@",imageList);
    self.imageArray = [NSMutableArray arrayWithArray:imageList];
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    
}

- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView gestureRecognizer:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
}


#pragma mark - UIButtonAction
- (void)submitButtonAction:(id)sender {
    NSString *adviseStr = self.textView.text;
    if(!adviseStr || [adviseStr isEqualToString:@""]) {
        [MBProgressHUD showToast:@"请输入您要申报的故障" inTheView:self.view];
        return;
    }
    if(!self.imageArray || [self.imageArray count] == 0) {
        [MBProgressHUD showToast:@"请添加图片" inTheView:self.view];
        return;
    }
    [MBProgressHUD showToast:@"申报成功" inTheView:self.view];
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
        make.height.equalTo(@(TRANS_VALUE(90.0f)));
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
        make.top.equalTo(bgView.mas_top).offset(TRANS_VALUE(10.0f));
        make.height.equalTo(@(TRANS_VALUE(20.0f)));
    }];
    self.placeHolder.font = [UIFont systemFontOfSize:15.0f];
    self.placeHolder.textColor = I_COLOR_GRAY;
    self.placeHolder.textAlignment = NSTextAlignmentLeft;
    self.placeHolder.numberOfLines = 1;
    self.placeHolder.text = @"请填写您要申报的故障";
    
    self.photoView = [HXPhotoView photoManager:self.manager];
    self.photoView.delegate = self;
    self.photoView.outerCamera = YES;
    self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
    self.photoView.previewShowDeleteButton = YES;
    self.photoView.lineCount = 4;
    self.photoView.spacing = 10.0f;
    //    photoView.hideDeleteButton = YES;
    self.photoView.showAddCell = YES;
    //    photoView.disableaInteractiveTransition = YES;
    [self.photoView.collectionView reloadData];
    self.photoView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10.0f);
        make.right.equalTo(bgView.mas_right).offset(-10.0f);
        make.height.equalTo(@(TRANS_VALUE(90.0f)));
        make.bottom.equalTo(bgView.mas_bottom).offset(-TRANS_VALUE(5.0f));
    }];
    
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
