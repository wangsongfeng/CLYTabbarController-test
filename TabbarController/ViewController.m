//
//  ViewController.m
//  TabbarController
//
//  Created by hodor on 2020/3/21.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "WAVideoBox.h"
@interface ViewController ()
@property (nonatomic , strong) WAVideoBox *videoBox;
@property (nonatomic , copy) NSString *videoPath;

@property (nonatomic , copy) NSString *testOnePath;

@property (nonatomic , copy) NSString *testTwoPath;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _videoBox = [WAVideoBox new];
     _videoPath = [[NSBundle mainBundle] pathForResource:@"d681aec3da99e987f1bd147ed885d85d.MOV" ofType:nil];
     _testOnePath = [[NSBundle mainBundle] pathForResource:@"fc40304512ad57c83f1c6a7285c29747.MOV" ofType:nil];
     _testTwoPath = [[NSBundle mainBundle] pathForResource:@"output 4.MP4" ofType:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [_videoBox appendVideoByPath:_videoPath];
    _videoBox.ratio = WAVideoExportRatio960x540;
    _videoBox.videoQuality = 1; // 有两种方法可以压缩
    [_videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            NSLog(@"压缩成功%@",filePath);
        }
        wself.videoBox.ratio = WAVideoExportRatio960x540;
        wself.videoBox.videoQuality = 0;
    }];
}

- (NSString *)buildFilePath{
    
    return [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%f.mp4", [[NSDate date] timeIntervalSinceReferenceDate]]];
}
@end
