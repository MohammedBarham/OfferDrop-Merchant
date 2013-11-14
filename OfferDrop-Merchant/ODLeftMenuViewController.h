//
//  ODLeftMenuViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODLeftMenuViewController : UIViewController

@property (nonatomic, strong) ODAppDelegate * appDelegate;
@property (nonatomic, strong) IBOutlet UIImageView * merchantLogoImgView;

@property (nonatomic, strong) IBOutlet UIButton * welcomeNotificationButton;
@property (nonatomic, strong) IBOutlet UIButton * createOfferButton;
@property (nonatomic, strong) IBOutlet UIButton * activeOffersButton;
@property (nonatomic, strong) IBOutlet UIButton * offerStatsButton;
@property (nonatomic, strong) IBOutlet UIButton * promoteButton;
@property (nonatomic, strong) IBOutlet UIButton * settingsButton;
@property (nonatomic, strong) IBOutlet UILabel * merchantNameLabel;

@property (nonatomic) NSInteger selectedButtonTag;

-(IBAction) menuButtonClicked:(id)sender;
-(IBAction)Logout:(id)sender;
@end
