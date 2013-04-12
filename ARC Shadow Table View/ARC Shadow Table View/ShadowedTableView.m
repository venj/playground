//
//  ShadowedTableView.m
//  ShadowedTableView
//
//  Created by Matt Gallagher on 2009/08/21.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//

#import "ShadowedTableView.h"

#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)

@interface ShadowedTableView ()
@property (nonatomic, strong) CAGradientLayer *originShadow;
@property (nonatomic, strong) CAGradientLayer *topShadow;
@property (nonatomic, strong) CAGradientLayer *bottomShadow;
@end

@implementation ShadowedTableView

//
// shadowAsInverse:
//
// Create a shadow layer
//
// Parameters:
//    inverse - if YES then shadow fades upwards, otherwise shadow fades downwards
//
// returns the constructed shadow layer
//
- (CAGradientLayer *)shadowAsInverse:(BOOL)inverse {
	CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
	CGRect newShadowFrame =
		CGRectMake(0, 0, self.frame.size.width,
			inverse ? SHADOW_INVERSE_HEIGHT : SHADOW_HEIGHT);
	newShadow.frame = newShadowFrame;
	CGColorRef darkColor =
		[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:
			inverse ? (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT) * 0.5 : 0.5].CGColor;
	CGColorRef lightColor =
		[self.backgroundColor colorWithAlphaComponent:0.0].CGColor;
    newShadow.colors = inverse ? @[(__bridge id)lightColor, (__bridge id)darkColor] : @[(__bridge id)darkColor, (__bridge id)lightColor];
	return newShadow;
}

//
// layoutSubviews
//
// Override to layout the shadows when cells are laid out.
//
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	//
	// Construct the origin shadow if needed
	//
	if (!self.originShadow) {
		self.originShadow = [self shadowAsInverse:NO];
		[self.layer insertSublayer:self.originShadow atIndex:0];
	}
	else if (![[self.layer.sublayers objectAtIndex:0] isEqual:self.originShadow]) {
		[self.layer insertSublayer:self.originShadow atIndex:0];
	}
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	//
	// Stretch and place the origin shadow
	//
	CGRect originShadowFrame = self.originShadow.frame;
	originShadowFrame.size.width = self.frame.size.width;
	originShadowFrame.origin.y = self.contentOffset.y;
	self.originShadow.frame = originShadowFrame;
	
	[CATransaction commit];
	
	NSArray *indexPathsForVisibleRows = [self indexPathsForVisibleRows];
	if ([indexPathsForVisibleRows count] == 0) {
		[self.topShadow removeFromSuperlayer];
		[self.bottomShadow removeFromSuperlayer];
		return;
	}
	
	NSIndexPath *firstRow = [indexPathsForVisibleRows objectAtIndex:0];
	if ([firstRow section] == 0 && [firstRow row] == 0) {
		UIView *cell = [self cellForRowAtIndexPath:firstRow];
		if (!self.topShadow)
		{
			self.topShadow = [self shadowAsInverse:YES];
			[cell.layer insertSublayer:self.topShadow atIndex:0];
		}
		else if ([cell.layer.sublayers indexOfObjectIdenticalTo:self.topShadow] != 0)
		{
			[cell.layer insertSublayer:self.topShadow atIndex:0];
		}

		CGRect shadowFrame = self.topShadow.frame;
		shadowFrame.size.width = cell.frame.size.width;
		shadowFrame.origin.y = -SHADOW_INVERSE_HEIGHT;
		self.topShadow.frame = shadowFrame;
	}
	else {
		[self.topShadow removeFromSuperlayer];
	}

	NSIndexPath *lastRow = [indexPathsForVisibleRows lastObject];
	if ([lastRow section] == [self numberOfSections] - 1 &&
		[lastRow row] == [self numberOfRowsInSection:[lastRow section]] - 1) {
		UIView *cell =
			[self cellForRowAtIndexPath:lastRow];
		if (!self.bottomShadow)
		{
			self.bottomShadow = [self shadowAsInverse:NO];
			[cell.layer insertSublayer:self.bottomShadow atIndex:0];
		}
		else if ([cell.layer.sublayers indexOfObjectIdenticalTo:self.bottomShadow] != 0)
		{
			[cell.layer insertSublayer:self.bottomShadow atIndex:0];
		}

		CGRect shadowFrame = self.bottomShadow.frame;
		shadowFrame.size.width = cell.frame.size.width;
		shadowFrame.origin.y = cell.frame.size.height;
		self.bottomShadow.frame = shadowFrame;
	}
	else {
		[self.bottomShadow removeFromSuperlayer];
	}
}

@end
