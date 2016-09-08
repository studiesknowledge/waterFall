//
//  ZDWaterFallFallLayout.h
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDWaterFallFallLayout;

@protocol ZDWaterFallFallLayoutDelegate <NSObject>

@required
- (CGFloat)waterfallFlowLayout:(ZDWaterFallFallLayout *)flowLayout cellW:(CGFloat)cellW forIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZDWaterFallFallLayout : UICollectionViewFlowLayout

@property (weak,nonatomic) id<ZDWaterFallFallLayoutDelegate> delegate;


///  列数
@property (assign,nonatomic) NSInteger columnCount;

@end
