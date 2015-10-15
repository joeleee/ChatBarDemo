//
//  ChatToolBar.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-13.
//  Copyright © 2015年 Joe Lee. All rights reserved.
//

#import "ChatToolBar.h"

const CGFloat toolBarHeight = 50.0f;

@interface ChatToolBar () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputField;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIScrollView *toolScrollView;

@property (nonatomic, strong) NSMutableArray *leftCustomViews;
@property (nonatomic, strong) NSMutableArray *rightCustomViews;
@property (nonatomic, strong) NSMutableArray *boardCustomViews;

@end

@implementation ChatToolBar

- (instancetype)init
{
  if (self = [super init]) {
  }

  return self;
}

- (void)subviewsInit
{

  NSDictionary *metrics = @{@"toolBarHeight" :@(toolBarHeight)};
  NSDictionary *views = NSDictionaryOfVariableBindings(_toolScrollView, _inputField, _cameraButton);

  [self addSubview:self.toolScrollView];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_toolScrollView]-0-|" options:0 metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_toolScrollView(==toolBarHeight)]" options:0 metrics:metrics views:views]];

  NSUInteger customViewsCount = [self.layoutDataSource numberOfBarViewsInChatToolBar:self];
  NSUInteger leftCustomViewsCount = [self.layoutDataSource numberOfLeftSideBarViewsInChatToolBar:self];
  self.leftCustomViews = [NSMutableArray array];
  self.rightCustomViews = [NSMutableArray array];
  self.boardCustomViews = [NSMutableArray array];

  for (NSUInteger index = 0; index < customViewsCount; ++index) {
    UIView *customView = [self.layoutDataSource chatToolBar:self barViewOfIndex:index];
    NSAssert(customView, @"Custom should not be nil!");
    [self.toolScrollView addSubview:customView];

    UIView *lastView = self.rightCustomViews.lastObject ? self.rightCustomViews.lastObject : self.leftCustomViews.lastObject;

    if (index == leftCustomViewsCount) {
      [self.toolScrollView addSubview:self.cameraButton];
      [self.toolScrollView addSubview:self.inputField];
      [self.toolScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_cameraButton, _inputField, lastView)]];
    }

    if (index < leftCustomViewsCount) {
      [self.leftCustomViews addObject:customView];
    } else {
      [self.rightCustomViews addObject:customView];
    }

    UIView *boardView = [self.layoutDataSource chatToolBar:self boardViewOfIndex:index];
    [self addSubview:boardView];
    [self.boardCustomViews addObject:boardView];
  }

}

#pragma mark - UITextViewDelegate

#pragma mark - getters & setters

- (UITextView *)inputField
{
  if (_inputField) {
    return _inputField;
  }

  _inputField = [[UITextView alloc] init];
  _inputField.translatesAutoresizingMaskIntoConstraints = NO;
  return _inputField;
}

- (UIButton *)cameraButton
{
  if (_cameraButton) {
    return _cameraButton;
  }

  _cameraButton = [[UIButton alloc] init];
  _cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
  return _cameraButton;
}

- (UIScrollView *)toolScrollView
{
  if (_toolScrollView) {
    return _toolScrollView;
  }

  _toolScrollView = [[UIScrollView alloc] init];
  _toolScrollView.translatesAutoresizingMaskIntoConstraints = NO;
  _toolScrollView.pagingEnabled = YES;
  return _toolScrollView;
}

@end
