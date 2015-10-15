//
//  ContainerViewController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-15.
//  Copyright © 2015 Joe Lee. All rights reserved.
//

#import "ContainerViewController.h"

#import "MessageListViewController.h"
#import "ContentViewController.h"

@interface ContainerViewController ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) MessageListViewController *messageViewController;
@property (nonatomic, strong) ContentViewController *boardViewController;

@end

@implementation ContainerViewController

- (instancetype)init
{
  if (self = [super init]) {
  }
  return self;
}

- (void)loadView
{
  [super loadView];

  self.messageViewController = [[MessageListViewController alloc] init];
  self.boardViewController = [[ContentViewController alloc] init];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

@end