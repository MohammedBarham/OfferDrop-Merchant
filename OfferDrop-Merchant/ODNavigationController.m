//
//  ODNavigationControllerViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODNavigationController.h"

#import "ODColors.h"
#import "ODFonts.h"

@interface ODNavigationController ()

@end

@implementation ODNavigationController

-(id)init
{
    self = [super init];
    if (self) {
        
        [self CustomizeNavigationBar];
    }
    
    return self;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        
        [self CustomizeNavigationBar];
    }
    
    return self;
}

-(void) CustomizeNavigationBar
{
    // set navigation bar background image
    //[self.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navigation_bar_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    
    // set navigation bar color
    //[self.navigationBar setTintColor:[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0]];
    
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:OD_ACTIVE_COLOR, OD_NAVIGATION_BAR_FONT, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:OD_ACTIVE_COLOR, OD_NAVIGATION_BAR_ITEMS_FONT, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]] forState:UIControlStateNormal];
    
}
@end
