//
//  ContentViewController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-15.
//  Copyright © 2015 Joe Lee. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation ContentViewController

+ (UIColor *)randomColor
{
  CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
  CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
  CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)loadView
{
  UIView *view = [[UIView alloc] init];
  view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.view = view;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor grayColor];

  [self.view addSubview:self.collectionView];
  NSDictionary *metrics = nil;
  NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_collectionView]-10-|" options:0 metrics:metrics views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_collectionView]-0-|" options:0 metrics:metrics views:views]];
}

#pragma mark - UICollectionView delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
  cell.backgroundColor = [self.class randomColor];

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"select %ld - %ld", (long)indexPath.section, (long)indexPath.row);
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
  [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
  _collectionView.backgroundColor = [UIColor clearColor];
  return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout
{
  if (_collectionViewLayout) {
    return _collectionViewLayout;
  }

  _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
  _collectionViewLayout.minimumInteritemSpacing = 5.0f;
  _collectionViewLayout.minimumLineSpacing = 10.0f;
  _collectionViewLayout.itemSize = CGSizeMake(80, 80);
  _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  return _collectionViewLayout;
}

@end