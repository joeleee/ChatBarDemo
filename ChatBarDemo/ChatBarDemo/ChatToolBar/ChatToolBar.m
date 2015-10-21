//
//  ChatToolBar.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-13.
//  Copyright © 2015年 Joe Lee. All rights reserved.
//

#import "ChatToolBar.h"

#import "ChatToolBarLayout.h"

const CGFloat collectionViewHeight = 60.0f;

@interface ChatToolBar () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSLayoutConstraint *collectionViewHeight;

@end

@implementation ChatToolBar

+ (UIColor *)randomColor
{
  CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
  CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
  CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (instancetype)init
{
  if (self = [super init]) {
  }
  [self subviewsInit];

  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)subviewsInit
{
  [self addSubview:self.collectionView];

  NSDictionary *metrics = nil;
  NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_collectionView]-5-|" options:0 metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_collectionView]" options:0 metrics:metrics views:views]];
  self.collectionViewHeight = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:collectionViewHeight];
  [self addConstraint:self.collectionViewHeight];
}

#pragma mark - CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];

  cell.backgroundColor = [self.class randomColor];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - getters & setters

- (UICollectionView *)collectionView
{
  if (_collectionView) {
    return _collectionView;
  }

  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
  _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  _collectionView.delegate = self;
  _collectionView.dataSource = self;
  _collectionView.backgroundColor = [UIColor darkGrayColor];
  [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
  _collectionView.showsHorizontalScrollIndicator = NO;
  _collectionView.showsVerticalScrollIndicator = NO;
  _collectionView.pagingEnabled = YES;
  return _collectionView;
}

- (UICollectionViewLayout *)collectionViewLayout
{
  if (_collectionViewLayout) {
    return _collectionViewLayout;
  }

  UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  collectionViewLayout.minimumLineSpacing = 5.0f;
  collectionViewLayout.minimumInteritemSpacing = 5.0f;
  collectionViewLayout.itemSize = CGSizeMake(50, 50);
  collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 5.0f, 0, 5.0f);

  _collectionViewLayout = collectionViewLayout;
  return _collectionViewLayout;
}

@end
