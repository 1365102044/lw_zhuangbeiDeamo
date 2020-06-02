//
//  handWritingListLayout.m
//  guoziyunparent
//
//  Created by aa on 2019/8/21.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "handWritingListLayout.h"

@interface handWritingListLayout ()

@property (nonatomic, assign) CGSize contentSize;

@end


@implementation handWritingListLayout

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    NSInteger maxNumberOfItems = 0;
    //获取布局信息
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++){
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *subArr = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger item = 0; item < numberOfItems; item++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [subArr addObject:attributes];
        }
        if(maxNumberOfItems < numberOfItems){
            maxNumberOfItems = numberOfItems;
        }
        //添加到二维数组
    }
    //存储布局信息
    
    //保存内容尺寸
    
//    int count = SCREEN_WIDTH == 320 ? 5 : 5;
    NSInteger linesItem =  maxNumberOfItems;
//    / count;
//    NSInteger yushu = maxNumberOfItems % count;
    
    CGSize exactItemSize = CGSizeMake(kWidthFlot(110), kWidthFlot(30));
    
//    if (yushu != 0) {
//        linesItem += 1;
//    }
    self.contentSize = CGSizeMake(kWidthFlot(110), linesItem * exactItemSize.height + (linesItem-1)*1 +5);
}


-(CGSize)collectionViewContentSize
{
    return self.contentSize;
}
@end
