//
//  FilterCollectionViewHeader.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterCollectionViewHeader.h"
#import "FilterCategoryModel.h"
@interface FilterCollectionViewHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation FilterCollectionViewHeader

- (void)setCategoryModel:(FilterCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    _imageView.image = [UIImage imageNamed:categoryModel.imageStr];
    _title.text = categoryModel.title;
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
//    _categoryModel.isOpen = !_categoryModel.isOpen;
    if (self.block) {
        self.block(_categoryModel);
    }
}
 

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    // Initialization code
}

@end
