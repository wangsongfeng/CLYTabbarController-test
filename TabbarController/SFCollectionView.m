//
//  SFCollectionView.m
//  TabbarController
//
//  Created by hodor on 2020/5/16.
//  Copyright © 2020 王松锋. All rights reserved.
//

#import "SFCollectionView.h"
#import "SFCollectionViewCell.h"
@interface SFCollectionView()
@property(nonatomic,weak)UILongPressGestureRecognizer    *longPger;
@property(nonatomic,strong)NSIndexPath                   *originalIndexPath;  //最初刚开始移动的indexPath;
@property (strong, nonatomic) UIView *tempMoveCell;
@property (assign, nonatomic) CGPoint lastPoint;
@property (nonatomic, strong) UICollectionViewCell *dragCell;
@property (nonatomic, strong) NSIndexPath *moveIndexPath;
@property (nonatomic, assign) BOOL isDeleteItem;
@end

@implementation SFCollectionView

@dynamic dataSource;
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.layer.masksToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.editEnabled = YES;
        [self addGesture];
    }
    return self;
}
- (void)addGesture
{
    
    UILongPressGestureRecognizer *longPgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPrgEvent:)];
    longPgr.minimumPressDuration = 0.25f;
    longPgr.enabled = self.editEnabled;
    [self addGestureRecognizer:longPgr];
    self.longPger = longPgr;
}

#pragma mark - 修复iOS13 下滚动异常API
#ifdef __IPHONE_13_0
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated{
    [super scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];

    //修复13下 Cell滚动位置异常
   if (@available(iOS 13.0, *)) {
      //顶部
      if(self.contentOffset.y < 0){
          [self setContentOffset:CGPointZero];
          return;
      }
      //底部
      if(self.contentOffset.y > self.contentSize.height){
          [self setContentOffset:CGPointMake(0, self.contentSize.height)];
      }
  }
}
#endif

- (void)setEditEnabled:(BOOL)editEnabled{
    _editEnabled = editEnabled;
    self.longPger.enabled = editEnabled;
}

-(void)longPrgEvent:(UILongPressGestureRecognizer*)longPger{
    if (longPger.state == UIGestureRecognizerStateBegan) {
        self.isDeleteItem = NO;
        [self gestureRecognizerBegan:longPger];
    }else if (longPger.state == UIGestureRecognizerStateChanged){
        if (self.originalIndexPath.section != 0) {
            return;
        }
        [self gestureRecognizerChange:longPger];
        [self moveCell];
    }else if (longPger.state == UIGestureRecognizerStateCancelled || longPger.state == UIGestureRecognizerStateEnded){
        
        [self handelItemInSpace];
        if (!self.isDeleteItem) {
            [self gestureRecognizerCancelOrEnd:longPger];
        }
    }
}


- (void)gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr{
    self.originalIndexPath = [self indexPathForItemAtPoint:[longPgr locationOfTouch:0 inView:longPgr.view]];
    SFCollectionViewCell * cell = (SFCollectionViewCell*)[self cellForItemAtIndexPath:self.originalIndexPath];
    UIView * tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];  //获取一个截屏试图
    self.dragCell = cell;
    cell.hidden = YES;
    self.tempMoveCell = tempMoveCell;
    self.tempMoveCell.frame = cell.frame;
    [UIView animateWithDuration:0.25 animations:^{
        self.tempMoveCell.alpha = 0.8;
        self.tempMoveCell.transform = CGAffineTransformMakeScale(1.15, 1.15);
    }];
    [self addSubview:self.tempMoveCell];
    self.lastPoint = [longPgr locationOfTouch:0 inView:self];
    
}


