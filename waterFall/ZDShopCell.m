//
//  ZDShopCell.m
//  waterFall
//
//  Created by 赵东亮 on 16/9/7.
//  Copyright © 2016年 赵东亮. All rights reserved.
//

#import "ZDShopCell.h"
#import "ZDShop.h"

@interface ZDShopCell ()
// 价格标签
@property (weak, nonatomic) IBOutlet UILabel *priceV;

// 图片
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end


@implementation ZDShopCell


- (void)setShop:(ZDShop *)shop {

    _shop = shop;
    self.imageV.image = [UIImage imageNamed:shop.icon];
    self.priceV.text = shop.price;

}

@end
