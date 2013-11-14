//
//  ODLoginViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ODAppDelegate;

@interface ODLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;
@property (nonatomic, strong) IBOutlet UIView * viewOfContents;

@property (nonatomic, strong) IBOutlet UITextField * userNameTextField;
@property (nonatomic, strong) IBOutlet UITextField * passwordTextField;

@property (nonatomic, strong) IBOutlet UIButton * signInButton;
@property (nonatomic, strong) IBOutlet UIButton * signupButton;
@property (nonatomic, strong) IBOutlet UIButton * forgetPasswordButton;

@property (nonatomic, strong) IBOutlet UIImageView * userNameTextFieldErrorView;
@property (nonatomic, strong) IBOutlet UIImageView * passwordTextFieldErrorView;

-(IBAction) loginViewButtonPressed:(id)sender;

@end
