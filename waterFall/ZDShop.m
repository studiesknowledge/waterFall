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


@end
