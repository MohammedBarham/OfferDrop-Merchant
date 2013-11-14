//
//  ODSettingsViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODSettingsViewController.h"
#import "ODColors.h"
#import "ODBeaconBroadcastingView.h"
#import "ODFrames.h"
#import <QuartzCore/QuartzCore.h>
#import "ODValidator.h"
#import "ODAppDelegate.h"

#define kFirstColorTag 0
#define kSecondColorTag 1
#define kThirdColorTag 2
#define kFourthColorTag 3
#define kFifthColorTag 4
#define kSixthColorTag 5

#define kMajorCopyTag 10
#define kMajorSendTag 11
#define kMinorCopyTag 12
#define kMinorSendTag 13
#define kUUIDCopyTag 14
#define kUUIDSendTag 15



@interface ODSettingsViewController ()

@end

@implementation ODSettingsViewController

@synthesize majorIdLabel, majorIdValue, minorIdLabel, minorIdValue, UUIDLabel, UUIDValue;
@synthesize businessEditButton, businessLogoImage, businessLogoLabel, popoverController, appDelegate;
@synthesize firstColorButton, secondColorButton, thirdColorButton, fourthColorButton, fifthColorButton, sixthColorButton;
@synthesize majorIdCopyButton, majorIdSendButton, minorIdCopyButton, minorIdSendButton, UUIDCopyButton, UUIDSendButton;
@synthesize logoActivityIndicator;

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
    
    self.appDelegate = (ODAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    UIImageView * titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 83.0, 30.0)];
    [titleImgView setImage:[UIImage imageNamed:@"navigation_bar_title_view.png"]];
    [self.navigationItem setTitleView:titleImgView];
    
    ODBeaconBroadcastingView * transmitView = [[ODBeaconBroadcastingView alloc] initWithFrame:RIGHT_MENU_ITEM_TRANSMIT_VIEW_FRAME];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:transmitView];
    
    [self initTextsAndTitles];
}

