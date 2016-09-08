//
//  ZDWaterFallFallLayout.m
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import "ZDWaterFallFallLayout.h"
//#import "ZDShop.h"

@interface ZDWaterFallFallLayout ()

// 存放collectionView中所有子视图的布局属性
@property (nonatomic,strong) NSMutableArray *attrM;

// 用来累加每一列的当前cell的高度
@property (nonatomic, strong) NSMutableArray *eachColMaxH;
@end

@implementation ZDWaterFallFallLayout


#pragma mark - 准备布局
///  collectionView即将显示的时候调用，刷新表格的时候也会调用，做布局前的准备工作
- (void)prepareLayout {

    // 每一次来计算新的cell布局属性之前先把最后一个footerView的布局属性删除
    [self.attrM removeLastObject];
    
    // 获取当前collectionView中的cell的总个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];

    NSInteger newcellCount = itemCount - self.attrM.count;
    
    for (NSInteger i = 0; i < newcellCount; i++) {

        // 创建布局属性对象索引
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.attrM.count inSection:0];
        // 创建布局属性
        UICollectionViewLayoutAttributes *cellAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        
        // 计算cell的宽度
        CGFloat contentW = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
        CGFloat cellWidth = (contentW - (self.columnCount - 1) * self.minimumInteritemSpacing) / self.columnCount;
        
        // cell的高度
        CGFloat cellH = [self.delegate waterfallFlowLayout:self cellW:cellWidth forIndexPath:indexPath];
        
        
        // 计算列号
        NSInteger col = [self minCol];
        // x
        CGFloat cellX = self.sectionInset.left + (cellWidth + self.minimumInteritemSpacing) * col;
        // y
        CGFloat cellY = [self.eachColMaxH[col] floatValue];
        self.eachColMaxH[col] = @(cellY + cellH + self.minimumInteritemSpacing);
        
        cellAttr.frame = CGRectMake(cellX, cellY, cellWidth, cellH);
        [self.attrM addObject:cellAttr];
    }
    
    // footerView的属性
    NSIndexPath *indexPathFooter = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPathFooter];
    footerAttr.frame = CGRectMake(0, [self.eachColMaxH[self.maxCol] floatValue] - self.minimumLineSpacing, self.collectionView.bounds.size.width, self.footerReferenceSize.height);
    [self.attrM addObject:footerAttr];
}

#pragma mark - 最高的列
- (NSInteger)maxCol {
    
    CGFloat maxH = 0;
    NSInteger maxC = 0;
    
    for (NSInteger i = 0; i < self.eachColMaxH.count; i++) {
        
        if ([self.eachColMaxH[i] floatValue] > maxH) {
            
            maxH = [self.eachColMaxH[i] floatValue];
            maxC = i;
        }
    }
    return maxC;
}


#pragma mark - 最矮的列
- (NSInteger)minCol {

    CGFloat minH = MAXFLOAT;
    NSInteger minC = 0;
    
    for (NSInteger i = 0; i < self.eachColMaxH.count; i ++) {
        
        if ([self.eachColMaxH[i] floatValue] < minH) {
            
            minH = [self.eachColMaxH[i] floatValue];
            minC = i;
        }
    }
    return minC;

}


- (CGSize)collectionViewContentSize {

    return CGSizeMake(0, [self.eachColMaxH[self.maxCol] floatValue] + self.footerReferenceSize.height - self.minimumInteritemSpacing);
}



// 通过输入此方法返回的是collectionView中所有子视图的索引的frame,而且每一个子视图的frame只会计算一次,
// 通过测试我们可以自己修改布局对象中的frame,来改变cell的大小和位置,我们可以自己来计算每一个子视图的frame计算好之后并保存到数组中,最终通过此方法来返回,应该可以实现瀑布流效果
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attrM;

}

- (NSMutableArray *)attrM {

    if (_attrM == nil) {
        
        _attrM = [NSMutableArray array];
    }
    return _attrM;
}

- (NSMutableArray *)eachColMaxH {

    if (_eachColMaxH == nil) {
        
        _eachColMaxH = [NSMutableArray arrayWithCapacity:self.columnCount];
        
        for (NSInteger i = 0; i < self.columnCount; i ++) {
            
            _eachColMaxH[i] = @(self.sectionInset.top);
        }
    }
    return _eachColMaxH;
}
@end
