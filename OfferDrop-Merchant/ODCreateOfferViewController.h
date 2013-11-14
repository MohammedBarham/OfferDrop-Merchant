//
//  ODCreateOfferViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODCreateOfferViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) IBOutlet UITextView * createOfferTextView;
@property (nonatomic, strong) IBOutlet UIButton * offerImageButton;
@property (nonatomic, strong) IBOutlet UIButton * createOfferButton;
@property (nonatomic, strong) IBOutlet UIButton * previewButton;
@property (nonatomic, strong) IBOutlet UIImage * offerImage;
@property (nonatomic, strong) IBOutlet UILabel * counterLabel;

@property (nonatomic, strong) UIPopoverController * popoverController;
@property (nonatomic) NSInteger photoSourceType;


-(IBAction)createOfferClicked:(id)sender;
-(IBAction)logoButtonClicked:(id)sender;
@end
