//
//  ODPromoteViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/12/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODPromoteViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) IBOutlet UILabel * promoteTitleLabel;
@property (nonatomic, strong) IBOutlet UITextView * promoteDescriptionTextView;

@property (nonatomic, strong) IBOutlet UILabel * offerDropAppTitle;
@property (nonatomic, strong) IBOutlet UITextView * offerDropAppDescription;

@property (nonatomic, strong) IBOutlet UIButton * emailMeFlyer;
@property (nonatomic, strong) IBOutlet UIButton * EmailAppStoreLink;

@property (nonatomic, strong) IBOutlet UILabel * qrTitleLabel;

@property (nonatomic, strong) UIView * emailsView;
@property (nonatomic, strong) UITextView * emailTextView;

@property (nonatomic) BOOL isUserDeletingChars;
@property (nonatomic) BOOL isSendButtonPressed;
@property (nonatomic) NSInteger lastTimeCharNum;

-(IBAction) emailMeFlyerClicked:(id)sender;
-(IBAction) emailAppStoreLink;
@end
