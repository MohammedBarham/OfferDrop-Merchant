//
//  ODBeaconBroadcastingView.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODBeaconBroadcastingView : UIView

@property (nonatomic, strong) UIButton * broadcastingButton;
@property (nonatomic, strong) UISwitch * broadcastingSwitch;
@property (nonatomic, strong) ODAppDelegate * appDelegete;
@end
