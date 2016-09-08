//
//  ZDWaterFallFallLayout.h
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDWaterFallFallLayout : UICollectionViewFlowLayout

///  列数
@property (assign,nonatomic) NSInteger columnCount;

@property (nonatomic,strong) NSArray *dataList;

@end
