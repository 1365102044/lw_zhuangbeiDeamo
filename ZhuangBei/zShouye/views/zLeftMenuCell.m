//
//  zLeftMenuCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLeftMenuCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "zLeftMenuThirdCell.h"
#import "handWritingListLayout.h"

@interface zLeftMenuCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIButton * arrowButton;

@property(strong,nonatomic)UICollectionView * cityCollectView;

@end

@implementation zLeftMenuCell

+(zLeftMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zLeftMenuCell";
    zLeftMenuCell * cell = [[zLeftMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        _arrowButton.userInteractionEnabled = NO;
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowDown"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowLeft"] forState:UIControlStateSelected];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }
    return _arrowButton;
}

-(UICollectionView*)cityCollectView
{
    if (!_cityCollectView) {
        handWritingListLayout * layout = [[handWritingListLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        layout.minimumLineSpacing = kWidthFlot(1);
        layout.minimumInteritemSpacing = kWidthFlot(1);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cityCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _cityCollectView.showsVerticalScrollIndicator = NO;
        _cityCollectView.backgroundColor = [UIColor clearColor];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
        _cityCollectView.scrollEnabled = NO;
        [_cityCollectView registerClass:[zLeftMenuThirdCell class] forCellWithReuseIdentifier:@"zLeftMenuThirdCell"];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
    }
    return _cityCollectView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.arrowButton];
        [self.contentView addSubview:self.cityCollectView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(30));
    }];
    
    [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.arrowButton.mas_bottom).offset(kWidthFlot(1));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(1)).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(1));
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.goodsModel.select) {
        return self.goodsModel.children.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zLeftMenuThirdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zLeftMenuThirdCell" forIndexPath:indexPath];
    
    zGoodsMenuModel * model =  self.goodsModel.children[indexPath.item];
    cell.goodsModel = model;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kWidthFlot(110), kWidthFlot(30));
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    zGoodsMenuModel * typeModel = self.goodsModel.children[indexPath.item];
//    CGSize total =  [self stringSize:typeModel.title];
//    return CGSizeMake(total.width, kWidthFlot(30));
//}


- (CGSize)stringSize:(NSString *)string {
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:17];
    CGFloat yOffset = 3.0f;
    CGFloat width = self.bounds.size.width - 20;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     zGoodsMenuModel * model =  self.goodsModel.children[indexPath.item];
    if (self.menuSelectBack) {
        self.menuSelectBack(model);
    }
}


-(void)setGoodsModel:(zGoodsMenuModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.arrowButton setTitle:goodsModel.title forState:UIControlStateNormal];
    self.arrowButton.selected = goodsModel.select;
    if (_goodsModel.children.count>0) {
        [self.cityCollectView reloadData];
        [self.cityCollectView layoutIfNeeded];
        CGFloat height = self.cityCollectView.collectionViewLayout.collectionViewContentSize.height;
        NSLog(@"height = %lf",height);
        [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priorityHigh();
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
