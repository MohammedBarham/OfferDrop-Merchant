//
//  ODLoginViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODLoginViewController.h"
#import "ODAppDelegate.h"
#import "ODConfig.h"
#import "ODColors.h"
#import "ODConstants.h"
#import "ODLoadingView.h"
#import "ODForgetPasswordViewController.h"
#import "ODSignUpViewController.h"
#import "ODValidator.h"

#define kLoginButtonTag 0
#define kSignupButtonTag 1
#define kForgetPasswordButtonTag 2

#define kLoadingViewTag 1000

@interface ODLoginViewController ()

@end

@implementation ODLoginViewController
@synthesize appDelegate, viewOfContents;
@synthesize userNameTextField, passwordTextField;
@synthesize signInButton, signupButton, forgetPasswordButton;
@synthesize userNameTextFieldErrorView, passwordTextFieldErrorView;

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
    
    [self setTitle:NSLocalizedString(@"Log in", @"")];
    [self initLabelsAndTexts];
    
    
    // init loading view
    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [loadingView setTag:kLoadingViewTag];
    [self.view addSubview:loadingView];
    [loadingView setHidden:YES];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:LOGGED_IN_USER_EMAIL_KEY] != nil && [userDefaults objectForKey:LOGGED_IN_USER_PASSWORD_KEY ] != nil) {
        [self.userNameTextField setText:[userDefaults objectForKey:LOGGED_IN_USER_EMAIL_KEY]];
        [self.passwordTextField setText:[userDefaults objectForKey:LOGGED_IN_USER_PASSWORD_KEY]];
        
        [self loginButtonPressed];
        
        //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(loginButtonPressed) userInfo:nil repeats:NO];
    };
    
    // register hide keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions methods

-(IBAction) loginViewButtonPressed:(id)sender
{
    UIButton * clickedButton = (UIButton *)sender;
    ALog(@"Login in button clicked tag = %d", clickedButton.tag);
    
    switch (clickedButton.tag) {
        case kLoginButtonTag:
            [self loginButtonPressed];
            break;
            
        case kSignupButtonTag:
            [self signupButtonPressed];
            break;
            
        case kForgetPasswordButtonTag:
            [self forgetPasswordButtonPressed];
            break;
            
        default:
            break;
    }
}

-(void) loginButtonPressed
{
    ALog(@"Login button pressed");
    
    if ([self.userNameTextField.text isEqualToString:@""]) {
        [self.userNameTextFieldErrorView setHidden:NO];
        [self.userNameTextField setPlaceholder:NSLocalizedString(@"Please Fill email address", @"")];
        [self.userNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [self.passwordTextFieldErrorView setHidden:NO];
        [self.passwordTextField setPlaceholder:NSLocalizedString(@"Please fill password", @"")];
        [self.passwordTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    BOOL isEmailValid = [ODValidator isEmailAddressValid:self.userNameTextField.text];
    if (!isEmailValid) {
        [self.userNameTextField setHidden:NO];
        [self.userNameTextField setText:@""];
        [self.userNameTextField setPlaceholder:NSLocalizedString(@"Invalid email address", @"")];
        [self.userNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    } else {
        
        if (isEmailValid && ![self.passwordTextField.text isEqualToString:@""]) {
            
            [self resignKeyboardResponders];
            
            [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 190.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
            
            // login process starts here
            [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideLoginView) userInfo:Nil repeats:NO];
        }
        
    }
    
}

-(void) signupButtonPressed
{
    [self resignKeyboardResponders];
    
    ALog(@"Sign up button pressed");
    
    ODSignUpViewController * signupViewController = [[ODSignUpViewController alloc] initWithNibName:@"ODSignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

-(void) forgetPasswordButtonPressed
{
    [self resignKeyboardResponders];
    
    ALog(@"Forget password button pressed");
    
    ODForgetPasswordViewController * forgetPasswordViewController = [[ODForgetPasswordViewController alloc] initWithNibName:@"ODForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}


#pragma mark - Custom methods

-(void) resignKeyboardResponders
{
    if ([self.userNameTextField isFirstResponder]) {
        [self.userNameTextField resignFirstResponder];
    } else if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
    }
}

-(void) KeyboardWillHide:(NSNotification *)aNotification
{
    ALog(@"Keyboard will hide");
    [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 190.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
}

-(void) initLabelsAndTexts
{
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    // set labels and buttons texts and titles
    [self setPlaceHolders];
    
    [self.signupButton setTitle:NSLocalizedString(@"Create new free account", @"") forState:UIControlStateNormal];
    [self.forgetPasswordButton setTitle:NSLocalizedString(@"Forget password", @"") forState:UIControlStateNormal];
    [self.signInButton setTitle:NSLocalizedString(@"Sign In", @"") forState:UIControlStateNormal];
    
    // assign tags to buttons
    [self.signInButton setTag:kLoginButtonTag];
    [self.signupButton setTag:kSignupButtonTag];
    [self.forgetPasswordButton setTag:kForgetPasswordButtonTag];
    
    // hide error views from text fields
    [self.userNameTextFieldErrorView setHidden:YES];
    [self.passwordTextFieldErrorView setHidden:YES];
    
    // add text change event listener
    [self.userNameTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void) setPlaceHolders
{
    [self.userNameTextField setPlaceholder:NSLocalizedString(@"Email address", @"")];
    [self.passwordTextField setPlaceholder:NSLocalizedString(@"Password", @"")];
    [self.userNameTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
}

-(void) hideLoginView
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.userNameTextField.text forKey:LOGGED_IN_USER_EMAIL_KEY];
    [userDefaults setObject:self.passwordTextField.text forKey:LOGGED_IN_USER_PASSWORD_KEY];
    [userDefaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) textFieldTextChange:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.userNameTextFieldErrorView setHidden:YES];
    } else if(textField == self.passwordTextField) {
        [self.passwordTextFieldErrorView setHidden:YES];
    }
    
    [self setPlaceHolders];
}

#pragma mark - textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
        [self loginButtonPressed];
    }
    
    
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateViewOfContentsToRect:CGRectMake(self.viewOfContents.frame.origin.x, 30.0, self.viewOfContents.frame.size.width, self.viewOfContents.frame.size.height)];
    
}

-(void) animateViewOfContentsToRect:(CGRect)newRect
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.viewOfContents setFrame:newRect];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        DLog(@"device is portrait");
    } else {
        DLog(@"device is landscape");
    }
}

@end
