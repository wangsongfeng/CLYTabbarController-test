//
//  CommunityController.m
//  TabbarController
//
//  Created by hodor on 2020/4/2.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "CommunityController.h"
#import "SFCollectionViewCell.h"
#import "SFCollectionView.h"
@interface CommunityController ()<SFCollectionViewDelegate,SFCollectionViewDataSource>
@property(nonatomic,strong)SFCollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray   *listArrays;
@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 3;
    flow.minimumInteritemSpacing = 3;
    CGFloat itemW = (self.view.frame.size.width - 30 - 3*2)/3.0;
    flow.itemSize = CGSizeMake(itemW, itemW);
    self.collectionView = [[SFCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(15, 100, self.view.frame.size.width-30, self.view.frame.size.height);
    [self.collectionView registerClass:[SFCollectionViewCell class] forCellWithReuseIdentifier:@"SFCollectionViewCell"];
    self.listArrays = [NSMutableArray array];
    NSArray * listArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826620&di=7ebe0244c569e62817013ffcc07191f7&imgtype=0&src=http%3A%2F%2Fdl.ppt123.net%2Fpptbj%2F51%2F20181115%2Fmzj0ghw2xo2.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=7f4140aba57d55683b65c902a66b725f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F43%2F74%2F01300000164151121808741085971.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=7dace37601ea86222dc4c7897162b211&imgtype=0&src=http%3A%2F%2Fpic27.nipic.com%2F20130312%2F12058334_175946381000_2.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=d307abba02edd59862c36deed7f48689&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F22%2F43%2F01300533991704134665435963373.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=a75164e86aea65633596c529d34bd890&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F35%2F34%2F19300001295750130986345801104.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=bf89d4d1f83308987659d0ab37c94afa&imgtype=0&src=http%3A%2F%2Fpics7.baidu.com%2Ffeed%2Fb17eca8065380cd7f25c782101ddda325b8281d8.jpeg%3Ftoken%3D227a7fa92b6fcd9417063f8e29d063ae",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826616&di=59aa11b9151d0c1aeca6850de34a4b8d&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F01%2F94%2F20300000926291132247944405335.jpg"];
    
//    ,
//    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652826613&di=782071c0439a6141c27a80defa220a42&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F60%2F18%2F16300000044935127918188299206.jpg",
//    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589652994515&di=a55bcc5b801643e9724db277d2991a4f&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fb03533fa828ba61e9e3a85984234970a314e59b4.jpg"
    [self.listArrays addObjectsFromArray:listArray];
    [self.collectionView reloadData];
}

- (void)dragCellCollectionView:(SFCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    NSLog(@"%@",newDataArray);
}

- (NSArray *)dataSourceArrayOfCollectionView:(SFCollectionView *)collectionView{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArrays.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SFCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFCollectionViewCell" forIndexPath:indexPath];
    cell.image_url = [self.listArrays objectAtIndex:indexPath.item];
    return cell;
}

@end
