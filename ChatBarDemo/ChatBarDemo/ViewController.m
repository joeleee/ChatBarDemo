//
//  ViewController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-12.
//  Copyright © 2015年 Joe Lee. All rights reserved.
//

#import "ViewController.h"
#import "ChatToolBar.h"

const CGFloat chatToolBarHeight = 50.0f;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ChatToolBar *chatToolBar;
@property (nonatomic, strong) NSLayoutConstraint *chatBarBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *chatBarHeightConstraint;

@property (nonatomic, strong) NSMutableArray *messageList;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Message List";
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(leftButtonTapped:)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightButtonTapped:)];

  self.messageList = [NSMutableArray arrayWithObjects:@"Hi, who are you?", @"I'm Jobs!", @"You are kidding! Where are you?", @"You know I always at your back", @"!@#$@#%^%&(&()*)((%^@$%%^*(()*@#$!%^*(+*&&^@!$@#&*)_*(&#@$!#$%^$&_*&^*#^$@%()_&%^", @"Turned to look at me.", nil];
  [self layoutInit];
}

- (void)layoutInit
{
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.chatToolBar];

  NSDictionary *metrics = nil;
  NSDictionary *views = NSDictionaryOfVariableBindings(_tableView, _chatToolBar);

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-[_chatToolBar]" options:0 metrics:metrics views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:metrics views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_chatToolBar]-0-|" options:0 metrics:metrics views:views]];

  self.chatBarBottomConstraint = [NSLayoutConstraint constraintWithItem:self.chatToolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
  self.chatBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.chatToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:chatToolBarHeight];
  [self.view addConstraints:@[self.chatBarBottomConstraint, self.chatBarHeightConstraint]];
}

- (void)leftButtonTapped:(id)sender
{
  self.chatBarBottomConstraint.constant = -100.0f;
  self.chatBarHeightConstraint.constant = 100.0f;
  [UIView animateWithDuration:0.2 animations:^{
    [self.view layoutIfNeeded];
  }];
}

- (void)rightButtonTapped:(id)sender
{
  self.chatBarBottomConstraint.constant = 0.0f;
  self.chatBarHeightConstraint.constant = chatToolBarHeight;
  [UIView animateWithDuration:0.2 animations:^{
    [self.view layoutIfNeeded];
  }];
}

#pragma mark - tableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

#pragma mark - getters & setters

- (UITableView *)tableView
{
  if (_tableView) {
    return _tableView;
  }

  _tableView = [[UITableView alloc] init];
  _tableView.translatesAutoresizingMaskIntoConstraints = NO;
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableView.delegate = self;
  _tableView.dataSource = self;
  _tableView.backgroundColor = [UIColor clearColor];
  _tableView.showsVerticalScrollIndicator = NO;
  return _tableView;
}

- (ChatToolBar *)chatToolBar
{
  if (_chatToolBar) {
    return _chatToolBar;
  }

  _chatToolBar = [[ChatToolBar alloc] init];
  _chatToolBar.translatesAutoresizingMaskIntoConstraints = NO;
  _chatToolBar.backgroundColor = [UIColor grayColor];
  return _chatToolBar;
}

@end