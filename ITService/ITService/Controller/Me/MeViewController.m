//
//  MeViewController.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "MeViewController.h"
#import "SettingTableViewCell.h"
#import <HXPhotoPicker/HXPhotoPicker.h>
#import "EditViewController.h"
#import "Context.h"

@interface MeViewController () <UITableViewDelegate, UITableViewDataSource, HXCustomCameraViewControllerDelegate, SettingTableViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) UIImage *headerImage;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = I_COLOR_BACKGROUND;
    self.navigationItem.title = @"设置";
    
    [self createUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _data = [NSMutableDictionary dictionaryWithDictionary:[Context sharedInstance].userInfo];
    [self.tableView reloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.deleteTemporaryPhoto = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.navigationBar = ^(UINavigationBar *navigationBar, UIViewController *viewController) {
        };
        __weak typeof(self) weakSelf = self;
        // 使用自动的相机  这里拿系统相机做示例
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
        //        _manager.shouldSelectModel = ^NSString *(HXPhotoModel *model) {
        //            // 如果return nil 则会走默认的判断是否达到最大值
        //            //return nil;
        //            return @"Demo1 116 - 120 行注释掉就能选啦~\(≧▽≦)/~";
        //        };
        _manager.configuration.videoCanEdit = NO;
        _manager.configuration.photoCanEdit = NO;
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

#pragma mark - UITableViewDelegate && UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.titleArray != nil ? [self.titleArray count] : 0;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.titleArray || section >= [self.titleArray count]) {
        return 0;
    }
    
    NSInteger count = self.titleArray[section] != nil ? [self.titleArray[section] count] : 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TRANS_VALUE(6.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(10.0f))];
    headerView.backgroundColor = UIColorFromRGB(0xf4f6f7);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0) {
        return TRANS_VALUE(78.0f);
    } else {
        return TRANS_VALUE(48.0f);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    if(!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingTableViewCell"];
    }
    NSString *title = self.titleArray[indexPath.section][indexPath.row];
    cell.title = title;
    cell.content = [self.data objectForKey:title];
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        if(self.headerImage != nil) {
            cell.headImage = self.headerImage;
        } else {
            cell.headImage = [UIImage imageNamed:@"ic_me_head_default"];
        }
    } else {
        cell.headImage = nil;
    }
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0) {
        //TODO -- 头像
        [self selectHeaderImage];
        return;
    } else {
        if(indexPath.section == 1) {
            //TODO -- 弹出选择框
            return;
        } else {
            NSString *title = nil;
            if(indexPath.section == 0 && indexPath.row == 1) {
                title = @"姓名";
            } else if(indexPath.section == 0 && indexPath.row == 2) {
                title = @"手机号";
            } else if(indexPath.section == 2 && indexPath.row == 0) {
                title = @"办公室电话";
            } else if(indexPath.section == 2 && indexPath.row == 1) {
                title = @"地址";
            } else if(indexPath.section == 2 && indexPath.row == 2) {
                title = @"邮编";
            }
            EditViewController *editViewController = [[EditViewController alloc] init];
            editViewController.type = title;
            editViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:editViewController animated:YES];
        }
    }
}

#pragma mark - SettingTableViewCellDelegate
- (void)avatarClickAction {
    [self selectHeaderImage];
}

- (void)selectHeaderImage {
    self.manager.configuration.photoMaxNum = 1;
    self.manager.configuration.rowCount = 3;
    self.manager.configuration.saveSystemAblum = YES;
    self.manager.configuration.navigationTitleSynchColor = YES;
    self.manager.configuration.replaceCameraViewController = YES;
    self.manager.configuration.openCamera = YES;
    self.manager.configuration.albumShowMode = HXPhotoAlbumShowModeDefault;
   __weak typeof(self) weakSelf = self;
    [self hx_presentSelectPhotoControllerWithManager:self.manager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
    } imageList:^(NSArray<UIImage *> *imageList, BOOL isOriginal) {
        NSSLog(@"block - images - %@",imageList);
        if(imageList != nil && imageList.count >= 1) {
            weakSelf.headerImage = imageList[0];
        } else {
            weakSelf.headerImage = nil;
        }
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        NSSLog(@"block - 取消了");
    }];
}

#pragma mark - UIButton Action
- (void)logoutAction:(id)sender {
    //TODO -- 退出登录
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alerController addAction:cancelAction];
    [alerController addAction:confirmAction];
    [self presentViewController:alerController animated:YES completion:^{
    }];
}

#pragma mark - Private Method
- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.tableView.backgroundColor = I_COLOR_BACKGROUND;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [UIView new];
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"SettingTableViewCell"];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TRANS_VALUE(76.0f))];
    footerView.backgroundColor = UIColorFromRGB(0xf4f6f7);
    self.tableView.tableFooterView = footerView;
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerView addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footerView);
        make.top.equalTo(footerView.mas_top).offset(TRANS_VALUE(16.0f));
        make.bottom.equalTo(footerView.mas_bottom).offset(-TRANS_VALUE(16.0f));
    }];
    self.logoutButton.backgroundColor = I_COLOR_WHITE;
    self.logoutButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.logoutButton setTitleColor:I_COLOR_BLUE forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:I_COLOR_BLUE forState:UIControlStateSelected];
    [self.logoutButton setTitleColor:I_COLOR_BLUE forState:UIControlStateHighlighted];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateSelected];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateHighlighted];
    
    [self.logoutButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData {
    if(!_data) {
        _data = [NSMutableDictionary dictionary];
    }
    [_data removeAllObjects];
    [_data setValue:@"头像" forKey:@"头像"];
    [_data setValue:@"张尚义" forKey:@"姓名"];
    [_data setValue:@"13666668888" forKey:@"手机号"];
    [_data setValue:@"普洱供电局思茅分局" forKey:@"单位"];
    [_data setValue:@"信息班" forKey:@"部门"];
    [_data setValue:@"班长" forKey:@"岗位"];
    [_data setValue:@"0888-009988" forKey:@"办公室电话"];
    [_data setValue:@"XXXXXXXXXX" forKey:@"地址"];
    [_data setValue:@"000000" forKey:@"邮编"];
    
    [Context sharedInstance].userInfo = _data;
    _data = [NSMutableDictionary dictionaryWithDictionary:[Context sharedInstance].userInfo];
    
    if(!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    [_titleArray removeAllObjects];
    [_titleArray addObjectsFromArray:@[@[@"头像", @"姓名", @"手机号"],
                                       @[@"单位", @"部门", @"岗位"],
                                       @[@"办公室电话", @"地址", @"邮编"]]];
    [self.tableView reloadData];
}


@end
