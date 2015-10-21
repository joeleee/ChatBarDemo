//
//  RootNavigationController.m
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-17.
//  Copyright © 2015 Joe Lee. All rights reserved.
//

#import "RootNavigationController.h"

#import <FLEX/FLEXManager.h>

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
{
  if (UIEventSubtypeMotionShake == motion &&
      UIEventTypeMotion == event.type &&
      UIEventSubtypeMotionShake == event.subtype) {
    if ([[FLEXManager sharedManager] isHidden]) {
      [[FLEXManager sharedManager] showExplorer];
    } else {
      [[FLEXManager sharedManager] hideExplorer];
    }
  }
}

@end