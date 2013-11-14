//
//  ODAppDelegate.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ODConfig.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class JASidePanelController;
@class ODCreateOfferViewController;
@class ODNavigationController;

@interface ODAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) JASidePanelController * leftMenuViewController;
@property (nonatomic, strong) ODNavigationController * ODMainNavigationController;
@property (nonatomic) CGSize mainFrameSize;
@property (nonatomic, strong) CLLocationManager * locationManager;

@property (nonatomic) BOOL isTransmittingEnabled;
@property (nonatomic, strong) CBPeripheralManager * peripheralManager;
@property (nonatomic, strong) NSDictionary * beaconPeripheralData;

-(void) saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(void) OpenFacebookSessionEnablingGUI:(BOOL)GUIEnabled;
-(void) InitLocationManager;
-(void) ShowLoginView;
-(void) turnOnOffBeaconTransision;
@end
