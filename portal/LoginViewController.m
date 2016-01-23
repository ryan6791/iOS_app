//
//  LoginViewController.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "LoginViewController.h"
#import "DataAccess.h"
#import "DeviceManager.h"
#import "SwipeViewController.h"
#import "MatchProfileViewController.h"
#import "MessagesViewController.h"


@interface LoginViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic, strong) IBOutlet UIButton *LoginButton;
@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, strong) NSMutableDictionary *viewsDictionary;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    CGRect full = [[UIScreen mainScreen]bounds];
    
    
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.background];
    
    

    [self setLoginBtn];
    
}


-(void)LoginButtonClicked
{


    
    
   FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    [login
     logInWithReadPermissions: @[@"email", @"public_profile",  @"user_photos", @"user_birthday"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error %@", error);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([result.grantedPermissions containsObject:@"email"] && [result.grantedPermissions containsObject:@"user_photos"]) {
                 if ([FBSDKAccessToken currentAccessToken]) {
                //remove when server is setup
                     
                    NSString *userid = [FBSDKAccessToken currentAccessToken].userID;
                     [self fetchUserInfo];
                     
                     [[DataAccess singletonInstance] setFacebook:userid];
                     
                     [[DataAccess singletonInstance] setUserLoginStatus:YES];
                     [[DataAccess singletonInstance] setisLoggedInWithFB:YES];
                 //    SwipeViewController *root = [[SwipeViewController alloc] init];
                 //    [self.navigationItem setHidesBackButton:YES];
                 //    [self.navigationController setNavigationBarHidden:NO animated:NO];
                 //    [self.navigationController pushViewController:root animated:YES];
                     //[[DataAccess singletonInstance] setName:name];
   
                     
                     
                 }
             }
             [self viewDidLoad];
         }
     }];

}

-(void)fetchUserInfo
{
    
    if ([FBSDKAccessToken currentAccessToken])
    {
       // NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, birthday, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSString *name = [result objectForKey:@"first_name"];
                 [[DataAccess singletonInstance] setName:name];
                 NSLog(@"%@", [[DataAccess singletonInstance] getName]);
                 NSString *birthday = [result objectForKey:@"birthday"];
                 [[DataAccess singletonInstance] setBirthday:birthday];
                 NSString *gender = [result objectForKey:@"gender"];
                 [[DataAccess singletonInstance] setGender:gender];

                 
                 NSLog(@"the gender is %@", [[DataAccess singletonInstance] getGender]);
                 NSLog(@"The age is: %@", birthday);
                 
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                      parameters:nil
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            if (!error){
                
                        NSDictionary *res = [result objectForKey:@"data"];
                
                
                          NSDictionary *imageUrl = [res objectForKey:@"url"];
                
                
                
                        UIImage *proImage =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
                
                        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(proImage) forKey:@"ProfileImage"];
                
                [self start];

                
            }
            else {
                NSLog(@"result: %@",[error description]);
            }}];
        
    }
    
}




-(void)sendData:(NSString*)access_token completion:(void (^)(void))completionBlock{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    self.session = [NSURLSession sessionWithConfiguration:config];
    
//    NSError *error = nil;
    
    //   self.request_success = NO;
    
    //
    /*
    NSString *otto_url = v2URL;
    NSString *OTTOurl = @"/user/sso/login";
    otto_url = [otto_url stringByAppendingString:OTTOurl];
    NSURL *url = [NSURL URLWithString:otto_url];
    
    NSDictionary *dict = @{
                           @"token": access_token
                           };
    
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request addValue:@"0770" forHTTPHeaderField:@"X-OTTO-Validation"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody: jsonData];
    
    
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:request
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        
                        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"%@", newStr);
                        
                        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                        NSString *statusString = (NSString*)[responseData objectForKey:@"status"];
                        NSString *messageString = (NSString*)[responseData objectForKey:@"message"];
                        
                        if (error) {
                            [OTTOLogManagement Log:@"%@", error.localizedDescription];
                        }
                        
                        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                        
                        if (statusCode == 200) {
                            
                            
                            if([@"OK" isEqualToString:statusString]) {
                                [OTTOLogManagement Log:@"Status %@\tMessage: %@", statusString, messageString];
                                [[OTTODataAccess singletonInstance] setOttoIsLoggedIn:YES];
                                self.request_success = YES;
                                NSLog(@"being hit in login controller");
                            } else {
                                [OTTOLogManagement Log:@"Status %@\tMessage: %@", statusString, messageString];
                                [[OTTODataAccess singletonInstance] setOttoIsLoggedIn:NO];
                                if ([messageString containsString:@"Account not found for FB SSO credentials:"]) {
                                    //   [[RegisterViewController singletonInstance] LoginButtonClicked];
                                    NSLog(@"you are here");
                                    [[RegisterViewController singletonInstance] setVCStatus];
                                    RegisterViewController *pass = nil;
                                    pass = [[RegisterViewController alloc] init];
                                    [self.navigationController pushViewController:pass animated:YES];
                                }
                                
                                
                            }
                            if (self.request_success) {
                                completionBlock();
                            }
                            
                            
                        }else{
                            
                            if ([UIAlertController class]) {
                                
                                
                                UIAlertController *alert= [UIAlertController
                                                           alertControllerWithTitle:statusString
                                                           message:messageString
                                                           preferredStyle:UIAlertControllerStyleAlert];
                                
                                
                                UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                               handler:^(UIAlertAction * action) {
                                                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                                                   
                                                                               }];
                                
                                [alert addAction:cancel];
                                
                                
                                [self presentViewController:alert animated:YES completion:nil];
                                
                                
                                
                            }
                            
                            else{
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:statusString
                                                                                message:messageString
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil, nil];
                                [alert show];
                            }
                            
                        }
                        
                    }];
    
    
    [dataTask resume];
     */
    
}

- (UIColor *) facebookBlue
{
    return [UIColor colorWithRed:0.23 green:0.35 blue:0.60 alpha:1.0];
}



- (UIColor *) linkedinBlue
{
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.71 alpha:1.0];
}

-(void)setLoginBtn{
    
    
    self.LoginButton = [[UIButton alloc] init];
    self.LoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.LoginButton.backgroundColor = [self facebookBlue];
    [self.LoginButton setTitle: @"Login With Facebook" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.LoginButton
     addTarget:self
     action:@selector(LoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.LoginButton.alpha = 1.0;
    self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
     self.LoginButton.layer.cornerRadius = 3.0;
    
    self.LoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.LoginButton invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.LoginButton.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = ceilf(103/2);
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = ceilf(171/3);
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 35;
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.LoginButton];
    
    NSDictionary *viewsDictionary = @{@"fbButton" : self.LoginButton};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.LoginButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[fbButton]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.LoginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.LoginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}


-(void)start{
    
    [[DataAccess singletonInstance] setMatchName:@"Jess"];
    UIImage *matchImage = [UIImage imageNamed:@"_avatar_cook"];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(matchImage) forKey:@"matchImage"];
    [[DataAccess singletonInstance] saveIncomingAvatarSetting:YES];
    [[DataAccess singletonInstance] saveOutgoingAvatarSetting:YES];
    
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

-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
