//
//  ODCreateOfferViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODCreateOfferViewController.h"
#import "ODColors.h"
#import "ODBeaconBroadcastingView.h"
#import "ODFrames.h"
#import "ODConfig.h"
#import "ODLoadingView.h"
#import "ODAppDelegate.h"
#import "ODValidator.h"

#define kLoadingViewTag 1000

#define kPhotoSourceCamera 0
#define kPhotoSourceGalary 1

#define kMaxOfferTitleLength 90

@interface ODCreateOfferViewController ()

@end

@implementation ODCreateOfferViewController

@synthesize createOfferTextView, offerImageButton, createOfferButton, appDelegate, popoverController;
@synthesize offerImage, counterLabel, previewButton;

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
    
    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [loadingView setTag:kLoadingViewTag];
    [self.view addSubview:loadingView];
    [loadingView setHidden:YES];
    
    [self IntiTitlesAndTexts];
}

-(void) IntiTitlesAndTexts
{
    [self.createOfferTextView setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    [self.createOfferTextView setTextColor:OD_LIGHT_GRAY_COLOR];
    [self.createOfferTextView setText:NSLocalizedString(@"Type the Offer title", @"")];

    [self.createOfferButton setTitle:NSLocalizedString(@"Create Offer", @"") forState:UIControlStateNormal];
    [self.createOfferButton setHidden:YES];
    
    [self.previewButton setTitle:NSLocalizedString(@"Preview", @"") forState:UIControlStateNormal];
    [self.previewButton addTarget:self action:@selector(previewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.previewButton setHidden:YES];
    
    [self.offerImageButton.titleLabel setNumberOfLines:2];
    [self.offerImageButton setTitle:NSLocalizedString(@"Offer \nPhoto", @"") forState:UIControlStateNormal];
    
    [self.counterLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) previewButtonPressed
{
    DLog(@"preview button pressed");
}

-(IBAction)createOfferClicked:(id)sender
{
    BOOL allFieldsValid = YES;
    
    if ([self.createOfferTextView.text isEqualToString:@""]) {
        [self.createOfferTextView setText:NSLocalizedString(@"Please fill this field", @"")];
        [self.createOfferTextView setTextColor:OD_ACTIVE_COLOR];
        
        allFieldsValid = NO;
    }
    
    if (self.offerImage == nil) {
        
        if (allFieldsValid) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", @"") message:NSLocalizedString(@"Please add your photo", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] show];
        }
        allFieldsValid = NO;
    }
    
    if (allFieldsValid) {
        [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
        
        [self.createOfferTextView resignFirstResponder];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideLoadingView) userInfo:nil repeats:NO];

    }
}

-(IBAction)logoButtonClicked:(id)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                              delegate: self
                                                     cancelButtonTitle: nil
                                                destructiveButtonTitle: nil
                                                     otherButtonTitles: NSLocalizedString( @"Take Photo", @""), NSLocalizedString(@"Choose Existing Photo", @""), nil];
    
    
    [actionSheet showFromRect: self.offerImageButton.frame inView: self.offerImageButton.superview animated: YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"action sheet index = %d", buttonIndex);
    self.photoSourceType = buttonIndex;
    switch (buttonIndex) {
        case kPhotoSourceCamera:
            [self openCamera];
            break;
            
        case kPhotoSourceGalary:
            [self openGalaryPickerView];
            break;
            
        default:
            break;
    }
}

-(void) openGalaryPickerView
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    [self.popoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 100.0 , 80.0) inView:self.offerImageButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void) openCamera
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [picker setDelegate:self];
    
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void) hideLoadingView
{
    [[self.view viewWithTag:kLoadingViewTag] setHidden:YES];
    [self.createOfferTextView setTextColor:OD_LIGHT_GRAY_COLOR];
    [self.createOfferTextView setText:NSLocalizedString(@"Type the Offer title", @"")];
    
    [self.offerImageButton setTitle:NSLocalizedString(@"Offer \nPhoto", @"") forState:UIControlStateNormal];
    
    [self.offerImageButton setBackgroundImage:[UIImage imageNamed:@"empty_logo.png"] forState:UIControlStateNormal];
    [self.createOfferButton setHidden:YES];
    [self.previewButton setHidden:YES];
    self.offerImage = nil;
    
    [self.counterLabel setHidden:YES];
}

#pragma mark - TextView Delegate
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
        
        if ([textView.text length] > kMaxOfferTitleLength) {
            textView.text = [textView.text substringToIndex:kMaxOfferTitleLength];
        }
        
        NSString * lastCharacter = [textView.text substringFromIndex:textView.text.length -1];
        DLog(@"last character = %@", lastCharacter);
        
        if ([textView.text isEqualToString:@" "]) {
            [textView setText:@""];
        }
        
        [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxOfferTitleLength - [textView.text length]]];
        
        if ([lastCharacter isEqualToString:@"\n"] || [lastCharacter isEqualToString:@"\r"]) {
            DLog(@"return button pressed");
            textView.text = [textView.text substringToIndex:textView.text.length-1];
            [self createOfferClicked:nil];
        }
        
        if ([textView.text length] > 0) {
            [self.createOfferButton setHidden:NO];
            [self.previewButton setHidden:NO];
            
        }
    } else {
        [self.createOfferButton setHidden:YES];
        [self.previewButton setHidden:YES];
        [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxOfferTitleLength]];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:NSLocalizedString(@"Type the Offer title", @"")]) {
        textView.text = @"";
    }
    
    [self.counterLabel setHidden:NO];
    [self.counterLabel setText:[NSString stringWithFormat:@"%d", kMaxOfferTitleLength - [textView.text length]]];
    [textView setTextColor:OD_VERY_DARK_GRAY_COLOR];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        [textView setTextColor:OD_LIGHT_GRAY_COLOR];
        [textView setText:NSLocalizedString(@"Type the Offer title", @"")];
        
        [self.counterLabel setHidden:YES];
    }
}

#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.photoSourceType == kPhotoSourceCamera) {
        [self dismissViewControllerAnimated:YES completion:^{
            UIImage *chosenImage = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
            UIImage * resizedImage = [ODValidator ResizeImage:chosenImage toSize:200];
            self.offerImage = resizedImage;
            [self.offerImageButton setBackgroundImage:resizedImage forState:UIControlStateNormal];
            [self.offerImageButton setTitle:@"" forState:UIControlStateNormal];
        }];
    } else {
        [self.popoverController dismissPopoverAnimated:YES];
        
        UIImage *chosenImage = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * resizedImage = [ODValidator ResizeImage:chosenImage toSize:200];
        self.offerImage = resizedImage;
        [self.offerImageButton setBackgroundImage:resizedImage forState:UIControlStateNormal];
        [self.offerImageButton setTitle:@"" forState:UIControlStateNormal];
    }
    

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.photoSourceType == kPhotoSourceCamera) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}
@end
