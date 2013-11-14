//
//  ODPromoteViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/12/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODPromoteViewController.h"
#import "ODColors.h"
#import "ODFrames.h"
#import "ODBeaconBroadcastingView.h"
#import "ODAppDelegate.h"
#import "ODFonts.h"
#import <QuartzCore/QuartzCore.h>
#import "ODLoadingView.h"

#define kLoadingViewTag 1000

#define kCancelButtonTag 0
#define kSendButtonTag 1

@interface ODPromoteViewController ()

@end

@implementation ODPromoteViewController

@synthesize promoteTitleLabel, promoteDescriptionTextView, offerDropAppDescription, offerDropAppTitle;
@synthesize EmailAppStoreLink, emailMeFlyer, qrTitleLabel, appDelegate, emailsView, emailTextView, isUserDeletingChars, lastTimeCharNum, isSendButtonPressed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.appDelegate = (ODAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    UIImageView * titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 83.0, 30.0)];
    [titleImgView setImage:[UIImage imageNamed:@"navigation_bar_title_view.png"]];
    [self.navigationItem setTitleView:titleImgView];
    
    ODBeaconBroadcastingView * transmitView = [[ODBeaconBroadcastingView alloc] initWithFrame:RIGHT_MENU_ITEM_TRANSMIT_VIEW_FRAME];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:transmitView];

    [self initTitlesAndTexts];
    
//    // init loading view
//    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
//    [loadingView setTag:kLoadingViewTag];
//    [self.view addSubview:loadingView];
//    [loadingView setHidden:YES];
    
    // register hide keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void) KeyboardDidHide:(NSNotification *)aNotification
{
    if (!self.isSendButtonPressed) {
        [self.emailTextView becomeFirstResponder];
    }
}

-(void) hideLoadingView
{
    [[self.emailsView viewWithTag:kLoadingViewTag] setHidden:YES];
    [self.emailTextView resignFirstResponder];
    [self.emailsView setHidden:YES];
    self.emailsView = nil;
}

-(void) initTitlesAndTexts
{
    [self.promoteTitleLabel setText:NSLocalizedString(@"Promote OfferDrop iPhone app", @"")];
    [self.promoteDescriptionTextView setText:NSLocalizedString(@"Promote description data", @"")];
    [self.promoteDescriptionTextView setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    [self.offerDropAppTitle setText:NSLocalizedString(@"OfferDrop", @"")];
    [self.offerDropAppDescription setText:NSLocalizedString(@"OfferDrop application description", @"")];
    [self.offerDropAppDescription setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    [self.emailMeFlyer setTitle:NSLocalizedString(@"Email me QR PDF Flyer", @"") forState:UIControlStateNormal];
    [self.EmailAppStoreLink setTitle:NSLocalizedString(@"Email App Store link", @"") forState:UIControlStateNormal];
    
    [self.qrTitleLabel setText:NSLocalizedString(@"Allow your customers to scan this QR code to get OfferDrop app", @"")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) emailMeFlyerClicked:(id)sender
{
    
}

-(void) sendButtonPressed
{
    if ([self.emailTextView.text length] > 0) {
        DLog(@"send button pressed");
        self.isSendButtonPressed = YES;
        //[self.emailTextView resignFirstResponder];
        
        ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.emailsView.frame.size.width, 415.0)];
        [loadingView setTag:kLoadingViewTag];
        [self.emailsView addSubview:loadingView];
        
        [UIView animateWithDuration:0.25 animations:^{
            //[self.emailsView setFrame:CGRectMake(0.0, 170.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideLoadingView) userInfo:Nil repeats:NO];
    }
    
}

-(void) cancelSendButtonPressed:(UIButton *)button
{
    switch (button.tag) {
        case kCancelButtonTag:
            self.isSendButtonPressed = YES;
            [self.emailTextView resignFirstResponder];
            [self.emailsView setHidden:YES];
            self.emailsView = nil;
            break;
            
        case kSendButtonTag:
            [self sendButtonPressed];
            break;
            
        default:
            break;
    }
}



-(IBAction) emailAppStoreLink
{
    self.isSendButtonPressed = NO;
    self.emailsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, -20.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [self.emailsView setBackgroundColor:OD_BLOCK_VIEW_BACKGROUND_COLOR];
    
    UIImageView * headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50.0, 20.0, self.appDelegate.mainFrameSize.width - 100.0, 40.0)];
    [self.emailsView addSubview:headerImgView];
    
    self.emailTextView = [[UITextView alloc] initWithFrame:CGRectMake(50.0, 58.0, self.appDelegate.mainFrameSize.width - 100.0, 355.0)];
    [self.emailsView addSubview:self.emailTextView];
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emailsView addSubview:cancelButton];
    
    UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emailsView addSubview:sendButton];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0, 30.0, self.appDelegate.mainFrameSize.width - 160.0 - 160.0, 20.0)];
    [self.emailsView addSubview:titleLabel];
    
    // header view properties
    [self configureHeaderImageView:headerImgView];
    
    // textView properties
    [self configureEmailTextView];
    
    // title label
    [self configureTitleLabel:titleLabel];
    
    // cancel button
    [self configureCancelButton:cancelButton];
    
    // save button
    [self configureSendButton:sendButton];
    
    [self.navigationController.navigationBar addSubview:self.emailsView];
}

