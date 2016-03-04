//
//  MatchTabBarController.m
//  pairedUP
//
//  Created by Neil Ballard on 2/19/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "MatchTabBarController.h"
#import "AboutViewController.h"
#import "DataAccess.h"

@interface MatchTabBarController ()

@end

@implementation MatchTabBarController


- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
      



        
    /*
        //create the view controller for the first tab
        self.firstViewController = [[MatchProfileViewController alloc] init];
        
        //create the view controller for the second tab
        self.secondViewController = [[MessagesViewController alloc] init];
        
        //create an array of all view controllers that will represent the tab at the bottom
        NSArray *myViewControllers = [[NSArray alloc] initWithObjects:
                                      self.firstViewController,
                                      self.secondViewController, nil];
        

        //set the view controllers for the tab bar controller
        [self.tabBarController setViewControllers:myViewControllers]; */
        
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
 //   self.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tabBar invalidateIntrinsicContentSize];
    CGFloat tabSize = 25.0;
    
    CGRect tabFrame = self.tabBar.frame;
    
    tabFrame.size.height = tabSize;
    
    tabFrame.origin.y = self.view.frame.origin.y;
    
    self.tabBar.frame = tabFrame;
  
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MatchProfileViewController* ctrl1 = [[MatchProfileViewController alloc] init];
    MessagesViewController* ctrl2 = [[MessagesViewController alloc] init];
    AboutViewController* ctrl3 = [[AboutViewController alloc] init];

    NSString *name = [[DataAccess singletonInstance]getMatchName];
    
    ctrl1.title = name;
    ctrl2.title = @"Message";
    ctrl3.title = @"About";
    
 //   ctrl1.tabBarItem.image = [UIImage imageNamed:@"logo"];
//    ctrl2.tabBarItem.image = [UIImage imageNamed:@"logo"];
    
    [self setViewControllers: @[ctrl1, ctrl2, ctrl3]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DMPagerNavigationBarItem *)pagerItem {
    
    
    return self.pagerObj;
}

@end
