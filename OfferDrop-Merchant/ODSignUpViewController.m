//
//  ODSignUpViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODSignUpViewController.h"
#import "ODAppDelegate.h"
#import "ODConfig.h"
#import "ODColors.h"
#import "ODFonts.h"
#import "ODValidator.h"
#import "ODConstants.h"
#import "ODAppDelegate.h"
#import "ODLoadingView.h"


#define kContactNameTextFieldTag 0
#define kContactEmailTextFieldTag 1
#define kPasswordTextFieldTag 2
#define kRetypePasswordTextFieldTag 3
#define kBusinessNameTextFieldTag 4
#define kBusinessTypeTextFieldTag 5
#define kPhoneNumberTextFieldTag 6
#define kAddressTextFieldTag 7

#define kLoadingViewTag 1000

@interface ODSignUpViewController ()

@end

@implementation ODSignUpViewController

@synthesize facebookConnectButton, facebookConnectDescLabel, logoButton, appDelegate;
@synthesize contactEmailTextField, contactNameTextField;
@synthesize passwordtextField, retypePasswordTextField;
@synthesize businessNameTextField, businessTypeTextField;
@synthesize addressTextField, phoneNumberTextField;
@synthesize isAddressFieldThatHidesKeyboard;
@synthesize selectedTextFieldTag, merchantLogoImage;
@synthesize contactNameFieldErrorView, contactEmailFieldErrorView, passwordFieldErrorView, retypePasswordFieldErrorView;
@synthesize businessNameFieldErrorView, businessTypeFieldErrorView, phoneFieldErrorView, addressFieldErrorView, userLocationButton;
@synthesize isKeyBoardForceHide, popoverController;

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
    
    [self setTitle:NSLocalizedString(@"Create new free account", @"")];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Create account", "@") style:UIBarButtonItemStylePlain target:self action:@selector(createAccountButtonPressed:)];
    
    [self initNamesAndTexts];
    
    // init loading view
    ODLoadingView * loadingView = [[ODLoadingView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.appDelegate.mainFrameSize.width, self.appDelegate.mainFrameSize.height)];
    [loadingView setTag:kLoadingViewTag];
    [self.view addSubview:loadingView];
    [loadingView setHidden:YES];
    
    // register hide keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HandleNotifications:) name:kNotificationNameLoadUserInfoKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HandleNotifications:) name:kNotificationNameShowLoadingViewOnSignUpView object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HandleNotifications:) name:kNotificationNameLoadMerchantAddressOnSignUp object:nil];
    
}

