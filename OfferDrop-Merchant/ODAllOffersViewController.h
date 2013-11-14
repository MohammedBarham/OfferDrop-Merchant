//
//  ODAllOffersViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/12/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;
@class ODOffersTable;


@interface ODAllOffersViewController : UIViewController <UITableViewDelegate>
@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) ODOffersTable * allOffersTableView;
@property (nonatomic, strong) NSMutableArray * allOoffersArray;


@end
