//
//  PersonViewController.m
//  TabbarController
//
//  Created by hodor on 2020/4/2.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "PersonViewController.h"
#import "SDAutoLayout.h"
#import "Masonry.h"
@interface PersonViewController ()
@property(nonatomic,strong)UIView           *mainView;
@property(nonatomic,strong)UIButton         *focusBtn; //关注按钮
@property(nonatomic,strong)UILabel         *cancleFocus;   //取消关注按钮
@property(nonatomic,strong)UIButton         *chatButton;    //聊天按钮
@property(nonatomic,assign)BOOL             isFollowed;
@end

@implementation PersonViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainView removeFromSuperview];
    [self.focusBtn removeFromSuperview];
    [self.cancleFocus removeFromSuperview];
    [self.chatButton removeFromSuperview];
    
    self.mainView = [UIView new];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.frame = CGRectMake(0, 100, self.view.frame.size.width, 500);
    [self.view addSubview:self.mainView];
    //关注按钮
    self.focusBtn = [[UIButton alloc] init];
    [self.focusBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.focusBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    
    [self.focusBtn setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateNormal];
    [self.focusBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
    
    self.focusBtn.layer.cornerRadius = 15;
    self.focusBtn.layer.masksToBounds = YES;
    self.focusBtn.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.5];
    
//    self.focusBtn.clipsToBounds = YES;
    
    [self.mainView addSubview:self.focusBtn];
    self.focusBtn.sd_layout
    .topSpaceToView(self.mainView, 200)
    .leftSpaceToView(self.mainView, 100)
    .widthIs(130).heightIs(30);
//    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(100);
//        make.top.mas_equalTo(self.view).mas_offset(200);
//        make.width.mas_equalTo(130);
//        make.height.mas_equalTo(30);
//    }];
    
    //取消关注
    self.cancleFocus = [UILabel new];
    self.cancleFocus.layer.cornerRadius = 15;
    self.cancleFocus.layer.masksToBounds = YES;
    self.cancleFocus.layer.borderColor = [UIColor grayColor].CGColor;
    [self.cancleFocus setTextColor:[UIColor blackColor]];
    self.cancleFocus.layer.borderWidth = 0.5;
    self.cancleFocus.text = @"取消关注";
    self.cancleFocus.textAlignment = NSTextAlignmentCenter;
    self.cancleFocus.font = [UIFont boldSystemFontOfSize:12.0];
    [self.mainView addSubview:self.cancleFocus];
    self.cancleFocus.sd_layout
    .topSpaceToView(self.mainView, 200)
    .leftSpaceToView(self.mainView, 100)
    .widthIs(90).heightIs(30);
    
//    [self.cancleFocus mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(100);
//        make.top.mas_equalTo(self.view).mas_offset(200);
//        make.width.mas_offset(90);
//        make.height.mas_offset(30);
//    }];
    
    //私聊
    self.chatButton = [[UIButton alloc]init];
    self.chatButton.layer.cornerRadius = 15;
    self.chatButton.layer.masksToBounds = YES;
    self.chatButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.chatButton.layer.borderWidth = 0.5;
    [self.chatButton setImage:[UIImage imageNamed:@"icon_private_chat"] forState:UIControlStateNormal];
    [self.mainView addSubview:self.chatButton];
    self.chatButton.sd_layout
    .centerYEqualToView(self.cancleFocus)
    .leftSpaceToView(self.cancleFocus, 5)
    .widthIs(35).heightIs(30);
//
//    [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.cancleFocus).mas_offset(5);
//        make.centerY.mas_equalTo(self.cancleFocus);
//        make.width.mas_offset(35);
//        make.height.mas_offset(30);
//    }];
    
    
    self.focusBtn.hidden = NO;
    self.cancleFocus.hidden = YES;
    self.chatButton.hidden = YES;
    
//    self.cancleFocus.alpha = 0;
//    self.chatButton.alpha = 0;
    self.cancleFocus.sd_layout
    .widthIs(130);
    self.chatButton.sd_layout
    .leftSpaceToView(self.cancleFocus, 5)
    .widthIs(35);
    
    
    [self.focusBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fovusAction:)]];
    self.cancleFocus.userInteractionEnabled = YES;
    [self.cancleFocus addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(canclefovusAction:)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)fovusAction:(UITapGestureRecognizer*)tap{
    self.isFollowed = YES;
    [self showFocusAnimation];
//    [self showUnFollowedAnimation];
//    [self showchatBtnAnimation];
}

