//
//  ChatTextCell.h
//
//  Created by Joe Lee on 2015-7-17.
//  Copyright (c) 2015年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTextCell : UITableViewCell

@property (nonatomic, strong, readonly) UIView *bubbleBackgroundView;
@property (nonatomic, strong, readonly) UIImageView *bubbleImageView;
@property (nonatomic, strong, readonly) UIImageView *userImageView;
@property (nonatomic, strong, readonly) UILabel *userNameLabel;
@property (nonatomic, strong, readonly) UILabel *messageTextLabel;

+ (CGFloat)requiredCellHeightForText:(NSString *)text;

@end