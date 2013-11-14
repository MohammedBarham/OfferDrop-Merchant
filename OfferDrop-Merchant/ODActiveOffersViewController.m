//
//  ODActiveOffersViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODActiveOffersViewController.h"
#import "ODColors.h"
#import "ODBeaconBroadcastingView.h"
#import "ODFrames.h"
#import "ODAppDelegate.h"
#import "ODOffersTable.h"
#import "ODConstants.h"

@interface ODActiveOffersViewController ()

@end

@implementation ODActiveOffersViewController

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
    
    self.appDelegate = (ODAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    UIImageView * titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 83.0, 30.0)];
    [titleImgView setImage:[UIImage imageNamed:@"navigation_bar_title_view.png"]];
    [self.navigationItem setTitleView:titleImgView];
    
    ODBeaconBroadcastingView * transmitView = [[ODBeaconBroadcastingView alloc] initWithFrame:RIGHT_MENU_ITEM_TRANSMIT_VIEW_FRAME];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:transmitView];
    
    // init active offers array and table
    
    if (self.activeOffersArray == nil) {
        self.activeOffersArray = [[NSMutableArray alloc] init];
    }
    
    [self.activeOffersArray addObject:@"0"];
    [self.activeOffersArray addObject:@"1"];
    [self.activeOffersArray addObject:@"2"];
    [self.activeOffersArray addObject:@"3"];
    [self.activeOffersArray addObject:@"4"];
    [self.activeOffersArray addObject:@"5"];
    [self.activeOffersArray addObject:@"6"];
    [self.activeOffersArray addObject:@"7"];
    [self.activeOffersArray addObject:@"8"];
    [self.activeOffersArray addObject:@"9"];
    
    if (self.activeOffersTableView == nil) {
        self.activeOffersTableView = [[ODOffersTable alloc] initWithDataArray:self.activeOffersArray
                                                                        Frame:CGRectMake(0.0, 0.0,
                                                                                         self.appDelegate.mainFrameSize.width,
                                                                                         self.appDelegate.mainFrameSize.height)
                                                                fromControler:self
                                                           wihtControllerType:kParentTypeActiveOffersView
                                                                    withStyle:UITableViewStylePlain];
        [self.activeOffersTableView setDelegate:self];
    }
    
    [self.view addSubview:self.activeOffersTableView];
    
    [self.activeOffersTableView updateOffersArray:self.activeOffersArray];
    [self.activeOffersTableView setPageNumber:2];
    [self.activeOffersTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.activeOffersArray count]) {
        // more cell height
        return kMoreCellHeight;
    } else {
        return kOfferCellHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
