//
//  UIColor+Hex.h
//  TabbarController
//
//  Created by hodor on 2020/4/2.
//  Copyright © 2020 王松锋. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *)colorWithSETPRICE:(NSString *)SETPRICE price:(NSString*)PRICE;
+ (UIColor *)colorWithRAISELOSE:(NSString *)RAISELOSE;

- (UIImage*)GetImageWithHeight:(CGSize)size;
+(UIColor*)borderColor;
//EEEEEE color
+(UIColor*)lightColor;
//程序主题颜色
+(UIColor*)mainColor;
//333333
+(UIColor*)blackThree;
//666666
+(UIColor*)blackSix;
//999999
+(UIColor*)blackEight;

+(UIColor*)greenMainColor;

+(UIColor*)MaingraysColor;
@end

NS_ASSUME_NONNULL_END
