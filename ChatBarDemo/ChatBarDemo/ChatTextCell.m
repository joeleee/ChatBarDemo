//
//  ChatTextCell.m
//
//  Created by Joe Lee on 2015-7-17.
//  Copyright (c) 2015年 Joe. All rights reserved.
//

#import "ChatTextCell.h"

#define CHAT_TEXT_FONT [UIFont systemFontOfSize:13.0f]

static CGFloat const kBubbleTopMargin = 3.0f;
static CGFloat const kBubbleLeftMargin = 15.0f;
static CGFloat const kUserImageWidth = 35.0f;
static CGFloat const kUserImageTopMargin = 8.0f;
static CGFloat const kUserImageLeftMargin = 8.0f;
static CGFloat const kUserNameLabelTopMargin = 10.0f;
static CGFloat const kUserNameLabelHeight = 14.0f;
static CGFloat const kMessageTextLabelTopMargin = 1.5f;
static CGFloat const kMessageTextLabelBottomMargin = 10.0f;
static CGFloat const kMessageTextLabelLeftMargin = 10.0f;
static CGFloat const kMessageTextLabelRightMargin = 10.0f;


@interface ChatTextCell ()

@property (nonatomic, strong) UIView *bubbleBackgroundView;
@property (nonatomic, strong) UIImageView *bubbleImageView;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *messageTextLabel;

@end


@implementation ChatTextCell

+ (CGFloat)requiredCellHeightForText:(NSString *)text
{
    static NSCache *cellHeightCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellHeightCache = [[NSCache alloc] init];
        cellHeightCache.countLimit = 100;
    });

    NSNumber *cachedHeight = [cellHeightCache objectForKey:text];
    if (cachedHeight) {
        return [cachedHeight floatValue];
    }

    CGFloat requiredHeight = kBubbleTopMargin + kUserNameLabelTopMargin + kUserNameLabelHeight + kMessageTextLabelTopMargin + kMessageTextLabelBottomMargin;

    CGFloat textMaxWidth = [UIApplication sharedApplication].keyWindow.frame.size.width - (kBubbleLeftMargin + kUserImageLeftMargin + kUserImageWidth + kMessageTextLabelLeftMargin + kMessageTextLabelRightMargin + kBubbleLeftMargin);
    CGFloat textHeight = [text boundingRectWithSize:CGSizeMake(textMaxWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: CHAT_TEXT_FONT} context:nil].size.height; // 17.895f
    if (textHeight > 40.0f) {
        textHeight = 40.0f;
    }

    requiredHeight += textHeight;
    if (requiredHeight < kUserImageTopMargin + kUserImageWidth + kUserImageTopMargin) {
        requiredHeight = kUserImageTopMargin + kUserImageWidth + kUserImageTopMargin;
    }

    [cellHeightCache setObject:@(requiredHeight) forKey:text];
    return requiredHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }

    return self;
}

- (void)setupSubviews
{
    [self.contentView addSubview:self.bubbleBackgroundView];
    [self.bubbleBackgroundView addSubview:self.bubbleImageView];
    [self.bubbleBackgroundView addSubview:self.userImageView];
    [self.bubbleBackgroundView addSubview:self.userNameLabel];
    [self.bubbleBackgroundView addSubview:self.messageTextLabel];
    self.bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bubbleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.userImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageTextLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{@"kUserImageWidth": @(kUserImageWidth),
                              @"kBubbleTopMargin": @(kBubbleTopMargin),
                              @"kBubbleLeftMargin": @(kBubbleLeftMargin),
                              @"kUserNameLabelTopMargin": @(kUserNameLabelTopMargin),
                              @"kUserNameLabelHeight": @(kUserNameLabelHeight),
                              @"kMessageTextLabelTopMargin": @(kMessageTextLabelTopMargin),
                              @"kMessageTextLabelBottomMargin": @(kMessageTextLabelBottomMargin),
                              @"kUserImageTopMargin": @(kUserImageTopMargin),
                              @"kUserImageLeftMargin": @(kUserImageLeftMargin),
                              @"kMessageTextLabelLeftMargin": @(kMessageTextLabelLeftMargin),
                              @"kMessageTextLabelRightMargin": @(kMessageTextLabelRightMargin)};
    NSDictionary *views = NSDictionaryOfVariableBindings(_bubbleBackgroundView, _bubbleImageView, _userImageView, _userNameLabel, _messageTextLabel);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kBubbleLeftMargin-[_bubbleBackgroundView]->=kBubbleLeftMargin-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kBubbleTopMargin-[_bubbleBackgroundView]-0-|" options:0 metrics:metrics views:views]];

    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bubbleImageView]-0-|" options:0 metrics:metrics views:views]];
    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bubbleImageView]-0-|" options:0 metrics:metrics views:views]];

    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kUserImageLeftMargin-[_userImageView(==kUserImageWidth)]" options:0 metrics:metrics views:views]];
    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kUserImageTopMargin-[_userImageView(==kUserImageWidth)]" options:0 metrics:metrics views:views]];

    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-kMessageTextLabelLeftMargin-[_userNameLabel]->=kMessageTextLabelRightMargin-|" options:0 metrics:metrics views:views]];
    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kUserNameLabelTopMargin-[_userNameLabel(==kUserNameLabelHeight)]" options:0 metrics:metrics views:views]];

    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_userImageView]-kMessageTextLabelLeftMargin-[_messageTextLabel]->=kMessageTextLabelRightMargin-|" options:0 metrics:metrics views:views]];
    [self.bubbleBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_userNameLabel]-kMessageTextLabelTopMargin-[_messageTextLabel]-kMessageTextLabelBottomMargin-|" options:0 metrics:metrics views:views]];
}

#pragma mark - getters

- (UIView *)bubbleBackgroundView
{
    if (_bubbleBackgroundView) {
        return _bubbleBackgroundView;
    }

    _bubbleBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _bubbleBackgroundView.backgroundColor = [UIColor clearColor];
    return _bubbleBackgroundView;
}

- (UIImageView *)bubbleImageView
{
    if (_bubbleImageView) {
        return _bubbleImageView;
    }

    _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bubbleImageView.layer.cornerRadius = 4.0f;
    _bubbleImageView.alpha = 0.6f;
    return _bubbleImageView;
}

- (UIImageView *)userImageView
{
    if (_userImageView) {
        return _userImageView;
    }

    _userImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImageView.layer.cornerRadius = kUserImageWidth / 2.0f;
    _userImageView.clipsToBounds = YES;
    return _userImageView;
}

- (UILabel *)userNameLabel
{
    if (_userNameLabel) {
        return _userNameLabel;
    }

    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLabel.numberOfLines = 1;
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.font = [UIFont systemFontOfSize:10.0f];
    _userNameLabel.alpha = 0.5f;
    _userNameLabel.minimumScaleFactor = 10.0f / 12.0f;
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    return _userNameLabel;
}

- (UILabel *)messageTextLabel
{
    if (_messageTextLabel) {
        return _messageTextLabel;
    }

    _messageTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageTextLabel.numberOfLines = 3;
    _messageTextLabel.textColor = [UIColor blackColor];
    _messageTextLabel.font = CHAT_TEXT_FONT;
    _messageTextLabel.minimumScaleFactor = 10.0f / 15.0f;
    _messageTextLabel.adjustsFontSizeToFitWidth = YES;
    return _messageTextLabel;
}

@end