//
//  ODAllOffersViewController.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/12/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODAllOffersViewController.h"
#import "ODColors.h"
#import "ODBeaconBroadcastingView.h"
#import "ODFrames.h"
#import "ODOffersTable.h"
#import "ODAppDelegate.h"

@interface ODAllOffersViewController ()

@end

@implementation ODAllOffersViewController

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
    
    [self.view setBackgroundColor:OD_VIEWS_BACKFGROUND_COLOR];
    
    self.appDelegate = (ODAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIImageView * titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 83.0, 30.0)];
    [titleImgView setImage:[UIImage imageNamed:@"navigation_bar_title_view.png"]];
    [self.navigationItem setTitleView:titleImgView];
    
    ODBeaconBroadcastingView * transmitView = [[ODBeaconBroadcastingView alloc] initWithFrame:RIGHT_MENU_ITEM_TRANSMIT_VIEW_FRAME];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:transmitView];
    
    // init active offers array and table
    
    if (self.allOoffersArray == nil) {
        self.allOoffersArray = [[NSMutableArray alloc] init];
    }
    
    [self.allOoffersArray addObject:@"0"];
    [self.allOoffersArray addObject:@"1"];
    [self.allOoffersArray addObject:@"2"];
    [self.allOoffersArray addObject:@"3"];
    [self.allOoffersArray addObject:@"4"];
    [self.allOoffersArray addObject:@"5"];
    [self.allOoffersArray addObject:@"6"];
    [self.allOoffersArray addObject:@"7"];
    [self.allOoffersArray addObject:@"8"];
    [self.allOoffersArray addObject:@"9"];
    
    if (self.allOffersTableView == nil) {
        self.allOffersTableView = [[ODOffersTable alloc] initWithDataArray:self.allOoffersArray
                                                                     Frame:CGRectMake(0.0, 0.0,
                                                                                      self.appDelegate.mainFrameSize.width,
                                                                                      self.appDelegate.mainFrameSize.height)
                                                             fromControler:self
                                                        wihtControllerType:kParentTypeOffersStatsView
                                                                 withStyle:UITableViewStylePlain];
        [self.allOffersTableView setDelegate:self];
    }
    
    [self.view addSubview:self.allOffersTableView];
    
    [self.allOffersTableView updateOffersArray:self.allOoffersArray];
    [self.allOffersTableView setPageNumber:2];
    [self.allOffersTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.allOoffersArray count]) {
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
