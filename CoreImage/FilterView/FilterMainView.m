//
//  FilterMainView.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/21.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterMainView.h"
#import "FilterModel.h"
#import "PhotoFilter.h"
@interface FilterMainView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, strong)UIImageView *mainImageView;
@property(nonatomic,strong)UIImage * originImage;
@end
@implementation FilterMainView
+ (id)filterMainView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    FilterMainView * mainView = [nib instantiateWithOwner:nil options:nil].firstObject;
    [mainView initView];
    return mainView;
}
- (void)selectFilterModel:(FilterModel *)filterModel {
    __weak FilterMainView * ws = self;
    [[PhotoFilter sharePhotoFilter] setFilterWithNames:@[filterModel.filterCode] originImage:self.originImage complete:^(UIImage *image, BOOL success) {
        if (success && image) {
            [UIView animateWithDuration:0.5 animations:^{
                ws.mainImageView.image = image;
            }];
        }
    }];
}
- (void)initView {
    _mainScrollView.delegate = self;
    _mainScrollView.bouncesZoom = YES;
    _mainScrollView.maximumZoomScale = 2.5;//最大放大倍数
    _mainScrollView.minimumZoomScale = 1.0;//最小缩小倍数
    _mainScrollView.multipleTouchEnabled = YES;
    _mainScrollView.scrollsToTop = NO;
    _mainScrollView.contentSize = CGSizeMake(Screen_Width, Screen_Width * 4/3);
    _mainScrollView.userInteractionEnabled = YES;
    _mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _mainScrollView.delaysContentTouches = NO;//默认yes  设置NO则无论手指移动的多么快，始终都会将触摸事件传递给内部控件；
//    _mainScrollView.canCancelContentTouches = NO; // 默认是yes
//    _mainScrollView.alwaysBounceVertical = YES;//设置上下回弹
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        //表示只在ios11以上的版本执行
        _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_mainScrollView addSubview:self.mainImageView];
}

- (void)initOriginImage:(UIImage *)image {
    CGFloat imageH = Screen_Width * image.size.height/image.size.width;
    CGFloat imageY;
    if (iPhoneX) {
        imageY = NavBar_SafeArea + (Screen_Width *2/3-imageH/2);
    } else {
        imageY = 20 + (Screen_Width *2/3-imageH/2);
    }
    
    self.mainImageView.frame = CGRectMake(0, 0, Screen_Width, Screen_Width*4/3);
    self.mainImageView.image = image;
    self.originImage = image;
//    _mainImageW.constant = Screen_Width;
//    _mianImageH.constant = Screen_Width * image.size.height / image.size.width;
}

#pragma mark --scrollView delegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.mainImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.mainImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIImageView *)mainImageView {
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _mainImageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
