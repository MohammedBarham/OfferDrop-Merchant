//
//  ODOffersTable.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODConstants.h"
#import "ODImageLoader.h"

#define kOfferCellHeight 120.0
#define kMoreCellHeight 40.0
@class ODAppDelegate;

@interface ODOffersTable : UITableView <UITableViewDataSource, ImageLoaderDelegate>

@property (nonatomic, strong) NSMutableArray * offersArray;
@property (nonatomic) BOOL isInEditMode;
@property (nonatomic, strong) id parentView;
@property (nonatomic) ParentViewType parentType;
@property (nonatomic, strong) ODAppDelegate * appDelegate;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableDictionary * imagesCacheDictionary;

-(ODOffersTable *)initWithDataArray:(NSArray *)dataArray
                                    Frame:(CGRect)tableFrame
                            fromControler:(id)prntController
                       wihtControllerType:(ParentViewType)prntType
                                withStyle:(UITableViewStyle)tableStyle;

-(void) updateOffersArray:(NSMutableArray *)offersArr;

@end
