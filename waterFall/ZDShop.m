//
//  ZDShop.m
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import "ZDShop.h"

@implementation ZDShop

- (instancetype)initWithDict:(NSDictionary *)dict {

    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
    }

    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)shopWithIndex:(NSInteger)index {

    NSString *filePath = [NSString stringWithFormat:@"%zd.plist", (index % 3 + 1)];
    ///  读取文件
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filePath ofType:nil]];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        
        ZDShop *shop = [ZDShop shopWithDict:dict];
        [arrM addObject:shop];
    }
    
    return arrM;
}

@end
