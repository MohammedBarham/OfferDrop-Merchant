//
//  ODBeaconBroadcastingView.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODBeaconBroadcastingView.h"
#import "ODFonts.h"
#import "ODColors.h"
#import "ODAppDelegate.h"

@implementation ODBeaconBroadcastingView

@synthesize broadcastingButton, broadcastingSwitch;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.appDelegete = (ODAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        self.broadcastingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(165.0, 4.0, 51.0, 31.0)];
        if (self.appDelegete.isTransmittingEnabled) {
            [self.broadcastingSwitch setOn:YES];
        } else {
            [self.broadcastingSwitch setOn:NO];
        }
        [self.broadcastingSwitch addTarget:self action:@selector(BroadcaseButtonPressed) forControlEvents:UIControlEventValueChanged];
        
        UILabel * firstLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 3.0, 150.0, 15.0)];
        [firstLineLabel setFont:[UIFont fontWithName:OD_MAIN_FONT_NAME size:13.0]];
        [firstLineLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
        [firstLineLabel setText:NSLocalizedString(@"Broadcasting", @"")];
        [firstLineLabel setTextAlignment:NSTextAlignmentRight];
        [firstLineLabel setBackgroundColor:[UIColor clearColor]];
        
        UILabel * secondLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 17.0, 150.0, 15.0)];
        [secondLineLabel setFont:[UIFont fontWithName:OD_MAIN_FONT_NAME size:11.0]];
        [secondLineLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
        [secondLineLabel setText:NSLocalizedString(@"(Active Offers & Welcome)", @"")];
        [secondLineLabel setTextAlignment:NSTextAlignmentRight];
        [secondLineLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:firstLineLabel];
        [self addSubview:secondLineLabel];
        [self addSubview:self.broadcastingSwitch];
    }
    return self;
}

-(void) BroadcaseButtonPressed
{
    self.appDelegete.isTransmittingEnabled = self.broadcastingSwitch.isOn;
    [self.appDelegete turnOnOffBeaconTransision];
}



@end