- (void)gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr{
    CGFloat tranX = [longPgr locationOfTouch:0 inView:longPgr.view].x - self.lastPoint.x;
    CGFloat tranY = [longPgr locationOfTouch:0 inView:longPgr.view].y - self.lastPoint.y;
//    NSLog(@"start %@",NSStringFromCGPoint(self.tempMoveCell.center));
    self.tempMoveCell.center = CGPointApplyAffineTransform(self.tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
//    NSLog(@"end %@",NSStringFromCGPoint(self.tempMoveCell.center));
    self.lastPoint = [longPgr locationOfTouch:0 inView:longPgr.view];
//    NSLog(@"tranX:%f-tranY:%f--%@",tranX,tranY,NSStringFromCGPoint(self.lastPoint));

//    CGAffineTransformMakeTranslation(x,y) --相对平移 将view(泛指)移动到相对于“屏幕的左上角”
    
    //    CGAffineTransformMakeTranslation(x,y) 矩阵变换，位移
    //    CGAffineTransformMakeRotation(M_PI); 矩阵变换，旋转
    //    CGAffineTransformMakeScale(2, 2);    矩阵变换，缩放
    //    CGPointApplyAffineTransform(CGPoint point, CGAffineTransform t)  某点通过矩阵变换之后的点
}

- (void)gestureRecognizerCancelOrEnd:(UILongPressGestureRecognizer *)longPgr
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.tempMoveCell.center = self.dragCell.center;
        self.tempMoveCell.transform = CGAffineTransformIdentity;
        self.tempMoveCell.alpha = 1;
    } completion:^(BOOL finished) {
        [self.tempMoveCell removeFromSuperview];
        self.dragCell.hidden = NO;
        self.userInteractionEnabled = YES;
    }];
}

- (void)moveCell{
    for (SFCollectionViewCell * cell in self.visibleCells) {
        if ([self indexPathForCell:cell] == self.originalIndexPath) {
            continue;
        }
        //计算中心距离
        CGFloat spaceingX = fabs(self.tempMoveCell.center.x - cell.center.x);
        CGFloat spaceingY = fabs(self.tempMoveCell.center.y - cell.center.y);
        if (spaceingX <= self.tempMoveCell.bounds.size.width/2.0f && spaceingY <= self.tempMoveCell.bounds.size.height/2.0f) {
            self.moveIndexPath = [self indexPathForCell:cell];
            if (self.moveIndexPath.section != 0) {
                return;
            }
            //更新数据源
            [self updateDataSource];
            //移动
            [self moveItemAtIndexPath:self.originalIndexPath toIndexPath:self.moveIndexPath];
            
            self.originalIndexPath = self.moveIndexPath;
        }
    }
}


