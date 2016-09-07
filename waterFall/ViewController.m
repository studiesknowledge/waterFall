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

@interface ViewController ()

///  模型数组
@property (nonatomic,strong) NSMutableArray *shops;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置collectionView的背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark -  数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.shops.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *ID = @"shop";
    
    ZDShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shop" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 256.0 green:arc4random_uniform(255) / 256.0 blue:arc4random_uniform(255) / 256.0 alpha:1.0];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
    
}

#pragma mark - 懒加载
- (NSMutableArray *)shops {

    if (_shops == nil) {
        
        // 加载数据
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil]];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            
            ZDShop *shop = [ZDShop shopWithDict:dict];
            [arrM addObject:shop];
        }
        
        _shops = arrM;
    }
    return _shops;
}

@end
