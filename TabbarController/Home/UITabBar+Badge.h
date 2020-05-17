//
//  UITabBar+Badge.h
//  TabbarController
//
//  Created by hodor on 2020/4/11.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