-(void)canclefovusAction:(UITapGestureRecognizer*)tap{
    self.isFollowed = NO;
    [self showFocusAnimation];
//    [self showUnFollowedAnimation];
//    [self showchatBtnAnimation];
}
//关注按钮的现实逻辑
-(void)showFocusAnimation{
    
//    [UIView animateWithDuration:0.05 animations:^{
//        if (_isFollowed) {
//            self.focusBtn.alpha = 0;
//        }else{
//            self.focusBtn.alpha = 1;
//        }
//    } completion:^(BOOL finished) {
//        if (_isFollowed) {
//            self.focusBtn.hidden = YES;
//        }else{
//            self.focusBtn.hidden = NO;
//        }
//    }];
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = 4;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    CALayer *layer = self.focusBtn.layer;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0 , self.focusBtn.layer.frame.size.width, self.focusBtn.layer.frame.size.height )] CGPath];
    layer.mask = maskLayer;
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    if (_isFollowed){
        NSLog(@"%@",NSStringFromCGRect(layer.frame));
        positionAnimation.fromValue = @(layer.frame.origin.x + layer.frame.size.width*0.5);
        positionAnimation.toValue = @(layer.frame.origin.x + (90/2));
    
    }else {
        
        NSLog(@"%@",NSStringFromCGRect(layer.frame));
//        positionAnimation.fromValue = @(layer.frame.origin.x + layer.frame.size.width*0.5);
//        positionAnimation.toValue = @(layer.frame.origin.x+(20));
        positionAnimation.fromValue = @(0);
        positionAnimation.toValue = @(0);
    }

    CABasicAnimation *sizeAnimation = [CABasicAnimation animation];
    sizeAnimation.keyPath = @"bounds.size.width";
    if (_isFollowed){
        sizeAnimation.fromValue = @(layer.frame.size.width);
        sizeAnimation.toValue = @(90);
    }else {
        sizeAnimation.fromValue = @(layer.frame.size.width);
        sizeAnimation.toValue = @(130);
    }

    [animationGroup setAnimations:@[sizeAnimation]];
    [layer addAnimation:animationGroup forKey:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (self.isFollowed) {
//            self.focusBtn.sd_layout
//            .widthIs(90);
//        }else{
//            self.focusBtn.sd_layout
//            .widthIs(130);
//        }
    });
    [UIView animateWithDuration:4 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)showUnFollowedAnimation{
    if (_isFollowed) {
        self.cancleFocus.hidden = NO;
    }else{
        self.cancleFocus.hidden = YES;
    }
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = 0.25;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    CALayer *layer = self.cancleFocus.layer;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0 , self.cancleFocus.frame.size.width, self.cancleFocus.frame.size.height )] CGPath];
    layer.mask = maskLayer;
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    if (_isFollowed){
        positionAnimation.fromValue = @(layer.frame.origin.x + layer.frame.size.width*0.5);
        positionAnimation.toValue = @(layer.frame.origin.x+ layer.frame.size.width*0.5 - 20);
    }else {
        
    }
    
    NSLog(@"%f",layer.frame.origin.x);

    CABasicAnimation *sizeAnimation = [CABasicAnimation animation];
    sizeAnimation.keyPath = @"bounds.size.width";
    if (_isFollowed){
        sizeAnimation.fromValue = @(layer.frame.size.width);
        sizeAnimation.toValue = @(90);
    }else {
        sizeAnimation.fromValue = @(layer.frame.size.width);
        sizeAnimation.toValue = @(90);
    }

    [animationGroup setAnimations:@[positionAnimation,sizeAnimation]];
    [layer addAnimation:animationGroup forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
    [UIView animateWithDuration:0.25 animations:^{
        if (_isFollowed) {
            self.cancleFocus.textAlignment = NSTextAlignmentCenter;
            self.cancleFocus.sd_layout
            .widthIs(90);
        }
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showchatBtnAnimation{
    if (_isFollowed) {
        self.chatButton.hidden = NO;
    }else{
        self.chatButton.hidden = YES;
    }
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = 0.25;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    CALayer *layer = self.chatButton.layer;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0 , self.chatButton.frame.size.width, self.chatButton.frame.size.height )] CGPath];
    layer.mask = maskLayer;
    NSLog(@"%@",NSStringFromCGRect(self.chatButton.frame));
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    if (_isFollowed){
        positionAnimation.fromValue = @(layer.frame.origin.x + layer.frame.size.width*0.5);
        positionAnimation.toValue = @(layer.frame.origin.x+ layer.frame.size.width*0.5 - 35);
    }else {
        positionAnimation.fromValue = @(layer.frame.origin.x + layer.frame.size.width*0.5);
    positionAnimation.toValue = @(layer.frame.origin.x+ layer.frame.size.width*0.5 - 35);
    }
    
    NSLog(@"%f",layer.frame.origin.x);

    CABasicAnimation *sizeAnimation = [CABasicAnimation animation];
    sizeAnimation.keyPath = @"bounds.size.width";
    if (_isFollowed){
        sizeAnimation.fromValue = @(0);
        sizeAnimation.toValue = @(35);
    }else {
        sizeAnimation.fromValue = @(0);
        sizeAnimation.toValue = @(35);
    }

    [animationGroup setAnimations:@[positionAnimation,sizeAnimation]];
    [layer addAnimation:animationGroup forKey:nil];
    
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        if (self->_isFollowed) {
            self.chatButton.sd_layout
            .leftSpaceToView(self.cancleFocus, 5)
            .widthIs(35).heightIs(30);
        }
        
    }];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}
@end
