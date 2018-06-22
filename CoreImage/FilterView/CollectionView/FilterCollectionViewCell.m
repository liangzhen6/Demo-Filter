//
//  FilterCollectionViewCell.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterCollectionViewCell.h"
#import "FilterModel.h"
@interface FilterCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end
@implementation FilterCollectionViewCell

- (void)setFilterModel:(FilterModel *)filterModel {
    _filterModel = filterModel;
    _title.text = filterModel.filterName;
//    if (filterModel.filterImage) {
//        _imageView.image = filterModel.filterImage;
//    } else {
//        _imageView.image = filterModel.originImage;
//    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.filterBlock) {
        self.filterBlock(_filterModel);
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
    // Initialization code
}

@end
