//
//  ODActiveOffersViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;
@class ODOffersTable;

@interface ODActiveOffersViewController : UIViewController<UITableViewDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;

@property (nonatomic, strong) ODOffersTable * activeOffersTableView;
@property (nonatomic, strong) NSMutableArray * activeOffersArray;

@end
