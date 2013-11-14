//
//  ODOfferCell.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ODOfferCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton * offerImage;
@property (nonatomic, strong) IBOutlet UIButton * offerDetails;
@property (nonatomic) BOOL isOfferActive;
@property (nonatomic, strong) IBOutlet UIButton * activeButton;
@property (nonatomic, strong) IBOutlet UIButton * inactiveButton;
@property (nonatomic, strong) IBOutlet UISwitch * activeSwitch;
@property (nonatomic, strong) IBOutlet UILabel * activeLabel;

@end
