//
//  PhotoFilterViewController.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/21.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "PhotoFilterViewController.h"
#import "FilterMainView.h"
#import "PhotoToolBarView.h"
#import "FilterCategoryModel.h"
#import "FilterModel.h"

@interface PhotoFilterViewController ()
@property (weak, nonatomic) IBOutlet UIView *filterMain;
@property (weak, nonatomic) IBOutlet UIView *photoToolBar;

@end

@implementation PhotoFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)initView {
    FilterMainView * mainView = [FilterMainView filterMainView];
    mainView.frame = _filterMain.bounds;
    [_filterMain addSubview:mainView];
    [mainView initOriginImage:self.originImage];

    
    PhotoToolBarView * toolBarView = [PhotoToolBarView photoToolBarView];
    toolBarView.frame = _photoToolBar.bounds;
    [toolBarView initOriginImage:self.originImage];
    [_photoToolBar addSubview:toolBarView];
    __weak PhotoFilterViewController * weakSelf = self;
    [toolBarView setPhotoToolBlock:^(PhotoToolType photoToolType, FilterModel * _Nullable filterModel) {
        switch (photoToolType) {
            case PhotoToolTypeBack:
                {//返回上一层
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
                break;
            case PhotoToolTypeSelectFilter:
                {//处理滤镜
                    [mainView selectFilterModel:filterModel];
                }
                break;
            default:
                break;
        }
    }];
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

@end