-(void) HandleNotifications:(NSNotification *)aNotification
{
    if ([aNotification.name isEqualToString:kNotificationNameLoadUserInfoKey]) {
        DLog(@"user info = %@", aNotification.userInfo);
        
        [self.contactNameTextField setText:[aNotification.userInfo valueForKey:@"name"]];
        [self.contactEmailTextField setText:[aNotification.userInfo valueForKey:@"email"]];
        
        NSString * pictureURL = [FACEBOOK_ID_IMAGE stringByReplacingOccurrencesOfString:@"_FACEBOOK_ID_" withString:[aNotification.userInfo valueForKey:@"id"]];
        UIImage * merchantImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURL]]];
        
        self.merchantLogoImage = merchantImg;
        
        [self.logoButton setBackgroundImage:merchantImg forState:UIControlStateNormal];
        [self.logoButton setTitle:@"" forState:UIControlStateNormal];
        
        [self.facebookConnectButton setEnabled:NO];
        [self.passwordtextField becomeFirstResponder];
        
        [[self.view viewWithTag:kLoadingViewTag] setHidden:YES];
        self.isKeyBoardForceHide = NO;
        [self KeyboardDidHide:nil];
        
    } else if ([aNotification.name isEqualToString:kNotificationNameShowLoadingViewOnSignUpView]) {
        [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
        self.isKeyBoardForceHide = YES;
        [self dismissKeyboard];
        
    } else if ([aNotification.name isEqualToString:kNotificationNameLoadMerchantAddressOnSignUp]) {
        [self.addressTextField setText:aNotification.object];
        [self.addressTextField becomeFirstResponder];
        [[self.view viewWithTag:kLoadingViewTag] setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

-(void) KeyboardDidHide:(NSNotification *)aNotification
{
    ALog(@"Keyboard did hide");
    if (!self.isAddressFieldThatHidesKeyboard) {
        switch (self.selectedTextFieldTag) {
            case kContactNameTextFieldTag:
                [self.contactNameTextField becomeFirstResponder];
                break;
                
            case kContactEmailTextFieldTag:
                [self.contactEmailTextField becomeFirstResponder];
                break;
                
            case kPasswordTextFieldTag:
                [self.passwordtextField becomeFirstResponder];
                break;
                
            case kRetypePasswordTextFieldTag:
                [self.retypePasswordTextField becomeFirstResponder];
                break;
                
            case kBusinessNameTextFieldTag:
                [self.businessNameTextField becomeFirstResponder];
                break;
                
            case kBusinessTypeTextFieldTag:
                [self.businessTypeTextField becomeFirstResponder];
                break;
                
            case kPhoneNumberTextFieldTag:
                [self.phoneNumberTextField becomeFirstResponder];
                break;
                
            case kAddressTextFieldTag:
                [self.addressTextField becomeFirstResponder];
                break;
            
            default:
                break;
        }
    }
}

-(void) KeyboardWillHide:(NSNotification *)aNotification
{
    ALog(@"Keyboard will hide");
    
    if (self.isKeyBoardForceHide) {
        self.isAddressFieldThatHidesKeyboard = YES;
    } else {
        if ([self.addressTextField isFirstResponder]) {
            self.isAddressFieldThatHidesKeyboard = YES;
        } else {
            self.isAddressFieldThatHidesKeyboard = NO;
        }
    }
}

-(void) dismissKeyboard
{
    if ([self.contactNameTextField isFirstResponder]) {
        [self.contactNameTextField resignFirstResponder];
    } else if ([self.contactEmailTextField isFirstResponder]) {
        [self.contactEmailTextField resignFirstResponder];
    } else if ([self.passwordtextField isFirstResponder]) {
        [self.passwordtextField resignFirstResponder];
    } else if ([self.retypePasswordTextField isFirstResponder]) {
        [self.retypePasswordTextField resignFirstResponder];
    } else if ([self.businessNameTextField isFirstResponder]) {
        [self.businessNameTextField resignFirstResponder];
    } else if ([self.businessTypeTextField isFirstResponder]) {
        [self.businessTypeTextField resignFirstResponder];
    } else if ([self.phoneNumberTextField isFirstResponder]) {
        [self.phoneNumberTextField resignFirstResponder];
    } else {
        [self.addressTextField resignFirstResponder];
    }
}

-(void) createAccountButtonPressed:(id) sender
{
    ALog(@"Create account button pressed");
 
    BOOL isAllFieldsValid = YES;
    
    if ([self.contactNameTextField.text isEqualToString:@""]) {
        [self.contactNameFieldErrorView setHidden:NO];
        [self.contactNameTextField setPlaceholder:NSLocalizedString(@"Please fill contact name", @"")];
        [self.contactNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    }
    
    if ([self.contactEmailTextField.text isEqualToString:@""]) {
        [self.contactEmailFieldErrorView setHidden:NO];
        [self.contactEmailTextField setPlaceholder:NSLocalizedString(@"Please fill contact email", @"")];
        [self.contactEmailTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    } else {
        BOOL isEmailValid = [ODValidator isEmailAddressValid:self.contactEmailTextField.text];
        if (!isEmailValid) {
            [self.contactEmailFieldErrorView setHidden:NO];
            [self.contactEmailTextField setText:@""];
            [self.contactEmailTextField setPlaceholder:NSLocalizedString(@"Invalid email address", @"")];
            [self.contactEmailTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
            
            isAllFieldsValid = NO;
        }
    }
    
    if ([self.passwordtextField.text isEqualToString:@""]) {
        [self.passwordFieldErrorView setHidden:NO];
        [self.passwordtextField setPlaceholder:NSLocalizedString(@"Please fill password", @"")];
        [self.passwordtextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    }
    
    if ([self.retypePasswordTextField.text isEqualToString:@""]) {
        [self.retypePasswordFieldErrorView setHidden:NO];
        [self.retypePasswordTextField setPlaceholder:NSLocalizedString(@"Please fill password", @"")];
        [self.retypePasswordTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    } else {
        if (![self.passwordtextField.text isEqualToString:self.retypePasswordTextField.text]) {
            [self.retypePasswordFieldErrorView setHidden:NO];
            [self.retypePasswordTextField setText:@""];
            [self.retypePasswordTextField setPlaceholder:NSLocalizedString(@"Password mismatch", @"")];
            [self.retypePasswordTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
            
            isAllFieldsValid = NO;
        }
    }
    
    if ([self.businessNameTextField.text isEqualToString:@""]) {
        [self.businessNameFieldErrorView setHidden:NO];
        [self.businessNameTextField setPlaceholder:NSLocalizedString(@"Please fill business name", @"")];
        [self.businessNameTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    }
    
    if ([self.businessTypeTextField.text isEqualToString:@""]) {
        [self.businessTypeFieldErrorView setHidden:NO];
        [self.businessTypeTextField setPlaceholder:NSLocalizedString(@"Please fill business type", @"")];
        [self.businessTypeTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    }
    
    if ([self.phoneNumberTextField.text isEqualToString:@""]) {
        [self.phoneFieldErrorView setHidden:NO];
        [self.phoneNumberTextField setPlaceholder:NSLocalizedString(@"Please fill phone number", @"")];
        [self.phoneNumberTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    } else {
            BOOL isPhoneValid = [ODValidator isPhoneNumberValid:self.phoneNumberTextField.text];
            if (!isPhoneValid) {
                [self.phoneFieldErrorView setHidden:NO];
                [self.phoneNumberTextField setText:@""];
                [self.phoneNumberTextField setPlaceholder:NSLocalizedString(@"Invalid phone number", @"")];
                [self.phoneNumberTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
                
                isAllFieldsValid = NO;
            }
    }

    if ([self.addressTextField.text isEqualToString:@""] || [self.addressTextField.text isEqualToString:NSLocalizedString(@"Unknown address", @"")]) {
        [self.addressFieldErrorView setHidden:NO];
        [self.addressTextField setText:@""];
        [self.addressTextField setPlaceholder:NSLocalizedString(@"Please fill address", @"")];
        [self.addressTextField setValue:OD_ACTIVE_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        isAllFieldsValid = NO;
    }
    
    if (self.merchantLogoImage == nil) {
        // handle this error case
        if (isAllFieldsValid) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", @"") message:NSLocalizedString(@"Please add your logo", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", @"") otherButtonTitles:nil] show];
        }
        isAllFieldsValid = NO;
    }
    
    if (isAllFieldsValid) {
        [self createUserAccount];
    }
    
}

-(void) createUserAccount
{
    ALog(@"Create account ok");
    [self dismissKeyboard];
    
    [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideSignUpView) userInfo:Nil repeats:NO];
}

-(void) hideSignUpView
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * imgData = UIImagePNGRepresentation(self.merchantLogoImage);
    [userDefaults setObject:imgData forKey:MERCHANT_LOGO_KEY];
    [userDefaults setObject:self.self.contactNameTextField.text forKey:MERCHANT_NAME_KEY];
    
    [userDefaults setObject:self.contactEmailTextField.text forKey:LOGGED_IN_USER_EMAIL_KEY];
    [userDefaults setObject:self.passwordtextField.text forKey:LOGGED_IN_USER_PASSWORD_KEY];
    
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameLoadMerchantInfoInLeftMenu object:nil];
    
    [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setPlaceHolders
{
    [self.contactNameTextField setPlaceholder:NSLocalizedString(@"Contact name", @"")];
    [self.contactNameTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.contactNameFieldErrorView setHidden:YES];
    
    [self.contactEmailTextField setPlaceholder:NSLocalizedString(@"Email address", @"")];
    [self.contactEmailTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.contactEmailFieldErrorView setHidden:YES];
    
    [self.passwordtextField setPlaceholder:NSLocalizedString(@"Password", @"")];
    [self.passwordtextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordFieldErrorView setHidden:YES];
    
    [self.retypePasswordTextField setPlaceholder:NSLocalizedString(@"Re-type password", @"")];
    [self.retypePasswordTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.retypePasswordFieldErrorView setHidden:YES];
    
    [self.businessNameTextField setPlaceholder:NSLocalizedString(@"Business name", @"")];
    [self.businessNameTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.businessNameFieldErrorView setHidden:YES];
    
    [self.businessTypeTextField setPlaceholder:NSLocalizedString(@"Business type", @"")];
    [self.businessTypeTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.businessTypeFieldErrorView setHidden:YES];
    
    [self.phoneNumberTextField setPlaceholder:NSLocalizedString(@"Phone number", @"")];
    [self.phoneNumberTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneFieldErrorView setHidden:YES];
    
    [self.addressTextField setPlaceholder:NSLocalizedString(@"Address", @"")];
    [self.addressTextField setValue:OD_LIGHT_GRAY_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    [self.addressFieldErrorView setHidden:YES];
    
    
}

-(void) setTagsToTextFields
{
    [self.contactNameTextField setTag:kContactNameTextFieldTag];
    [self.contactEmailTextField setTag:kContactEmailTextFieldTag];
    [self.passwordtextField setTag:kPasswordTextFieldTag];
    [self.retypePasswordTextField setTag:kRetypePasswordTextFieldTag];
    [self.businessNameTextField setTag:kBusinessNameTextFieldTag];
    [self.businessTypeTextField setTag:kBusinessTypeTextFieldTag];
    [self.phoneNumberTextField setTag:kPhoneNumberTextFieldTag];
    [self.addressTextField setTag:kAddressTextFieldTag];
}

-(void) initNamesAndTexts
{
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    [self.facebookConnectDescLabel setText:NSLocalizedString(@"Connect with Facebook to get your information", @"")];
    [self.facebookConnectDescLabel setTextColor:OD_LIGHT_GRAY_COLOR];
    
    [self.facebookConnectButton setTitle:NSLocalizedString(@"Connect with Facebook", @"") forState:UIControlStateNormal];

    [self setTagsToTextFields];
    
    [self.logoButton setTitle:NSLocalizedString(@"Logo", @"") forState:UIControlStateNormal];
    [self.logoButton setTitleColor:OD_LIGHT_GRAY_COLOR forState:UIControlStateNormal];
    [self.logoButton.titleLabel setFont:[UIFont fontWithName:OD_MAIN_FONT_NAME size:15.0]];
    
    [self.contactNameTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contactEmailTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordtextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.retypePasswordTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.businessNameTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.businessTypeTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumberTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.addressTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self setPlaceHolders];
    [self.contactNameTextField becomeFirstResponder];
}

#pragma mark - Actions
-(IBAction)logoButtonPressed:(id)sender
{
    self.isKeyBoardForceHide = YES;
    [self dismissKeyboard];
    
    ALog(@"Logo button pressed");
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(openGalaryPickerView) userInfo:nil repeats:NO];
}

-(void) openGalaryPickerView
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    [self.popoverController presentPopoverFromRect:CGRectMake(0.0, 0.0, 100.0 , 80.0) inView:self.logoButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    //[self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(IBAction)facebookConnectButtonPressed:(id)sender
{
    ALog(@"Facebook connect button pressed");
    
    [self.appDelegate OpenFacebookSessionEnablingGUI:YES];
}

-(IBAction)locationButtonPressed:(id)sender
{
    ALog(@"location button pressed");
    if ([self.userLocationButton isSelected]) {
        [self.addressTextField setText:@""];
        [self.userLocationButton setBackgroundImage:[UIImage imageNamed:@"get_location_selected.png"] forState:UIControlStateNormal];
        [self.userLocationButton setSelected:NO];
    } else {
        [[self.view viewWithTag:kLoadingViewTag] setHidden:NO];
        [self.appDelegate InitLocationManager];
        [self.userLocationButton setBackgroundImage:[UIImage imageNamed:@"get_location_unselected.png"] forState:UIControlStateNormal];
        [self dismissKeyboard];
        [self.userLocationButton setSelected:YES];
    }
}

#pragma mark - textField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.contactNameTextField) {
        [self.contactEmailTextField becomeFirstResponder];
    } else if(textField == self.contactEmailTextField) {
        [self.passwordtextField becomeFirstResponder];
    } else if(textField == self.passwordtextField) {
        [self.retypePasswordTextField becomeFirstResponder];
    } else if(textField == self.retypePasswordTextField) {
        [self.businessNameTextField becomeFirstResponder];
    } else if(textField == self.businessNameTextField) {
        [self.businessTypeTextField becomeFirstResponder];
    } else if(textField == businessTypeTextField) {
        [self.phoneNumberTextField becomeFirstResponder];
    } else if(textField == phoneNumberTextField) {
        [self.addressTextField becomeFirstResponder];
    } else {
        [self createAccountButtonPressed:textField];
    }
    
    return YES;
}


-(void) textFieldTextChange:(UITextField *)textField
{
    [self setPlaceHolders];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    ALog(@"text field start editing");
    self.selectedTextFieldTag = textField.tag;
}


#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.popoverController dismissPopoverAnimated:YES];
    
    self.isKeyBoardForceHide = NO;
    [self KeyboardDidHide:nil];
        
    UIImage *chosenImage = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage * resizedImage = [ODValidator ResizeImage:chosenImage toSize:200];
    self.merchantLogoImage = resizedImage;
    [self.logoButton setBackgroundImage:resizedImage forState:UIControlStateNormal];
    [self.logoButton setTitle:@"" forState:UIControlStateNormal];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.popoverController dismissPopoverAnimated:YES];
    
    self.isKeyBoardForceHide = NO;
    [self KeyboardDidHide:nil];
    
}

@end
