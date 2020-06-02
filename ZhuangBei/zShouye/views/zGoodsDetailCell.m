//
//  zGoodsDetailCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGoodsDetailCell.h"
#import "zCityCollectionCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface zGoodsDetailCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView * BaseView;

@property(strong,nonatomic)UICollectionView * cityCollectView;

@end

@implementation zGoodsDetailCell

+(zGoodsDetailCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zGoodsDetailCell";
    zGoodsDetailCell * cell = [[zGoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)BaseView
{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]init];
    }
    return _BaseView;
}

-(UICollectionView*)cityCollectView
{
    if (!_cityCollectView) {
        UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10,0, 10,0);
        layout.minimumLineSpacing = kWidthFlot(10);
        layout.minimumInteritemSpacing = kWidthFlot(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cityCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _cityCollectView.showsVerticalScrollIndicator = NO;
        _cityCollectView.backgroundColor = [UIColor clearColor];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
        _cityCollectView.scrollEnabled = NO;
        [_cityCollectView registerClass:[zCityCollectionCell class] forCellWithReuseIdentifier:@"zCityCollectionCell"];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
    }
    return _cityCollectView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.BaseView];
        [self.BaseView addSubview:self.cityCollectView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    CGFloat left = kWidthFlot(30);
    CGFloat top = kWidthFlot(10);
    CGFloat right = kWidthFlot(40);
    [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-right);
        make.height.mas_equalTo(kWidthFlot(1)).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(top));
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zCityCollectionCell" forIndexPath:indexPath];
    cell.backColor = [UIColor colorWithHexString:@"#EFEFEF"];
    NSString * city = [NSString stringWithFormat:@"类型-%ld",(long)indexPath.item];
    cell.souceString = city;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * city = [NSString stringWithFormat:@"类型-%ld",(long)indexPath.item];
    return [self stringSize:city];
}

- (CGSize)stringSize:(NSString *)string {
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:17];
    CGFloat yOffset = 3.0f;
    CGFloat width = self.bounds.size.width - 20;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}

-(void)setTypesArray:(NSArray *)typesArray
{
    [self.cityCollectView reloadData];
    [self.cityCollectView layoutIfNeeded];
    CGFloat height = self.cityCollectView.collectionViewLayout.collectionViewContentSize.height;

    [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height).priorityHigh();
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
    }else{
        
    }
}

@end
