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

@interface PhotoFilterViewController ()
@property (weak, nonatomic) IBOutlet FilterMainView *filterMain;
@property (weak, nonatomic) IBOutlet UIView *photoToolBar;

@end

@implementation PhotoFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)initView {
    PhotoToolBarView * toolBarView = [PhotoToolBarView photoToolBarView];
    toolBarView.frame = _photoToolBar.bounds;
    [_photoToolBar addSubview:toolBarView];
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
