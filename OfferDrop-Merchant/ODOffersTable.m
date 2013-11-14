//
//  ODOffersTable.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODOffersTable.h"
#import "ODOffer.h"
#import "ODAppDelegate.h"
#import "ODOfferCell.h"
#import "ODColors.h"
#import "ODCalculations.h"

#define kActiveButtonTag 0
#define kInactiveButtonTag 1

@implementation ODOffersTable

@synthesize offersArray, isInEditMode, parentView, parentType, appDelegate, pageNumber;

#pragma mark - Table init and offers array update
-(ODOffersTable *)initWithDataArray:(NSArray *)dataArray
                              Frame:(CGRect)tableFrame
                      fromControler:(id)prntController
                 wihtControllerType:(ParentViewType)prntType
                          withStyle:(UITableViewStyle)tableStyle
{
    self = [super initWithFrame:tableFrame style:tableStyle];
    if (self)
    {
        // init offers array
        if (self.offersArray == nil) {
            self.offersArray = [[NSMutableArray alloc] init];
        }
        
        //inint app delegate
        self.appDelegate = (ODAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // init caching dictionary
        if (self.imagesCacheDictionary == nil) {
            self.imagesCacheDictionary = [[NSMutableDictionary alloc] init];
        }
        
        // assingn parent type and parent controller
        self.parentType = prntType;
        
        // parent view
        self.parentView = prntController;
        
        // set separator style and separator color
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setSeparatorColor:[UIColor clearColor]];
        
        // assign self as table datasource
        [self setDataSource:self];
    }
    return self;
}

-(void) updateOffersArray:(NSMutableArray *)offersArr
{
    // empty offers array
	if(self.offersArray != nil) {
		[self.offersArray removeAllObjects];
	}
    
    // add new offers to offers array
	for(int i=0; i<[offersArr count]; i++) {
		[self.offersArray addObject:[offersArr objectAtIndex:i]];
	}
}


#pragma mark - Cell Preparation

-(UITableViewCell *) prepareMoreCellForTable:(UITableView *)tableView
{
    static NSString * moreCellIdentifier = @"MoreCellIdentifier";
    
    // dequeing more cell
    UITableViewCell * moreCell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
    if(moreCell == nil)
    {
        // if cell == nil init it again
        moreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentifier];
    }
    else
    {
        for (UIView * subview in moreCell.contentView.subviews)
        {
            [subview removeFromSuperview];
        }
    }
    
    // more label
    UILabel * moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(420.0, 10.0, 300.0, 20.0)];
    moreLabel.text = NSLocalizedString(@"Loading more offers ...", @"");
    moreLabel.textColor = [UIColor darkGrayColor];
    moreLabel.backgroundColor = [UIColor clearColor];
    moreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    
    [moreCell.contentView addSubview:moreLabel];
    
    // more cell activity indicator
    UIActivityIndicatorView * loadingMoreCellsSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingMoreCellsSpinner.frame = CGRectMake(600.0, 10.0, 20.0, 20.0);
    [loadingMoreCellsSpinner startAnimating];
    [moreCell.contentView addSubview:loadingMoreCellsSpinner];
    
    return moreCell;
}

