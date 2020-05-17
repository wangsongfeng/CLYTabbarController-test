//
//  AppDelegate.m
//  TabbarController
//
//  Created by hodor on 2020/3/21.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AppDelegate+SFMainTabbar.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self hql_configureForTabBarController];
    
    return YES;
}





@end
