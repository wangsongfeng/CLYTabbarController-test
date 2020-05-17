//
//  CYLPlusButtonSubclass.m
//  TabbarController
//
//  Created by hodor on 2020/4/4.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "CYLPlusButtonSubclass.h"
#import "UIImage+GIF.h"
@implementation CYLPlusButtonSubclass

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
-(void)clickPublish{
    NSLog(@"sender");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"push" object:nil];
}
+ (id)plusButton{
    CYLPlusButtonSubclass *button = [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"8s" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage * image = [UIImage sd_animatedGIFWithData:data];
    [button setImage:image forState:UIControlStateNormal];
        //自定义宽度
    button.frame = CGRectMake(0.0, 0.0, UIScreen.mainScreen.bounds.size.width/5.0, 49);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // button.backgroundColor = [UIColor redColor];
        
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
     [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// 用来自定义加号按钮的位置，如果不实现默认居中。
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

// constantOfPlusButtonCenterYOffset 大于 0 会向下偏移，小于 0 会向上偏移。
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? -3-24 : -6);
}

- (void)plusChildViewControllerButtonClicked:(UIButton<CYLPlusButtonSubclassing> *)sender{
    NSLog(@"sender");
}

@end
