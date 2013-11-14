//
//  ODForgetPasswordViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODForgetPasswordViewController.h"
#import "ODConfig.h"
#import "ODColors.h"
#import "ODLoadingView.h"
#import "ODAppDelegate.h"
#import "ODValidator.h"

#define kLoadingViewTag 1000
@interface ODForgetPasswordViewController ()

@end

@implementation ODForgetPasswordViewController

@synthesize appDelegate, viewOfContents;
@synthesize userNameTextField, sendButton, userNameTextFieldErrorView, forgetPasswordTextLabel;

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
    
    // reference to application delegate shared file
    self.appDelegate = (ODAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setTitle:NSLocalizedString(@"Forget your password ?", @"")];
    
    [self initNamesAndTexts];
    
    // init loading view
    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [loadingView setTag:kLoadingViewTag];
    [self.view addSubview:loadingView];
    [loadingView setHidden:YES];
    
    // register hide keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

-(void) KeyboardWillHide:(NSNotification *)aNotification
{
    ALog(@"Keyboard will hide");
    [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 190.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
}

-(void) animateViewOfContentsToRect:(CGRect)newRect
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewOfContents setFrame:newRect];
    } completion:^(BOOL finished) {
        
    }];
}

-(void) setPlaceHolders
{
    [self.userNameTextField setPlaceholder:NSLocalizedString(@"Email address", @"")];
    [self.userNameTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.userNameTextFieldErrorView setHidden:YES];
}

-(void) initNamesAndTexts
{
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    [self setPlaceHolders];
    
    [self.forgetPasswordTextLabel setText:NSLocalizedString(@"Forget your password?\nPlease provide your email address", @"")];
    [self.sendButton setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
    
    // add text change event listener
    [self.userNameTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
}

-(IBAction) sendButtonPressed:(id)sender
{
    [self sendButtonClicked];
}

-(void) sendButtonClicked
{
    if ([self.userNameTextField.text isEqualToString:@""]) {
        [self.userNameTextFieldErrorView setHidden:NO];
        [self.userNameTextField setPlaceholder:NSLocalizedString(@"Please Fill email address", @"")];
        [self.userNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    } else {
        BOOL isEmailValid = [ODValidator isEmailAddressValid:self.userNameTextField.text];
        if (!isEmailValid) {
            [self.userNameTextFieldErrorView setHidden:NO];
            [self.userNameTextField setText:@""];
            [self.userNameTextField setPlaceholder:NSLocalizedString(@"Invalid email address", @"")];
            [self.userNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        } else {
            if ([self.userNameTextField isFirstResponder]) {
                [self.userNameTextField resignFirstResponder];
            }
                
            [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 190.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
                
            // login process starts here
            [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
                
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideLoginView) userInfo:Nil repeats:NO];
            
        }

    }
}

-(void) hideLoginView
{
    [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendButtonClicked];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 30.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
    
}

-(void) textFieldTextChange:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.userNameTextFieldErrorView setHidden:YES];
    }
    
    [self setPlaceHolders];
}


@end
