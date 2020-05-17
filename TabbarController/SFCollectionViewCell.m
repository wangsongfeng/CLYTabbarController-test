//
//  SFCollectionViewCell.m
//  TabbarController
//
//  Created by hodor on 2020/5/16.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "SFCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface SFCollectionViewCell()

@property(nonatomic,strong)UIImageView     *bgImageView;

@end

@implementation SFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bgImageView];
        self.bgImageView.frame = self.bounds;
    }
    return self;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}


- (void)setImage_url:(NSString *)image_url{
    _image_url = image_url;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]]];
}
@end
