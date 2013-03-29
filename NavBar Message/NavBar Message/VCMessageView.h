//
//  VCMessageView.h
//  NavBar Message
//
//  Created by venj on 13-3-29.
//  Copyright (c) 2013年 venj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCMessageView : UIView
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIImage *backgroundImage;
- (void)showInView:(UIView *)parentView;
@end
