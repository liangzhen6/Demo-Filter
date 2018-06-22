//
//  PhotoToolBarView.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/21.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "PhotoToolBarView.h"
#import "FilterCollectionViewCell.h"
#import "FilterCollectionViewHeader.h"
#import "FilterCategoryModel.h"

@interface PhotoToolBarView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topToolView;
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
@property (weak, nonatomic) IBOutlet UIView *bottomTool;
@property(nonatomic,strong)NSMutableArray *dataArrM;
@property(nonatomic,strong)UICollectionView * collectionView;
@end

static NSString * const collectionCell = @"FilterCollectionViewCell";
static NSString * const collectionHeader = @"FilterCollectionViewHeader";

@implementation PhotoToolBarView
+ (id)photoToolBarView {
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    PhotoToolBarView * photoTool = [nib instantiateWithOwner:nil options:nil].firstObject;
//    [photoTool initView];
//    [photoTool initData];
    return photoTool;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self initView];
    [self initData];
}
- (void)initView {
    
    CGFloat H;
    if (iPhoneX) {
        H = (Screen_Height - Screen_Width*4/3 - TabBar_SafeArea - NavBar_SafeArea)*2/3;
    } else {
        H = (Screen_Height - Screen_Width*4/3 -20)*2/3;
    }
    DBNLog(@"%f---%f",H,Screen_Height);
    //顶部控制 栏
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(H-30, H-10);
    layout.minimumLineSpacing = 5; //最小行间距
    layout.minimumInteritemSpacing = 20; //cell 之间最大间距
    layout.headerReferenceSize = CGSizeMake((H-10)*3/4, H-10);
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, H) collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib * cellNib = [UINib nibWithNibName:NSStringFromClass([FilterCollectionViewCell class]) bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCell];
    
    UINib * headerNib = [UINib nibWithNibName:NSStringFromClass([FilterCollectionViewHeader class]) bundle:nil];
    [collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader];
    _collectionView = collectionView;
    [_topToolView addSubview:collectionView];
    
    
    
    //底部 控制栏UI
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.tag = 0;
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomTool addSubview:backBtn];
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-50, 0, 40, 40)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.tag = 5;
    saveBtn.backgroundColor = [UIColor redColor];
    [saveBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomTool addSubview:saveBtn];

    CGFloat X = Screen_Width/2 - 95;
    NSArray * titles = @[@"调整", @"布局", @"滤镜", @"元素"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50*i + X, 0, 40, 40)];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = 1 + i;
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomTool addSubview:btn];
    }
    
}
#pragma mark ====data===
- (void)initData {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"FilterData" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary * dict in array) {
        [self.dataArrM addObject:[FilterCategoryModel filterCategoryModelWithDict:dict]];;
    }
    [self.collectionView reloadData];
}

- (IBAction)btnAction:(UIButton *)sender {
    DBNLog(@"按钮tag:%ld",(long)sender.tag);
    switch (sender.tag) {
        case 0:
            {//返回
            
                
            }
            break;
        case 1:
            {//调整
            
            
            }
            break;
        case 2:
            {//布局
            
            
            }
            break;
        case 3:
            {//滤镜
            
            
            }
            break;
        case 4:
            {//元素
            
            
            }
            break;
        case 5:
            {//保存
            
            
            }
            break;
        default:
            break;
    }
    
}


#pragma mark --UICollectionViewDelegate-
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark --UICollectionViewDataSource-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArrM.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FilterCategoryModel * categoryModel = self.dataArrM[section];
    if (categoryModel.isOpen) {
        return categoryModel.filterArray.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    NSArray * subArr = [self.dataArrM[indexPath.section] filterArray];
    //设置 数据源
    cell.filterModel = subArr[indexPath.item];
    
    __weak PhotoToolBarView * weakSelf = self;
    [cell setFilterBlock:^(FilterModel *model) {
        //弹出 调节滤镜的参数工具
        DBNLog(@"弹出 调节滤镜的参数工具");
    }];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //header
        FilterCollectionViewHeader * headerView = (FilterCollectionViewHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeader forIndexPath:indexPath];
        
        headerView.categoryModel = self.dataArrM[indexPath.section];
        __weak PhotoToolBarView * weakSelf = self;
        [headerView setBlock:^(FilterCategoryModel *categoryModel) {
            //之前是开着的
            NSInteger lastOpenSection = [weakSelf chicklLastOpenSection];
            //现在选中的
            NSInteger section = [weakSelf.dataArrM indexOfObject:categoryModel];
            if (lastOpenSection > -1 && section != lastOpenSection) {
                FilterCategoryModel *categoryModel = self.dataArrM[lastOpenSection];
                categoryModel.isOpen = NO;
                [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:lastOpenSection]];
            }
            //刷新 collection 的这一组
            categoryModel.isOpen = !categoryModel.isOpen;
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
        }];
        //设置 数据
        return headerView;
    }
    return [[UICollectionReusableView alloc] init];
}
- (NSInteger)chicklLastOpenSection {
    for (NSInteger i = 0; i < self.dataArrM.count; i++) {
        FilterCategoryModel * model = self.dataArrM[i];
        if (model.isOpen) {
            return i;
        }
    }
    return -1;
}
#pragma mark --lazy
- (NSMutableArray *)dataArrM {
    if (_dataArrM == nil) {
        _dataArrM = [[NSMutableArray alloc] init];
    }
    return _dataArrM;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
