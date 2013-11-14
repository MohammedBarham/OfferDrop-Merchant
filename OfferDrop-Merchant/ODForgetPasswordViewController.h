//
//  ODForgetPasswordViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODForgetPasswordViewController : UIViewController

@property (nonatomic, strong) ODAppDelegate * appDelegate;
@property (nonatomic, strong) IBOutlet UIView * viewOfContents;
@property (nonatomic, strong) IBOutlet UITextField * userNameTextField;
@property (nonatomic, strong) IBOutlet UIButton * sendButton;
@property (nonatomic, strong) IBOutlet UIImageView * userNameTextFieldErrorView;
@property (nonatomic, strong) IBOutlet UILabel * forgetPasswordTextLabel;

-(IBAction) sendButtonPressed:(id)sender;

@end
