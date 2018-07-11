//
//  FilterCollectionViewCell.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterCollectionViewCell.h"
#import "FilterModel.h"
#import "PhotoFilter.h"
@interface FilterCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end
@implementation FilterCollectionViewCell

- (void)setFilterModel:(FilterModel *)filterModel {
    _filterModel = filterModel;
    _title.text = filterModel.filterName;
    if (filterModel.filterImage) {
//        _maskView.hidden = YES;
        _imageView.image = filterModel.filterImage;
    } else {
//        _maskView.hidden = NO;
        _imageView.image = filterModel.originImage;
        
        __weak FilterCollectionViewCell * ws = self;
        //处理滤镜
        [[PhotoFilter sharePhotoFilter] setFilterWithNames:@[filterModel.filterCode] originImage:filterModel.originImage complete:^(UIImage *image, BOOL success) {
            if (success && image) {
                filterModel.filterImage = image;
                if (ws.filterBlock) {
                    ws.filterBlock(FilterCellTypeRefresh, filterModel);
                }
            }
        }];
    }
    if (filterModel.isSelect) {
        _maskView.hidden = NO;
    } else {
        _maskView.hidden = YES;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.filterBlock) {
        if (self.filterBlock) {
            self.filterBlock(FilterCellTypeShowToolBar, _filterModel);
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //切圆角
//    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
//    shapeLayer.frame = _imageView.bounds;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds cornerRadius:10];
//    shapeLayer.path = path.CGPath;
//    _imageView.layer.mask = shapeLayer;
    
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_maskView addGestureRecognizer:tap];
    // Initialization code
}

@end
