//
//  ZDShop.h
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDShop : NSObject

///  图片真实的高度
@property (assign,nonatomic) CGFloat height;

///  图片
@property (nonatomic,copy) NSString *icon;

///  价格
@property (nonatomic,copy) NSString *price;

///  图片真实的宽度
@property (assign,nonatomic) CGFloat width;

///  字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)shopWithDict:(NSDictionary *)dict;

///  加载数九
+ (NSArray *)shopWithIndex:(NSInteger)index;
@end
