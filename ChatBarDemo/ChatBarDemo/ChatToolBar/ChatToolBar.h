//
//  ChatToolBar.h
//  ChatBarDemo
//
//  Created by Joe Lee on 2015-10-13.
//  Copyright © 2015年 Joe Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatToolBar;

@protocol ChatToolBarLayoutDataSource <NSObject>

@required
- (NSUInteger)numberOfBarViewsInChatToolBar:(nonnull ChatToolBar *)toolBar;
- (nonnull UIView *)chatToolBar:(nonnull ChatToolBar *)toolBar barViewOfIndex:(NSUInteger)index;
- (nonnull UIView *)chatToolBar:(nonnull ChatToolBar *)toolBar boardViewOfIndex:(NSUInteger)index;
- (CGFloat)chatToolBar:(nonnull ChatToolBar *)toolBar heightForBoardViewOfIndex:(NSUInteger)index;

@optional
- (NSUInteger)numberOfLeftSideBarViewsInChatToolBar:(nonnull ChatToolBar *)toolBar;

@end

@interface ChatToolBar : UIView

@end