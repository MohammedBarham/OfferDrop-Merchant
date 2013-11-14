//
//  ODSettingsViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODSettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) IBOutlet UILabel * majorIdLabel;
@property (nonatomic, strong) IBOutlet UILabel * minorIdLabel;
@property (nonatomic, strong) IBOutlet UILabel * UUIDLabel;

@property (nonatomic, strong) IBOutlet UILabel * majorIdValue;
@property (nonatomic, strong) IBOutlet UILabel * minorIdValue;
@property (nonatomic, strong) IBOutlet UILabel * UUIDValue;

@property (nonatomic, strong) IBOutlet UILabel * businessLogoLabel;
@property (nonatomic, strong) IBOutlet UIButton * businessLogoImage;
@property (nonatomic, strong) IBOutlet UIButton * businessEditButton;

@property (nonatomic, strong) IBOutlet UITextView * chooseColorsTextView;
@property (nonatomic, strong) IBOutlet UIButton * firstColorButton;
@property (nonatomic, strong) IBOutlet UIButton * secondColorButton;
@property (nonatomic, strong) IBOutlet UIButton * thirdColorButton;
@property (nonatomic, strong) IBOutlet UIButton * fourthColorButton;
@property (nonatomic, strong) IBOutlet UIButton * fifthColorButton;
@property (nonatomic, strong) IBOutlet UIButton * sixthColorButton;

@property (nonatomic, strong) IBOutlet UIButton * majorIdCopyButton;
@property (nonatomic, strong) IBOutlet UIButton * majorIdSendButton;
@property (nonatomic, strong) IBOutlet UIButton * minorIdCopyButton;
@property (nonatomic, strong) IBOutlet UIButton * minorIdSendButton;
@property (nonatomic, strong) IBOutlet UIButton * UUIDCopyButton;
@property (nonatomic, strong) IBOutlet UIButton * UUIDSendButton;

@property (nonatomic, strong) UIPopoverController * popoverController;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView * logoActivityIndicator;

-(IBAction)colorButtonClicked:(id)sender;
-(IBAction)editButtonClicked:(id)sender;
-(IBAction)copySendButtonClicked:(id)sender;

@end