-(ODOfferCell *) PrepareOfferCellforTable:(UITableView *)tableView
{
    static NSString * offerCellIdentifier = @"OFFER_CELL_IDENTIFEIR";
    
    ODOfferCell * cell = [tableView dequeueReusableCellWithIdentifier:offerCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ODOfferCell" owner:self options:nil];
        cell = (ODOfferCell *)[nib objectAtIndex:0];
    }
    else
    {
        for (UIView * subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
#warning check active and inactive stats
    [cell.activeButton setTitle:NSLocalizedString(@"Active", @"") forState:UIControlStateNormal];
    [cell.activeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [cell.inactiveButton setTitle:NSLocalizedString(@"Inactive", @"") forState:UIControlStateNormal];
    [cell.inactiveButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    
    [cell.activeButton addTarget:self action:@selector(activeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.inactiveButton addTarget:self action:@selector(inactiveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [cell.activeLabel setText:NSLocalizedString(@"Active", "@")];
    
    [cell.activeSwitch addTarget:self action:@selector(activeSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

-(void) prepareOfferImageForCell:(ODOfferCell *)offerCell atIndexPath:(NSIndexPath *)indexPath
{
    NSString * offerImageURL = @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn1/560857_754283744584964_258578651_n.jpg";
    
    if (offerImageURL != nil) {
        if ([self.imagesCacheDictionary count] > 0 &&  [self.imagesCacheDictionary valueForKey:offerImageURL] != nil) {
            [offerCell.offerImage setImage:[self.imagesCacheDictionary valueForKey:offerImageURL] forState:UIControlStateNormal];
            [offerCell.offerImage setContentMode:UIViewContentModeScaleAspectFit];
            [offerCell.offerImage.imageView setContentMode:UIViewContentModeScaleAspectFit];
        } else {
            ODImageLoader * imageLoader = [[ODImageLoader alloc] initWithDelegate:self];
            [imageLoader loadImageWithURL:offerImageURL andIndexPath:indexPath andImageWidth:200];
        }
    }
}

#pragma mark - Actions

-(void) activeButtonPressed:(id)sender
{
    UIButton * clickedButton = (UIButton *)sender;
    ODOfferCell * offerCell = (ODOfferCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:clickedButton.tag inSection:0]];
    
    [offerCell.activeButton setBackgroundImage:[UIImage imageNamed:@"active_left.png"] forState:UIControlStateNormal];
    [offerCell.inactiveButton setBackgroundImage:[UIImage imageNamed:@"inactive_right.png"] forState:UIControlStateNormal];
    [offerCell.activeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [offerCell.inactiveButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    
}

-(void) inactiveButtonPressed:(id)sender
{
    UIButton * clickedButton = (UIButton *)sender;
    ODOfferCell * offerCell = (ODOfferCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:clickedButton.tag inSection:0]];
    
    [offerCell.activeButton setBackgroundImage:[UIImage imageNamed:@"inactive_left.png"] forState:UIControlStateNormal];
    [offerCell.inactiveButton setBackgroundImage:[UIImage imageNamed:@"active_right.png"] forState:UIControlStateNormal];
    [offerCell.activeButton setTitleColor:OD_ACTIVE_COLOR forState:UIControlStateNormal];
    [offerCell.inactiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) activeSwitchValueChanged:(UISwitch *)offerSwitch
{
    ODOfferCell * offerCell = (ODOfferCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:offerSwitch.tag inSection:0]];
    
    DLog(@"switch value = %d", offerSwitch.isOn);
    if (offerSwitch.isOn) {
        [offerCell.activeLabel setTextColor:OD_VERY_DARK_GRAY_COLOR];
    } else {
        [offerCell.activeLabel setTextColor:OD_LIGHT_GRAY_COLOR];
    }
}
#pragma mark - UItableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pageNumber > 0 && indexPath.row == [self.offersArray count]) {
        // more cell viewed for user
        
        UITableViewCell * moreCell = [self prepareMoreCellForTable:tableView];
        return moreCell;
        
    } else {
        
        ODOfferCell * offerCell = [self PrepareOfferCellforTable:tableView];
        [offerCell.activeSwitch setTag:indexPath.row];
        
        //[offerCell.inactiveButton setTag:indexPath.row];
        //[offerCell.activeButton setTag:indexPath.row];
        
        
        [self prepareOfferImageForCell:offerCell atIndexPath:indexPath];
        
        NSString * text = @"Hello sir Hello sir Hello sirHello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sirHello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sirHello sir Hello sir Hello sir Hello sir Hello sir Hello sir Hello sir";
        
        [offerCell.offerDetails setTitle:text forState:UIControlStateNormal];
        
        [offerCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return offerCell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.pageNumber > 0) {
        // return +1 cell for loading more cell
        return [self.offersArray count] + 1;
    } else {
        return [self.offersArray count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - ImageLoader Delegate
-(void)imageLoadedSuccessfully:(ODImageLoader *)loader withImage:(UIImage *)image andIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.offersArray count]) {
        ODOfferCell * cell = (ODOfferCell *)[self cellForRowAtIndexPath:indexPath];
        
        [cell.offerImage setImage:image forState:UIControlStateNormal];
        [cell.offerImage setContentMode:UIViewContentModeScaleAspectFit];
        [cell.offerImage.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
         NSString * offerImageURL = @"https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn1/560857_754283744584964_258578651_n.jpg";
        [self.imagesCacheDictionary setObject:image forKey:offerImageURL];
    }
}

-(void)imageLoadingFailed:(ODImageLoader *)loader atIndexPath:(NSIndexPath *)indexPath
{
    // do nothing for this case
}

@end
