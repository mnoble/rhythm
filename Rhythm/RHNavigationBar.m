//
//  RHNavigationBar.m
//  Rhythm
//
//  Created by Matthew Noble on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RHNavigationBar.h"

@implementation RHNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIImage *background = [UIImage imageNamed:@"navbar-bg.png"];
    [background drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)willMoveToWindow:(UIWindow *)window
{
    [super willMoveToWindow:window];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle
{
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(0, 10)];
    [self.layer setShadowOpacity:0.35];
    [self.layer setMasksToBounds:NO];
    [self.layer setShouldRasterize:YES];
}

@end
