//
//  UITabBar+Badge.m
//  TabbarController
//
//  Created by hodor on 2020/4/11.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "UITabBar+Badge.h"
#define TabbarItemNums 5.0

@implementation UITabBar (Badge)
//显示红点
- (void)showBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIImageView *bview = [[UIImageView alloc]init];
    bview.image = [self imageWithColor:[UIColor redColor] size:CGSizeMake(8, 8)];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 4;
    bview.clipsToBounds = YES;
    CGRect tabFram = self.frame;
    
    CGFloat width = 22;
    CGFloat TabbarW = tabFram.size.width/5;
    CGFloat margin = (TabbarW-width)/2;
    CGFloat left = TabbarW*4 + margin + width + 2;
    
    float percentX = (index+0.7)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(left, 4, 8, 8);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}
//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}
//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end
