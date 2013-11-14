//
//  ODLeftMenuViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODLeftMenuViewController.h"
#import "ODConfig.h"
#import "JASidePanelController.h"
#import "ODColors.h"
#import "ODNavigationController.h"
#import "ODConstants.h"
#import "ODAppDelegate.h"

#import "ODCreateOfferViewController.h"
#import "ODWelcomeNotificationViewController.h"
#import "ODAllOffersViewController.h"
#import "ODActiveOffersViewController.h"
#import "ODSettingsViewController.h"
#import "ODPromoteViewController.h"


#define kLeftMenuWelcomeButtonTag 10
#define kLeftMenuCreateOfferButtonTag 20
#define kLeftMenuActiveOffersButtonTag 30
#define kLeftMenuOffersStatsButtonTag 40
#define kLeftMenuPromoteButtonTag 50
#define kLeftMenuSettingsButtonTag 60

@interface ODLeftMenuViewController ()

@end

@implementation ODLeftMenuViewController

@synthesize merchantLogoImgView, welcomeNotificationButton, createOfferButton;
@synthesize offerStatsButton, activeOffersButton, settingsButton, selectedButtonTag, merchantNameLabel, promoteButton;

-(IBAction)Logout:(id)sender
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:LOGGED_IN_USER_EMAIL_KEY];
    [userDefaults setObject:nil forKey:LOGGED_IN_USER_PASSWORD_KEY];
    [userDefaults setObject:nil forKey:MERCHANT_WELCOME_MESSAGE_KEY];
    [userDefaults setObject:nil forKey:MERCHANT_NAME_KEY];
    [userDefaults setObject:nil forKey:MERCHANT_LOGO_KEY];
    [userDefaults synchronize];

    UIButton * defaultBtn = [[UIButton alloc] init];
    [defaultBtn setTag:kLeftMenuWelcomeButtonTag];
    [self menuButtonClicked:defaultBtn];
    
    [self.appDelegate ShowLoginView];
}

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
    
    [self.welcomeNotificationButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"Welcome Notification", @"")] forState:UIControlStateNormal];
    [self.welcomeNotificationButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.welcomeNotificationButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.welcomeNotificationButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    [self.createOfferButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"Create Offers", @"")] forState:UIControlStateNormal];
    [self.createOfferButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.createOfferButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.createOfferButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    [self.activeOffersButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"Active Offers", @"")] forState:UIControlStateNormal];
    [self.activeOffersButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.activeOffersButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.activeOffersButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    [self.offerStatsButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"All Offers", @"")] forState:UIControlStateNormal];
    [self.offerStatsButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.offerStatsButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.offerStatsButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    [self.promoteButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"Promote OfferDrop App", @"")] forState:UIControlStateNormal];
    [self.promoteButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.promoteButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.promoteButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    [self.settingsButton setTitle:[NSString stringWithFormat:@"         %@", NSLocalizedString(@"Settings", @"")] forState:UIControlStateNormal];
    [self.settingsButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateSelected];
    [self.settingsButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateHighlighted];
    [self.settingsButton setTitleColor:OD_DARK_GREY_COLOR forState:UIControlStateNormal];
    
    
    self.selectedButtonTag = kLeftMenuWelcomeButtonTag;
    [self EnableButtonWithTag:self.selectedButtonTag];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HandleNotifications:) name:kNotificationNameLoadMerchantInfoInLeftMenu object:nil];
    
    [self AddUserNameAndLogoOnLeftMenu];
}

-(void) HandleNotifications:(NSNotification *) aNotification
{
    if ([aNotification.name isEqualToString:kNotificationNameLoadMerchantInfoInLeftMenu]) {
        [self AddUserNameAndLogoOnLeftMenu];
        
    }
}

-(void) AddUserNameAndLogoOnLeftMenu
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:MERCHANT_NAME_KEY] != nil && [userDefaults objectForKey:MERCHANT_LOGO_KEY] != nil) {
        [self.merchantNameLabel setText:[userDefaults objectForKey:MERCHANT_NAME_KEY]];
        [self.merchantLogoImgView setImage:[UIImage imageWithData:[userDefaults objectForKey:MERCHANT_LOGO_KEY]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) menuButtonClicked:(id)sender
{
    UIButton * selectedButton = (UIButton *)sender;
    DLog(@" button tag = %d", selectedButton.tag);
    
    JASidePanelController * parent = (JASidePanelController *)self.parentViewController;
    if (selectedButton.tag != self.selectedButtonTag) {
        
        self.selectedButtonTag = selectedButton.tag;
        
        switch (selectedButton.tag) {
            case kLeftMenuWelcomeButtonTag: {
                
                ODWelcomeNotificationViewController * welcomeView = [[ODWelcomeNotificationViewController alloc] initWithNibName:@"ODWelcomeNotificationViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:welcomeView];
                parent.centerPanel = navController;
                
            }
            break;
                
            case kLeftMenuCreateOfferButtonTag: {
                ODCreateOfferViewController * createOfferView = [[ODCreateOfferViewController alloc] initWithNibName:@"ODCreateOfferViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:createOfferView];
                parent.centerPanel = navController;
            }
            break;
                
            case kLeftMenuActiveOffersButtonTag: {
                ODActiveOffersViewController * activeOffersView = [[ODActiveOffersViewController alloc] initWithNibName:@"ODActiveOffersViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:activeOffersView];
                parent.centerPanel = navController;
            }
            break;
            
            case kLeftMenuOffersStatsButtonTag: {
                ODAllOffersViewController * allOfferView = [[ODAllOffersViewController alloc] initWithNibName:@"ODAllOffersViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:allOfferView];
                parent.centerPanel = navController;
            }
            break;
                
            case kLeftMenuPromoteButtonTag: {
                ODPromoteViewController * promoteView = [[ODPromoteViewController alloc] initWithNibName:@"ODPromoteViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:promoteView];
                parent.centerPanel = navController;
            }
            break;
                
            case kLeftMenuSettingsButtonTag: {
                ODSettingsViewController * settingsView = [[ODSettingsViewController alloc] initWithNibName:@"ODSettingsViewController" bundle:nil];
                ODNavigationController * navController = [[ODNavigationController alloc] initWithRootViewController:settingsView];
                parent.centerPanel = navController;
            }
            break;
                
                default:
                break;
        }
        
        [self EnableButtonWithTag:selectedButton.tag];
    }
    else
    {
        [parent toggleLeftPanel:self];
    }
}

-(void) EnableButtonWithTag:(NSInteger)buttonTag
{
    if (self.welcomeNotificationButton.tag == buttonTag) {
        [self.welcomeNotificationButton setSelected:YES];
    } else {
        [self.welcomeNotificationButton setSelected:NO];
    }
    
    if (self.createOfferButton.tag == buttonTag) {
        [self.createOfferButton setSelected:YES];
    } else {
        [self.createOfferButton setSelected:NO];
    }
    
    if (self.activeOffersButton.tag == buttonTag) {
        [self.activeOffersButton setSelected:YES];
    } else {
        [self.activeOffersButton setSelected:NO];
    }
    
    if (self.offerStatsButton.tag == buttonTag) {
        [self.offerStatsButton setSelected:YES];
    } else {
        [self.offerStatsButton setSelected:NO];
    }
    
    if (self.settingsButton.tag == buttonTag) {
        [self.settingsButton setSelected:YES];
    } else {
        [self.settingsButton setSelected:NO];
    }
    
    if (self.promoteButton.tag == buttonTag) {
        [self.promoteButton setSelected:YES];
    } else {
        [self.promoteButton setSelected:NO];
    }
}

@end