-(void) initTextsAndTitles
{
    [self.majorIdLabel setText:NSLocalizedString(@"Major ID:", @"")];
    [self.majorIdValue setText:@"25565"];
    
    [self.minorIdLabel setText:NSLocalizedString(@"Minor ID:", @"")];
    [self.minorIdValue setText:@"11645"];
    
    [self.UUIDLabel setText:NSLocalizedString(@"UUID:", @"")];
    [self.UUIDValue setText:@"D1B024CB-A02D-4650-9C6A-BAEDA8A31F0E"];
    
    [self.businessLogoLabel setText:NSLocalizedString(@"Business Logo", @"")];
    [self.businessEditButton setTitle:NSLocalizedString(@"Edit", @"") forState:UIControlStateNormal];
    
    [self.chooseColorsTextView setText:NSLocalizedString(@"Spice it up and choose a background color to be displayed in OfferDrop iPhone app", @"")];
    [self.chooseColorsTextView setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    [self.majorIdCopyButton setTitle:NSLocalizedString(@"Copy", @"") forState:UIControlStateNormal];
    [self.majorIdSendButton setTitle:NSLocalizedString(@"Email", @"") forState:UIControlStateNormal];
    [self.minorIdCopyButton setTitle:NSLocalizedString(@"Copy", @"") forState:UIControlStateNormal];
    [self.minorIdSendButton setTitle:NSLocalizedString(@"Email", @"") forState:UIControlStateNormal];
    [self.UUIDCopyButton setTitle:NSLocalizedString(@"Copy", @"") forState:UIControlStateNormal];
    [self.UUIDSendButton setTitle:NSLocalizedString(@"Email", @"") forState:UIControlStateNormal];
    
    [self addBorderToButton:self.firstColorButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)editButtonClicked:(id)sender
{
    if(!self.logoActivityIndicator.isAnimating)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setDelegate:self];
        
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
        [self.popoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 100.0 , 80.0) inView:self.businessLogoImage permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(IBAction)copySendButtonClicked:(id)sender
{
    UIButton * clickedButton = (UIButton *)sender;
    UIPasteboard * pastBoard = [UIPasteboard generalPasteboard];
    
    switch (clickedButton.tag) {
        case kMajorCopyTag:
            DLog(@"Major copy button");
            [pastBoard setString:self.majorIdValue.text];
            break;
            
        case kMajorSendTag:
            DLog(@"Major send button");
            break;
            
        case kMinorCopyTag:
            DLog(@"minor copy button");
            [pastBoard setString:self.minorIdValue.text];
            break;
            
        case kMinorSendTag:
            DLog(@"monor send button");
            break;
            
        case kUUIDCopyTag:
            DLog(@"uuid copy button");
            [pastBoard setString:self.UUIDValue.text];
            break;
            
        case kUUIDSendTag:
            DLog(@"uuid send button");
            break;
            
        default:
            break;
    }
}

-(IBAction)colorButtonClicked:(id)sender
{
    UIButton * selectedButton = (UIButton *)sender;
    switch (selectedButton.tag) {
        case kFirstColorTag:
            [self addBorderToButton:self.firstColorButton];
            [self removeBorderFromButton:self.secondColorButton];
            [self removeBorderFromButton:self.thirdColorButton];
            [self removeBorderFromButton: self.fourthColorButton];
            [self removeBorderFromButton:self.fifthColorButton];
            [self removeBorderFromButton:self.sixthColorButton];
            break;
            
        case kSecondColorTag:
            [self addBorderToButton:self.secondColorButton];
            [self removeBorderFromButton:self.firstColorButton];
            [self removeBorderFromButton:self.thirdColorButton];
            [self removeBorderFromButton: self.fourthColorButton];
            [self removeBorderFromButton:self.fifthColorButton];
            [self removeBorderFromButton:self.sixthColorButton];
            break;
            
        case kThirdColorTag:
            [self addBorderToButton:self.thirdColorButton];
            [self removeBorderFromButton:self.firstColorButton];
            [self removeBorderFromButton:self.secondColorButton];
            [self removeBorderFromButton: self.fourthColorButton];
            [self removeBorderFromButton:self.fifthColorButton];
            [self removeBorderFromButton:self.sixthColorButton];
            break;

        case kFourthColorTag:
            [self addBorderToButton:self.fourthColorButton];
            [self removeBorderFromButton: self.firstColorButton];
            [self removeBorderFromButton:self.secondColorButton];
            [self removeBorderFromButton:self.thirdColorButton];
            [self removeBorderFromButton:self.fifthColorButton];
            [self removeBorderFromButton:self.sixthColorButton];
            break;
            
        case kFifthColorTag:
            [self addBorderToButton:self.fifthColorButton];
            [self removeBorderFromButton: self.firstColorButton];
            [self removeBorderFromButton:self.secondColorButton];
            [self removeBorderFromButton:self.thirdColorButton];
            [self removeBorderFromButton:self.fourthColorButton];
            [self removeBorderFromButton:self.sixthColorButton];
            break;
            
        case kSixthColorTag:
            [self addBorderToButton:self.sixthColorButton];
            [self removeBorderFromButton: self.firstColorButton];
            [self removeBorderFromButton:self.secondColorButton];
            [self removeBorderFromButton:self.thirdColorButton];
            [self removeBorderFromButton:self.fourthColorButton];
            [self removeBorderFromButton:self.fifthColorButton];
            break;
        
        default:
            break;
    }
}

-(void) addBorderToButton:(UIButton *)button
{
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 4.0;
}

-(void) removeBorderFromButton:(UIButton *)button
{
    button.layer.borderWidth = 0.0;
    button.layer.borderColor = [UIColor clearColor].CGColor;
}

-(void) finishUploadingProcess
{
    [self.logoActivityIndicator stopAnimating];
    [self.businessEditButton setTitle:NSLocalizedString(@"Edit", "") forState:UIControlStateNormal];
    [self.businessEditButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
}

#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.popoverController dismissPopoverAnimated:YES];
    
    UIImage *chosenImage = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage * resizedImage = [ODValidator ResizeImage:chosenImage toSize:200];
    [self.businessLogoImage setBackgroundImage:resizedImage forState:UIControlStateNormal];
    [self.logoActivityIndicator startAnimating];
    [self.businessEditButton setTitle:NSLocalizedString(@"Uploading", @"") forState:UIControlStateNormal];
    [self.businessEditButton setTitleColor:OD_LIGHT_GRAY_COLOR forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(finishUploadingProcess) userInfo:Nil repeats:NO];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.popoverController dismissPopoverAnimated:YES];
}


@end
