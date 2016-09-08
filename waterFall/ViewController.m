//
//  ViewController.m
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import "ViewController.h"
#import "ZDShop.h"
#import "ZDShopCell.h"
#import "ZDFooterView.h"
#import "ZDWaterFallFallLayout.h"

@interface ViewController ()

///  模型数组
@property (nonatomic,strong) NSMutableArray *shops;
///  尾部视图
@property (weak,nonatomic) ZDFooterView *footerView;
///  index用来记录当前加载了几次
@property (assign,nonatomic) NSInteger index;


@property (weak, nonatomic) IBOutlet ZDWaterFallFallLayout *flowLayout;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flowLayout.columnCount = 3;
    
    // 设置collectionView的背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.index = 0;
    
    [self loadData];
    
}

#pragma mark - 加载数据
- (void)loadData {

    NSArray *modelArr = [ZDShop shopWithIndex:self.index];
    [self.shops addObjectsFromArray:modelArr];

    self.index ++;
    
    self.flowLayout.dataList = self.shops;
}


#pragma mark -  数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.shops.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *ID = @"shop";
    
    ZDShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 256.0 green:arc4random_uniform(255) / 256.0 blue:arc4random_uniform(255) / 256.0 alpha:1.0];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
    
}


#pragma mark - 返回每一组的头部视图或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    ZDFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    self.footerView = footerView;
    
    return footerView;

}


#pragma mark - 滚动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 如果footerView还没有出现，或者说正在加载数据，什么也不做直接返回
    if (self.footerView == nil || self.footerView.activityVIew.isAnimating == YES) {
        return ;
    }

    
    // footerView完全出现之后才去加载更多
    if (self.collectionView.contentOffset.y + self.collectionView.bounds.size.width > CGRectGetMaxY(self.footerView.bounds)) {
        
        // 菊花开始转动
        [self.footerView.activityVIew startAnimating];
        
        // 这是加载的本地数据，所以会很快显示
        // 模拟网络状况
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 1. 加载数据
            [self loadData];
            // 2. 刷新表格
            [self.collectionView reloadData];
            // 3. 菊花停止转动
            [self.footerView.activityVIew stopAnimating];
            // 4. 将footerView设置为nil
            self.footerView = nil;
            
        });
    }

}



#pragma mark - 懒加载
- (NSMutableArray *)shops {

    if (_shops == nil) {

        _shops = [NSMutableArray array];
    }
    return _shops;
}

@end
