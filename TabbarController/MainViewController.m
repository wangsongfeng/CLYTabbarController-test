//
//  MainViewController.m
//  TabbarController
//
//  Created by hodor on 2020/3/22.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "MainViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface MainViewController ()
@property (nonatomic, strong,) IJKFFMoviePlayerController *player;

@property (nonatomic, strong,) IJKFFOptions *options;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.player = [[IJKFFMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://api.area50.cn:8080//upload/user/913/dynamic/video/2020-01-09/b0994a2bd10f49eeb99a6173e7a3626a.mp4"] withOptions:self.options];
//    self.player.shouldAutoplay = YES;
//    [self.player prepareToPlay];
//    [self.view addSubview:self.player.view];
//    self.player.view.frame = self.view.bounds;
//    self.player.view.backgroundColor = [UIColor clearColor];
//    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
//    [self.player play];
}

- (IJKFFOptions *)options {
    if (!_options) {
        _options = [IJKFFOptions optionsByDefault];
        /// 精准seek
        [_options setPlayerOptionIntValue:1 forKey:@"enable-accurate-seek"];
        /// 解决http播放不了
        [_options setOptionIntValue:1 forKey:@"dns_cache_clear" ofCategory:kIJKFFOptionCategoryFormat];
        /// Set param
        [_options setFormatOptionIntValue:1024 * 16 forKey:@"probsize"];
        [_options setFormatOptionIntValue:50000 forKey:@"analyzeduration"];
        [_options setPlayerOptionIntValue:0 forKey:@"videotoolbox"];
        [_options setCodecOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_loop_filter"];
        [_options setCodecOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_frame"];
       
        /// Param for playback
        [_options setPlayerOptionIntValue:0 forKey:@"max_cached_duration"];
        [_options setPlayerOptionIntValue:0 forKey:@"infbuf"];
        [_options setPlayerOptionIntValue:1 forKey:@"packet-buffering"];
        
    }
    return _options;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    return CGSizeMake(self.view.frame.size.width, 300);
}
@end
