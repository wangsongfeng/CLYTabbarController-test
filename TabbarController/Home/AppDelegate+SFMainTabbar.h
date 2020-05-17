//
//  AppDelegate+SFMainTabbar.h
//  TabbarController
//
//  Created by hodor on 2020/4/2.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "CYLTabBarController.h"

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (SFMainTabbar)<UITabBarControllerDelegate>
/// 配置主窗口
- (void)hql_configureForTabBarController;
@end

NS_ASSUME_NONNULL_END