-(void)updateDataSource{
    NSMutableArray *temp = @[].mutableCopy;
    //获取数据源
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        [temp addObjectsFromArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    NSLog(@"%@",temp);
    //判断数据源是单个数组还是数组套数组的多section形式，YES表示数组套数组
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self numberOfSections] == 1 && [temp.firstObject isKindOfClass:[NSArray class]]));
    if (dataTypeCheck) {
        for (int i = 0; i < temp.count; i ++) {
            [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        }
    }
    if (_moveIndexPath.section == _originalIndexPath.section) {
        NSMutableArray *orignalSection = dataTypeCheck ? temp[_originalIndexPath.section] : temp;
        if (_moveIndexPath.item > _originalIndexPath.item) {
            for (NSUInteger i = _originalIndexPath.item; i < _moveIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }else{
            for (NSUInteger i = _originalIndexPath.item; i > _moveIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
        
    }else{
        NSMutableArray *orignalSection = temp[_originalIndexPath.section];
        NSMutableArray *currentSection = temp[_moveIndexPath.section];
        [currentSection insertObject:orignalSection[_originalIndexPath.item] atIndex:_moveIndexPath.item];
        [orignalSection removeObject:orignalSection[_originalIndexPath.item]];
    }
    //将重排好的数据传递给外部
    NSLog(@"%@",temp.copy);
    NSLog(@"%@",temp);
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:temp.copy];
    }
}

- (void)handelItemInSpace {
    NSArray *totalArray = [self findAllLastIndexPathInVisibleSection];
    for (NSIndexPath * indexPath in totalArray) {
        NSLog(@"%ld",(long)indexPath.row);
    }
    self.moveIndexPath = nil;
    NSMutableArray *sourceArray = nil;
    //获取数据源
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        sourceArray = [NSMutableArray arrayWithArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    for (NSIndexPath *indexPath in totalArray) {
        SFCollectionViewCell *sectionLastCell = (SFCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
        CGRect tempRect = CGRectMake(CGRectGetMaxX(sectionLastCell.frame),
                                         CGRectGetMinY(sectionLastCell.frame),
                                         self.frame.size.width - CGRectGetMaxX(sectionLastCell.frame),
                                         CGRectGetHeight(sectionLastCell.frame));
        NSLog(@"%ld",(long)indexPath.item);
        NSLog(@"%@--%@",NSStringFromCGRect(tempRect),NSStringFromCGRect(sectionLastCell.frame));
        NSLog(@"%@",NSStringFromCGPoint(_tempMoveCell.center));
            //空白区域小于item款度(实际是item的列间隙)
        if (CGRectGetWidth(tempRect) < CGRectGetWidth(sectionLastCell.frame)) {
            continue;
        }
        if (CGRectContainsPoint(tempRect, _tempMoveCell.center)) {
            _moveIndexPath = indexPath;
            break;
        }
    }
    if (_moveIndexPath != nil) {
        [self moveItemToIndexPath:_moveIndexPath withSource:sourceArray];
    }else{
        _moveIndexPath = _originalIndexPath;
        UICollectionViewCell *sectionLastCell = [self cellForItemAtIndexPath:_moveIndexPath];
        float spaceHeight =    (self.frame.size.height - CGRectGetMaxY(sectionLastCell.frame)) > CGRectGetHeight(sectionLastCell.frame)?
        (self.frame.size.height - CGRectGetMaxY(sectionLastCell.frame)):0;
        
        CGRect spaceRect = CGRectMake(0,
                                      CGRectGetMaxY(sectionLastCell.frame),
                                      self.frame.size.width,
                                      spaceHeight);
        
        if (spaceHeight != 0 && CGRectContainsPoint(spaceRect, _tempMoveCell.center)) {
            [self moveItemToIndexPath:_moveIndexPath withSource:sourceArray];
        }
    }
}

- (void)moveItemToIndexPath:(NSIndexPath *)indexPath withSource:(NSMutableArray *)array
{
    if (_originalIndexPath.section == indexPath.section ){
        //同一分组
        if (_originalIndexPath.row != indexPath.row) {
            
            [self exchangeItemInSection:indexPath withSource:array];
        }else if (_originalIndexPath.row == indexPath.row){
            return;
        }
    }
}
- (void)exchangeItemInSection:(NSIndexPath *)indexPath withSource:(NSMutableArray *)sourceArray{
    
    NSMutableArray *orignalSection = [NSMutableArray arrayWithArray:sourceArray];
    NSInteger currentRow = _originalIndexPath.row;
    NSInteger toRow = indexPath.row;
    [orignalSection exchangeObjectAtIndex:currentRow withObjectAtIndex:toRow];
    //将重排好的数据传递给外部
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:sourceArray.copy];
    }
    [self moveItemAtIndexPath:_originalIndexPath toIndexPath:indexPath];
}

- (NSArray *)findAllLastIndexPathInVisibleSection{
    NSArray *array = [self indexPathsForVisibleItems];
    if (!array.count) {
        return nil;
    }
    array = [array sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        return obj1.section > obj2.section;
    }];
    NSMutableArray *totalArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger tempSection = -1;
    NSMutableArray *tempArray = nil;
    for (NSIndexPath *indexPath in array) {
        if (tempSection != indexPath.section) {
            tempSection = indexPath.section;
            if (tempArray) {
                NSArray *temp = [tempArray sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
                    return obj1.row > obj2.row;
                }];
                [totalArray addObject:temp.lastObject];
            }
            tempArray = [NSMutableArray arrayWithCapacity:0];
        }
        [tempArray addObject:indexPath];
    }
    
    NSArray *temp = [tempArray sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        return obj1.row > obj2.row;
    }];
    if (temp.count) {
        [totalArray addObject:temp.lastObject];
    }
    return totalArray.copy;
}
@end
