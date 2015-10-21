//
//  MessageListViewController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-12.
//  Copyright © 2015年 Joe Lee. All rights reserved.
//

#import "MessageListViewController.h"
#import "ChatTextCell.h"
#import "ContentViewController.h"

const CGFloat chatToolBarHeight = 100.0f;

@interface MessageListViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *chatToolBar;
@property (nonatomic, strong) ContentViewController *contentViewController;
@property (nonatomic, strong) NSLayoutConstraint *chatBarBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *chatBarHeightConstraint;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipGesture;

@property (nonatomic, strong) NSMutableArray *messageList;
@property (nonatomic, assign) BOOL isContentFullScreen;

@end

@implementation MessageListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Message List";
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(leftButtonTapped:)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightButtonTapped:)];

  self.messageList = [NSMutableArray arrayWithObjects:@"Hi, who are you?", @"I'm Jobs!", @"You are kidding! Where are you?", @"You know I always at your back", @"!@#$@#%^%&(&()*)((%^@$%%^*(()*@#$!%^*(+*&&^@!$@#&*)_*(&#@$!#$%^$&_*&^*#^$@%()_&%^", @"Turned to look at me.", @"Hi, who are you?", @"I'm Jobs!", @"You are kidding! Where are you?", @"You know I always at your back", @"!@#$@#%^%&(&()*)((%^@$%%^*(()*@#$!%^*(+*&&^@!$@#&*)_*(&#@$!#$%^$&_*&^*#^$@%()_&%^", @"Turned to look at me.", nil];
  [self layoutInit];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:[self.tableView numberOfSections] - 1] - 1 inSection:[self.tableView numberOfSections] - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)layoutInit
{
  [self.view addSubview:self.tableView];
  [self.view addSubview:self.chatToolBar];

  NSDictionary *metrics = nil;
  NSDictionary *views = NSDictionaryOfVariableBindings(_tableView, _chatToolBar);

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableView]-0-[_chatToolBar]" options:0 metrics:metrics views:views]];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:-chatToolBarHeight]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:metrics views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_chatToolBar]-0-|" options:0 metrics:metrics views:views]];

  self.chatBarBottomConstraint = [NSLayoutConstraint constraintWithItem:self.chatToolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
  self.chatBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.chatToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:chatToolBarHeight];
  [self.view addConstraints:@[self.chatBarBottomConstraint, self.chatBarHeightConstraint]];
  self.isContentFullScreen = NO;
}

- (BOOL)shouldPanContentView:(UIGestureRecognizer *)gestureRecognizer
{
  CGPoint translationInView = [self.panGesture translationInView:self.chatToolBar];
  if (self.isContentFullScreen) {
    if (self.contentViewController.collectionView.contentOffset.y == 0 && translationInView.y > 0.0f) {
      return YES;
    } else {
      return NO;
    }
  }
  return YES;
}

#pragma mark - actions

- (void)leftButtonTapped:(id)sender
{
}

- (void)rightButtonTapped:(id)sender
{
}

static CGFloat initHeight = 0.0f;
- (void)didDragChatToolBar:(id)sender
{
  if (sender != self.panGesture) {
    return;
  }

  switch (self.panGesture.state) {
    case UIGestureRecognizerStatePossible:
    case UIGestureRecognizerStateBegan: {
      initHeight = self.chatBarHeightConstraint.constant;
    } break;
    case UIGestureRecognizerStateChanged: {
      CGPoint translationInView = [self.panGesture translationInView:self.chatToolBar];
      CGFloat yMoves = translationInView.y;
      if ((chatToolBarHeight < initHeight - yMoves) &&
          (initHeight - yMoves < self.view.frame.size.height)) {
        self.chatBarHeightConstraint.constant = initHeight - yMoves;
      }
    } break;
    default: {
      if (self.chatBarHeightConstraint.constant > self.view.frame.size.height / 2.0f) {
        self.chatBarHeightConstraint.constant = self.view.frame.size.height;
        self.isContentFullScreen = YES;
        self.title = @"Gallery";
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftButtonTapped:)] animated:YES];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightButtonTapped:)] animated:YES];
      } else {
        self.chatBarHeightConstraint.constant = chatToolBarHeight;
        self.isContentFullScreen = NO;
        self.title = @"Message List";
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(leftButtonTapped:)] animated:YES];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightButtonTapped:)] animated:YES];
      }
      [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.7f options:0 animations:^{
        [self.view layoutIfNeeded];
      } completion:^(BOOL finished) {
      }];
    } break;
  }
}

- (void)didSwipChatToolBar:(id)sender
{
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  return [self shouldPanContentView:gestureRecognizer];
}

#pragma mark - tableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ChatTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ChatTextCell.class)];
  if (indexPath.row >= self.messageList.count) {
    cell.userNameLabel.text = @"ERROR";
    cell.messageTextLabel.text = @"ERROR";
    return cell;
  }

  cell.userImageView.backgroundColor = [UIColor grayColor];
  cell.userNameLabel.text = @"userNameLabel";
  cell.messageTextLabel.text = self.messageList[indexPath.row];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row >= self.messageList.count) {
    return 0;
  }

  return [ChatTextCell requiredCellHeightForText:self.messageList[indexPath.row]];
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
  [_tableView registerClass:ChatTextCell.class forCellReuseIdentifier:NSStringFromClass(ChatTextCell.class)];
  return _tableView;
}

- (UIView *)chatToolBar
{
  if (_chatToolBar) {
    return _chatToolBar;
  }

  _chatToolBar = [[UIView alloc] init];
  _chatToolBar.translatesAutoresizingMaskIntoConstraints = NO;
  _chatToolBar.backgroundColor = [UIColor grayColor];

  self.contentViewController = [[ContentViewController alloc] init];
  [self.contentViewController willMoveToParentViewController:self];
  [self addChildViewController:self.contentViewController];
  [_chatToolBar addSubview:self.contentViewController.view];
  [self.contentViewController didMoveToParentViewController:self];

  self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragChatToolBar:)];
  self.panGesture.delegate = self;
  [_chatToolBar addGestureRecognizer:self.panGesture];

  self.swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipChatToolBar:)];
  self.swipGesture.delegate = self;
  self.swipGesture.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
  [_chatToolBar addGestureRecognizer:self.swipGesture];

  [self.contentViewController.collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.panGesture];
  [self.panGesture requireGestureRecognizerToFail:self.swipGesture];

  return _chatToolBar;
}

@end