#pragma mark - UItextView Delegate

-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 2) {
        NSString * last3Chars = [textView.text substringFromIndex:textView.text.length - 3];
        if ([last3Chars isEqualToString:@",  "]) {
            textView.text = [textView.text substringToIndex:textView.text.length - 1];
        }
    }
    
    if ([textView.text length] >0) {
        
        if (self.lastTimeCharNum < [textView.text length]) {
            self.isUserDeletingChars = NO;
        } else {
            self.isUserDeletingChars = YES;
        }
        self.lastTimeCharNum = [textView.text length];
        
        NSString * lastCharacter = [textView.text substringFromIndex:textView.text.length - 1];
        DLog(@"last character = %@", lastCharacter);
        
        if ([textView.text isEqualToString:@" "]) {
            [textView setText:@""];
        }
        
        if ([lastCharacter isEqualToString:@"\n"] || [lastCharacter isEqualToString:@"\r"]) {
            DLog(@"return button pressed");
            textView.text = [textView.text substringToIndex:textView.text.length-1];
            [self sendButtonPressed];
        }
        
        NSString * last2Chars = @"";
        if ([textView.text length] > 1) {
            last2Chars = [textView.text substringFromIndex:textView.text.length - 2];
        }
        
        if([lastCharacter isEqualToString:@" "] && !self.isUserDeletingChars && ![last2Chars isEqualToString:@", "]) {
            textView.text = [textView.text substringToIndex:textView.text.length-1];
            textView.text = [textView.text stringByAppendingString:@", "];
        }
        
    } else {
        self.lastTimeCharNum = 0;
        self.isUserDeletingChars = NO;
    }
}

#pragma mark - emails view configurations

-(void) configureEmailTextView
{
    [self.emailTextView setFont:[UIFont fontWithName:OD_MAIN_FONT_NAME size:17.0]];
    [self.emailTextView setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.emailTextView setReturnKeyType:UIReturnKeySend];
    [self.emailTextView setEnablesReturnKeyAutomatically:YES];
    [self.emailTextView setDelegate:self];
    self.emailTextView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
    self.emailTextView.layer.borderWidth = 1.0;
    self.emailTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.emailTextView becomeFirstResponder];
}

-(void) configureTitleLabel:(UILabel *)titleLabel
{
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:NSLocalizedString(@"Type the email addresses", @"")];
    [titleLabel setTextColor:OD_ACTIVE_COLOR];
    [titleLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold", OD_MAIN_FONT_NAME] size:17.0]];

}

-(void) configureHeaderImageView:(UIImageView *)headerImgView
{
    [headerImgView setBackgroundColor:OD_NAVIGATION_BAR_COLOR];
    headerImgView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
    headerImgView.layer.borderWidth = 1.0;

}

-(void) configureCancelButton:(UIButton *)cancelButton
{
    [cancelButton setFrame:CGRectMake(60.0, 30.0, 100.0, 20.0)];
    [cancelButton setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [cancelButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    [cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [cancelButton setTag:kCancelButtonTag];
    [cancelButton addTarget:self action:@selector(cancelSendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) configureSendButton:(UIButton *)sendButton
{
    [sendButton setFrame:CGRectMake(self.appDelegate.mainFrameSize.width - 160.0, 30.0, 100.0, 20.0)];
    [sendButton setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
    [sendButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    [sendButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [sendButton setTag:kSendButtonTag];
    [sendButton addTarget:self action:@selector(cancelSendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

}
@end
