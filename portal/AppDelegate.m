//
//  AppDelegate.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DataAccess.h"
#import "AccountViewController.h"
#import "MatchProfileViewController.h"
#import "MessagesViewController.h"
#import "GlobalConstants.h"
#import "OAuthServices.h"
#import "LockedNewMatchViewController.h"


@interface AppDelegate ()

@property(nonatomic, strong) UINavigationController *navController;
@property(nonatomic, strong) NSTimer *timer;



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    


    [[DataAccess singletonInstance] setAPICurrentURL:URL_Dev];
    [OAuthServices startupTokenSequence];
    
    if([[DataAccess singletonInstance] oAuthAccessTokenExists])
        [OAuthServices doOAuthHeartbeat];
    
    [self CurrentLocationIdentifier]; // call this method
  
    if ([[DataAccess singletonInstance] UserIsLoggedIn]) {
        [[DataAccess singletonInstance] setMatchName:@"Jess"];
        UIImage *matchImage = [UIImage imageNamed:@"_avatar_cook"];
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(matchImage) forKey:@"matchImage"];
        [[DataAccess singletonInstance] saveIncomingAvatarSetting:YES];
        [[DataAccess singletonInstance] saveOutgoingAvatarSetting:YES];
        [self initRootViewController];
    }
    else{
        [self initLoginViewController];
    }
    

    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


- (void)initLoginViewController {
    
    
    LoginViewController *ViewController = [[LoginViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:ViewController];
    [self.navController setNavigationBarHidden:YES];
    
    self.window.rootViewController = self.navController;
}

- (void)initRootViewController {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Superclarendon-Regular" size:21.0],
                                      NSForegroundColorAttributeName : [self navColor]};
    
    UIColor *bkVC1 = [UIColor colorWithRed:0.000 green:0.475 blue:0.647 alpha:1.000];
    UIColor *bkVC2 = [UIColor colorWithRed:0.000 green:0.729 blue:0.984 alpha:1.000];
    UIColor *bkVC3 = [UIColor colorWithRed:0.753 green:0.929 blue:0.996 alpha:1.000];
    
    
    SwipeViewController *vc1 = [[SwipeViewController alloc] initWithText:@"Page #1" backgroundColor:bkVC1];
    vc1.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"POD" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"settings"]];
 //   vc1.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    
    MatchProfileViewController *vc2 = [[MatchProfileViewController alloc] initWithText:@"Page #2" backgroundColor:bkVC2];
    vc2.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"MATCH" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"logo"]];
//    vc2.pagerItem.renderingMode = DMPagerNavigationBarItemModeOnlyImage;
    
    MessagesViewController *vc3 = [[MessagesViewController alloc] initWithText:@"Page #3" backgroundColor:bkVC3];
    vc3.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"CHAT" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"chat_icon"]];
  //  vc3.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    // Create pager with items
    self.pagerController = [[DMPagerViewController alloc] initWithViewControllers: @[vc1,vc2,vc3]];
    self.pagerController.useNavigationBar = YES;
    self.pagerController.navigationBar.style = DMPagerNavigationBarStyleClose;

    
    // Setup pager's navigation bar colors
    UIColor *activeColor = [self navColor];
    //[UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
    UIColor *inactiveColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1.0];
    self.pagerController.navigationBar.inactiveItemColor = inactiveColor;
    self.pagerController.navigationBar.activeItemColor = activeColor;
    
    [self.pagerController.navigationBar addSettingsIcon];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.pagerController];
    [self.navController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
}


-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    //------
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"long is:%f", self.currentLocation.coordinate.longitude);
    NSLog(@"lat is:%f", self.currentLocation.coordinate.latitude);

    /*
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             CountryArea = NULL;
         }

     }];

*/
    
    /*---- For more results
     placemark.region);
     placemark.country);
     placemark.locality);
     placemark.name);
     placemark.ocean);
     placemark.postalCode);
     placemark.subLocality);
     placemark.location);
     ------*/
}


-(void)myTicker{
/*
    NewMatchViewController *account = [[NewMatchViewController alloc] init];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [account setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    account.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:account animated:YES completion:nil];
 //   [self.timer invalidate];
*/
}




#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Neil-appworld.portal" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"portal" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"portal.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)displayVC{
    
    
    UIViewController *currentVC =  self.navController.visibleViewController;
    
    LockedNewMatchViewController *newMatchVC = [[LockedNewMatchViewController alloc]init];
    currentVC.providesPresentationContextTransitionStyle = YES;
    currentVC.definesPresentationContext = YES;
    [newMatchVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    newMatchVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [currentVC presentViewController:newMatchVC animated:NO completion:nil];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    


}


-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}



@end
