//
//  ODLoadingView.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODLoadingView.h"

@implementation ODLoadingView

@synthesize myAnimatedView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *myImages = [NSArray arrayWithObjects:
							 [UIImage imageNamed:@"loading0001.png"],
							 [UIImage imageNamed:@"loading0002.png"],
							 [UIImage imageNamed:@"loading0003.png"],
							 [UIImage imageNamed:@"loading0004.png"],
							 [UIImage imageNamed:@"loading0005.png"],
							 [UIImage imageNamed:@"loading0006.png"],
							 [UIImage imageNamed:@"loading0007.png"],
							 [UIImage imageNamed:@"loading0008.png"],
							 [UIImage imageNamed:@"loading0009.png"],
							 [UIImage imageNamed:@"loading0010.png"],
							 [UIImage imageNamed:@"loading0011.png"],
							 [UIImage imageNamed:@"loading0012.png"],
							 [UIImage imageNamed:@"loading0013.png"],
							 [UIImage imageNamed:@"loading0014.png"],
							 [UIImage imageNamed:@"loading0015.png"],
							 [UIImage imageNamed:@"loading0016.png"],
							 [UIImage imageNamed:@"loading0017.png"],
							 [UIImage imageNamed:@"loading0018.png"],
							 [UIImage imageNamed:@"loading0019.png"],
							 [UIImage imageNamed:@"loading0020.png"],
							 nil];
		
		self.myAnimatedView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 65.0, 65.0)];
        [self.myAnimatedView setCenter:CGPointMake(frame.size.width/2.0, (frame.size.height/2.0 ))];
        self.myAnimatedView.animationImages = myImages;
		self.myAnimatedView.animationDuration = 0.70; // seconds
		self.myAnimatedView.animationRepeatCount = 0; // 0 = loops forever
		[self.myAnimatedView startAnimating];
		[self addSubview:self.myAnimatedView];
		
		self.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
