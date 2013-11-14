//
//  ODSignUpViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODSignUpViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) IBOutlet UIButton * logoButton;
@property (nonatomic, strong) IBOutlet UIButton * facebookConnectButton;
@property (nonatomic, strong) IBOutlet UILabel * facebookConnectDescLabel;

@property (nonatomic, strong) IBOutlet UITextField * contactNameTextField;
@property (nonatomic, strong) IBOutlet UITextField * contactEmailTextField;
@property (nonatomic, strong) IBOutlet UITextField * passwordtextField;
@property (nonatomic, strong) IBOutlet UITextField * retypePasswordTextField;
@property (nonatomic, strong) IBOutlet UITextField * businessNameTextField;
@property (nonatomic, strong) IBOutlet UITextField * businessTypeTextField;
@property (nonatomic, strong) IBOutlet UITextField * phoneNumberTextField;
@property (nonatomic, strong) IBOutlet UITextField * addressTextField;

@property (nonatomic, strong) IBOutlet UIImageView * contactNameFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * contactEmailFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * passwordFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * retypePasswordFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * businessNameFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * businessTypeFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * phoneFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * addressFieldErrorView;
@property (nonatomic, strong) IBOutlet UIButton * userLocationButton;

@property (nonatomic, strong) UIImage * merchantLogoImage;

@property (nonatomic) BOOL isAddressFieldThatHidesKeyboard;
@property (nonatomic) NSInteger selectedTextFieldTag;
@property (nonatomic) BOOL isKeyBoardForceHide;

@property (nonatomic, strong) UIPopoverController * popoverController;

-(IBAction)logoButtonPressed:(id)sender;
-(IBAction)facebookConnectButtonPressed:(id)sender;
-(IBAction)locationButtonPressed:(id)sender;

@end
