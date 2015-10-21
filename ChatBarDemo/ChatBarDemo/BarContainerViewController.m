//
//  BarContainerViewController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-17.
//  Copyright © 2015 Joe Lee. All rights reserved.
//

#import "BarContainerViewController.h"

#import "ChatToolBar.h"

const CGFloat toolBarHeight = 70.0f;

@interface BarContainerViewController ()

@property (nonatomic, strong) ChatToolBar *toolBar;
@property (nonatomic, strong) NSLayoutConstraint *toolBarHeight;

@end


@implementation BarContainerViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  [self subviewsInit];
}

- (void)subviewsInit
{
  [self.view addSubview:self.toolBar];

  NSDictionary *metrics = nil;
  NSDictionary *views = NSDictionaryOfVariableBindings(_toolBar);

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_toolBar]-5-|" options:0 metrics:metrics views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolBar]-5-|" options:0 metrics:metrics views:views]];
  self.toolBarHeight = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:toolBarHeight];
  [self.view addConstraint:self.toolBarHeight];
}

#pragma mark - getters & setters

- (ChatToolBar *)toolBar
{
  if (_toolBar) {
    return _toolBar;
  }

  _toolBar = [[ChatToolBar alloc] init];
  _toolBar.backgroundColor = [UIColor grayColor];
  _toolBar.translatesAutoresizingMaskIntoConstraints = NO;
  return _toolBar;
}

@end