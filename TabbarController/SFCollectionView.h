//
//  SFCollectionView.h
//  TabbarController
//
//  Created by hodor on 2020/5/16.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SFCollectionView;

@protocol SFCollectionViewDelegate <UICollectionViewDelegate>

/**
 * 返回新的数据源
 */
-(void)dragCellCollectionView:(SFCollectionView*)collectionView newDataArrayAfterMove:(NSArray*)newDataArray;

@end

@protocol SFCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 * 返回整个CollectionView的数据，用于重排
 */
-(NSArray*)dataSourceArrayOfCollectionView:(SFCollectionView*)collectionView;

@end

@interface SFCollectionView : UICollectionView

@property (weak, nonatomic) id<SFCollectionViewDelegate> delegate;
@property (weak, nonatomic) id<SFCollectionViewDataSource> dataSource;

@property(nonatomic,assign)BOOL editEnabled;

@end

NS_ASSUME_NONNULL_END
