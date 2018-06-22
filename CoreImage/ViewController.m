//
//  ViewController.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/19.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import "PhotoLibrary.h"
#import "PhotoFilter.h"
#import "PhotoFilterViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)UIImage *originImage;
@property(nonatomic,strong)UIImage *filterImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:[[PhotoFilterViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)btnAction:(UIButton *)sender {
    __weak ViewController * weakSelf = self;
    
    switch (sender.tag) {
        case 0:
            {//选择图片
                [[PhotoLibrary sharePhotoLibrary] chooseVideoFromPhotoLibraryResult:^(NSURL *path, BOOL success) {
                    if (success) {
                        weakSelf.originImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:path]];
                        weakSelf.imageView.image = [weakSelf.originImage copy];
                    }
                }];
            }
            break;
        case 1:
            {//增加滤镜
                if (self.originImage) {
                    [[PhotoFilter sharePhotoFilter] setFilterWithNames:@[@"CIPointillize"] originImage:weakSelf.originImage complete:^(UIImage *image, BOOL success) {
                        if (success) {
                            weakSelf.filterImage = image;
                            weakSelf.imageView.image = image;
                        }
                    }];
                }
            }
            break;
            
        case 2:
            {//保存
                if (self.filterImage) {
                    [PhotoLibrary writePhotoWithImage:self.filterImage result:^(BOOL res) {
                        if (res) {
                            NSLog(@"保存成功！！！");
                        }
                    }];
                }
            }
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
