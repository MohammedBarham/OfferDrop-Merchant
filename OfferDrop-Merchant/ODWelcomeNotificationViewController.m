
//
//  ODWelcomeNotificationViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODWelcomeNotificationViewController.h"
#import "ODColors.h"
#import "ODBeaconBroadcastingView.h"
#import "ODFrames.h"
#import "ODFonts.h"
#import "ODColors.h"
#import "ODConfig.h"
#import "ODLoadingView.h"
#import "ODAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ODConstants.h"

#define kActiveButtonTag 0
#define kInactiveButtonTag 1
#define kLoadingViewTag 1000

#define kMaxWelcomeMessageLength 128

@interface ODWelcomeNotificationViewController ()

@end

@implementation ODWelcomeNotificationViewController

@synthesize welcomeNotText, welcomeNotificationNoteLabel, doneButton;
@synthesize appDelegate, welcomeNotBackgrounfImgView;
@synthesize activeSwitch, activeLabel, counterLabel, previewButton;
@synthesize numberOfPeopleViewingWelcomeLabel, numberOfViewersSeparatorImgView, blockView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) initTextsAndTitles
{
    // init note label text and properties
    [self.welcomeNotificationNoteLabel setFont:[UIFont fontWithName:OD_MAIN_FONT_NAME size:13.0]];
    [self.welcomeNotificationNoteLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
    [self.welcomeNotificationNoteLabel setText:NSLocalizedString(@"This welcome message will appear on your visitor's iPhones once they enter your store.", @"")];
    
    [self.welcomeNotText setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    [self.welcomeNotText setTextColor:OD_LIGHT_GRAY_COLOR];
    [self.welcomeNotText setText:NSLocalizedString(@"Type your welcome notification message", @"")];
    
    [self.doneButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    [self.doneButton setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton setHidden:YES];
    
    [self.previewButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    [self.previewButton setTitle:NSLocalizedString(@"Preview", @"") forState:UIControlStateNormal];
    [self.previewButton addTarget:self action:@selector(previewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.previewButton setHidden:YES];
    
    
    [self.activeLabel setText:NSLocalizedString(@"Active", @"")];
    [self.activeLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
    [self.activeSwitch addTarget:self action:@selector(activeSwitchValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.activeLabel setHidden:YES];
    [self.activeSwitch setHidden:YES];
    
    [self.numberOfViewersSeparatorImgView setHidden:YES];
    [self.counterLabel setHidden:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    self.appDelegate = (ODAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView * titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 83.0, 30.0)];
    [titleImgView setImage:[UIImage imageNamed:@"navigation_bar_title_view.png"]];
    [self.navigationItem setTitleView:titleImgView];
    
    ODBeaconBroadcastingView * transmitView = [[ODBeaconBroadcastingView alloc] initWithFrame:RIGHT_MENU_ITEM_TRANSMIT_VIEW_FRAME];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:transmitView];
    
    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [loadingView setTag:kLoadingViewTag];
    [self.view addSubview:loadingView];
    [loadingView setHidden:YES];
    
    [self initTextsAndTitles];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:MERCHANT_WELCOME_MESSAGE_KEY] != nil) {
        if (![[userDefaults objectForKey:MERCHANT_WELCOME_MESSAGE_KEY] isEqualToString:@""]) {
            [self.welcomeNotText setText:[userDefaults objectForKey:MERCHANT_WELCOME_MESSAGE_KEY]];
            [self welcomeNotificationSaved];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods
-(void) doneButtonPressed
{
    DLog(@"Done button pressed");
 
    if (self.isViewInEditMode) {
        [self.welcomeNotBackgrounfImgView setImage:[UIImage imageNamed:@"welcone_notification_text_bg.png"]];
        [self.welcomeNotBackgrounfImgView setBackgroundColor:[UIColor clearColor]];
        [self.welcomeNotText setEditable:YES];
        
        [self.doneButton setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
        self.welcomeNotBackgrounfImgView.layer.borderWidth = 0;
        self.welcomeNotBackgrounfImgView.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self.welcomeNotText setTextColor:OD_VERY_DARK_GRAY_COLOR];
        
        [self.activeLabel setHidden:YES];
        [self.activeSwitch setHidden:YES];
        
        [self.numberOfViewersSeparatorImgView setHidden:YES];
        [self.numberOfPeopleViewingWelcomeLabel setHidden:YES];
        
        [self.counterLabel setHidden:NO];
        self.isViewInEditMode = NO;
        
        [self.welcomeNotText becomeFirstResponder];
        
    } else {
        [self.welcomeNotText resignFirstResponder];
        [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
        [self.welcomeNotificationNoteLabel setHidden:NO];
        [self.counterLabel setHidden:YES];
    
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(welcomeNotificationSaved) userInfo:Nil repeats:NO];
    
        [[NSUserDefaults standardUserDefaults] setObject:self.welcomeNotText.text forKey:MERCHANT_WELCOME_MESSAGE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void) previewButtonPressed
{
    DLog(@"preview button pressed");
    self.blockView = [[UIView alloc] initWithFrame:CGRectMake(0.0, -20.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [self.blockView setBackgroundColor:OD_BLOCK_VIEW_BACKGROUND_COLOR];
    
    [self.navigationController.navigationBar addSubview:self.blockView];
}

-(void) welcomeNotificationSaved
{
    [[self.view viewWithTag:kLoadingViewTag] setHidden:YES];
    [self.welcomeNotBackgrounfImgView setImage:nil];
    [self.doneButton setHidden:NO];
    [self.previewButton setHidden:YES];
    [self.doneButton setTitle:NSLocalizedString(@"Edit", @"") forState:UIControlStateNormal];
    
    [self.welcomeNotText setTextColor:OD_VERY_DARK_GRAY_COLOR];
    [self.welcomeNotText setEditable:NO];
    
    [self.welcomeNotBackgrounfImgView setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    self.welcomeNotBackgrounfImgView.layer.borderWidth = 2.0;
    self.welcomeNotBackgrounfImgView.layer.borderColor = OD_WELCOME_MESSAGE_BORDER_COLOR.CGColor;
    
    [self.activeLabel setHidden:NO];
    [self.activeSwitch setHidden:NO];
    
    [self.counterLabel setHidden:YES];
    
    [self.numberOfViewersSeparatorImgView setHidden:NO];
    
    [self.numberOfPeopleViewingWelcomeLabel setText:[NSString stringWithFormat:@"%@ %d",NSLocalizedString(@"People viewing your welcome message ", @""), 5]];
    [self.numberOfViewersSeparatorImgView setHidden:NO];
    [self.numberOfPeopleViewingWelcomeLabel setHidden:NO];

    self.isViewInEditMode = YES;
}


-(void) activeSwitchValueChanged
{
    DLog(@"switch value = %d", self.activeSwitch.isOn);
    if (self.activeSwitch.isOn) {
        [self.activeLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
    } else {
        [self.activeLabel setTextColor:OD_LIGHT_GRAY_COLOR];
    }
}

#pragma mark - UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 2) {
        NSString * lastChars = [textView.text substringFromIndex:textView.text.length - 2];
        
        if ([lastChars isEqualToString:@"  "]) {
            DLog(@"last 2 characters are spaces");
            [textView setText:[textView.text substringToIndex:textView.text.length - 1]];
        }
    }
    
    if ([textView.text length] > 0) {
        
        if ([textView.text length] > kMaxWelcomeMessageLength) {
            textView.text = [textView.text substringToIndex:kMaxWelcomeMessageLength];
        }
        
        NSString * lastCharacter = [textView.text substringFromIndex:textView.text.length -1];
        DLog(@"last character = %@", lastCharacter);
        
        if ([textView.text isEqualToString:@" "]) {
            [textView setText:@""];
        }
        
        [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxWelcomeMessageLength - [textView.text length]]];
        
        if ([lastCharacter isEqualToString:@"\n"] || [lastCharacter isEqualToString:@"\r"]) {
            DLog(@"return button pressed");
            textView.text = [textView.text substringToIndex:textView.text.length-1];
            [self doneButtonPressed];
        }
        
        if ([textView.text length] > 0) {
            [self.doneButton setHidden:NO];
            [self.previewButton setHidden:NO];
        }
    } else {
        [self.doneButton setHidden:YES];
        [self.previewButton setHidden:YES];
        [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxWelcomeMessageLength]];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:NSLocalizedString(@"Type your welcome notification message", @"")]) {
        textView.text = @"";
    }
    
    [self.counterLabel setHidden:NO];
    
    if ([textView.text length] >0) {
        [self.previewButton setHidden:NO];
    }
    
    [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxWelcomeMessageLength - [textView.text length]]];
    [textView setTextColor:OD_VERY_DARK_GRAY_COLOR];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        [textView setTextColor:OD_LIGHT_GRAY_COLOR];
        [textView setText:NSLocalizedString(@"Type your welcome notification message", @"")];
        
        [self.counterLabel setHidden:YES];
    }
}


@end