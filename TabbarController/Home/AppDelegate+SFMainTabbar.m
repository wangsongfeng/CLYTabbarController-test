//
//  AppDelegate+SFMainTabbar.m
//  TabbarController
//
//  Created by hodor on 2020/4/2.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "AppDelegate+SFMainTabbar.h"
#import "UIColor+Hex.h"
#import "HomeViewController.h"
#import "CommunityController.h"
#import "ServerViewController.h"
#import "PersonViewController.h"
#import "CYLPlusButtonSubclass.h"
#import "MainViewController.h"
#import "UITabBar+Badge.h"
@implementation AppDelegate (SFMainTabbar)
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"push" object:nil];
}
/// 配置主窗口
- (void)hql_configureForTabBarController{
    // 设置主窗口，并设置根视图控制器
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [CYLPlusButtonSubclass registerPlusButton];
    // 初始化 CYLTabBarController 对象
    CYLTabBarController *tabBarController =
        [CYLTabBarController tabBarControllerWithViewControllers:[self viewControllers]
                                           tabBarItemsAttributes:[self tabBarItemsAttributes]];
    // 设置遵守委托协议
    tabBarController.delegate = self;
    
    // 将 CYLTabBarController 设置为 window 的 RootViewController
    self.window.rootViewController = tabBarController;
    
    [self customizeTabBarInterface];
    [self.cyl_tabBarController.tabBar showBadgeOnItemIndex:0];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push:) name:@"push" object:nil];
}
-(void)push:(NSNotificationCenter*)not{
    MainViewController * vc = [[MainViewController alloc]init];
    if(@available(iOS 13.0, *)) {
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    [self.cyl_tabBarController.selectedViewController presentViewController:vc animated:YES completion:nil];
}
#pragma mark - Private

/// 控制器数组
- (NSArray *)viewControllers {
    // 首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.navigationItem.title = @"首页";
    CYLBaseNavigationController *homeNC = [[CYLBaseNavigationController alloc] initWithRootViewController:homeVC];
    [homeNC cyl_setHideNavigationBarSeparator:YES];
    
    // 同城
    CommunityController *myCityVC = [[CommunityController alloc] init];
    myCityVC.navigationItem.title = @"小镇";
    CYLBaseNavigationController *myCityNC = [[CYLBaseNavigationController alloc] initWithRootViewController:myCityVC];
    [myCityNC cyl_setHideNavigationBarSeparator:YES];
    
    // 消息
    ServerViewController *messageVC = [[ServerViewController alloc] init];
    messageVC.navigationItem.title = @"服务";
    CYLBaseNavigationController *messageNC = [[CYLBaseNavigationController alloc] initWithRootViewController:messageVC];
    [messageNC cyl_setHideNavigationBarSeparator:YES];
    
    // 我的
    PersonViewController *accountVC = [[PersonViewController alloc] init];
    accountVC.navigationItem.title = @"我的";
    accountVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    CYLBaseNavigationController *accountNC = [[CYLBaseNavigationController alloc] initWithRootViewController:accountVC];
    [accountNC cyl_setHideNavigationBarSeparator:YES];
    
    NSArray *viewControllersArray = @[homeNC, myCityNC, messageNC, accountNC];
    return viewControllersArray;
}

/// tabBar 属性数组
- (NSArray *)tabBarItemsAttributes {
    NSDictionary *homeTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"首页",
        CYLTabBarItemImage: @"tabbar_home_n",
        CYLTabBarItemSelectedImage: @"tabbar_home_s",
        CYLTabBarItemTitlePositionAdjustment:[NSValue valueWithCGPoint:CGPointMake(0, -3)],
    };
    NSDictionary *myCityTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"小镇",
        CYLTabBarItemImage: @"tabbar_community_n",
        CYLTabBarItemSelectedImage: @"tabbar_community_s",
        CYLTabBarItemTitlePositionAdjustment:[NSValue valueWithCGPoint:CGPointMake(0, -3)],
    };
    NSDictionary *messageTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"服务",
        CYLTabBarItemImage: @"tabbar_service_n",
        CYLTabBarItemSelectedImage: @"tabbar_service_s",
        CYLTabBarItemTitlePositionAdjustment:[NSValue valueWithCGPoint:CGPointMake(0, -3)],
    };
    NSDictionary *accountTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"我的",
        CYLTabBarItemImage: @"tabbar_mine_n",
        CYLTabBarItemSelectedImage: @"tabbar_mine_s",
        CYLTabBarItemTitlePositionAdjustment:[NSValue valueWithCGPoint:CGPointMake(0, -3)],
    };

    NSArray *tabBarItemsAttributes = @[
        homeTabBarItemsAttributes,
        myCityTabBarItemsAttributes,
        messageTabBarItemsAttributes,
        accountTabBarItemsAttributes
    ];
    return tabBarItemsAttributes;
}

/// 自定义 TabBar 字体、背景、阴影
- (void)customizeTabBarInterface {
    // 设置文字属性
    if (@available(iOS 10.0, *)) {
        [self cyl_tabBarController].tabBar.unselectedItemTintColor = [UIColor cyl_systemGrayColor];
        [self cyl_tabBarController].tabBar.tintColor = [UIColor mainColor];
    } else {
        UITabBarItem *tabBar = [UITabBarItem appearance];
        // 普通状态下的文字属性
        [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor cyl_systemGrayColor]}
                              forState:UIControlStateNormal];
        // 选中状态下的文字属性
        [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor mainColor]}
                              forState:UIControlStateSelected];
    }

    // 设置 TabBar 背景颜色：白色
    // 💡[UIImage imageWithColor] 表示根据指定颜色生成图片，该方法来自 <YYKit> 框架
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    // 去除 TabBar 自带的顶部阴影
    [[self cyl_tabBarController] hideTabBarShadowImageView];
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
