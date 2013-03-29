//
//  VCMessageView.m
//  NavBar Message
//
//  Created by venj on 13-3-29.
//  Copyright (c) 2013年 venj. All rights reserved.
//

#import "VCMessageView.h"

@interface VCMessageView()
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation VCMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _backgroundImage = nil;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGFloat height = self.frame.size.height, width = self.frame.size.width;
    CGFloat iconPaddingLeft = 10., iconPaddingTop = height * 0.15, iconWidthHeight = height * 0.7;
    CGFloat labelPaddingLeft = 0;
    CGRect labelFrame = CGRectZero;
    if (self.icon) {
        self.iconView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.iconView];
        self.iconView.frame = CGRectMake(iconPaddingLeft, iconPaddingTop, iconWidthHeight, iconWidthHeight);
        labelPaddingLeft = iconPaddingLeft + iconWidthHeight;
    }
    labelFrame = CGRectMake(labelPaddingLeft, 0.0, width - labelPaddingLeft, height);
    UIFont *messageFont = [UIFont systemFontOfSize:floorf(0.95 * height)];
    UIColor *messageColor = [UIColor redColor];
    if ([self.textLabel respondsToSelector:@selector(attributedText)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.textLabel.text attributes:@{ NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: messageFont }];
        self.textLabel.attributedText = attrString;
    }
    else {
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.font = messageFont;
    }
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textLabel.textColor = messageColor;
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textLabel];
    self.textLabel.frame = labelFrame;
}

- (void)showInView:(UIView *)parentView {
    if ([parentView.subviews indexOfObject:self] != NSNotFound) {
        return;
    }
    [parentView addSubview:self];
    [parentView sendSubviewToBack:self];
    CGFloat width = parentView.frame.size.width;
    CGFloat height = 16.;
    CGRect beforeFrame = CGRectMake(0, -1 * height, width, height);
    CGRect afterFrame = CGRectMake(0, 0, width, height);
    self.frame = beforeFrame;
    // Set bgcolor here
    self.backgroundColor = [UIColor lightGrayColor];
    if (self.backgroundImage) {
        self.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [parentView bringSubviewToFront:self];
        self.frame = afterFrame;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissMessageView:) userInfo:parentView repeats:NO];
}

- (void)dismissMessageView:(NSTimer *)timer {
    UIView *parentView = (UIView *)[timer userInfo];
    CGFloat witdh = parentView.frame.size.width;
    CGFloat height = 16.;
    CGRect afterFrame = CGRectMake(0, -1 * height, witdh, height);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
        [parentView sendSubviewToBack:self];
        [self removeFromSuperview];
    }];
}

@end
