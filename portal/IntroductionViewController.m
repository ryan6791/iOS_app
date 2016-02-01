//
//  IntroductionViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "IntroductionViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissIntroView:) name:@"dismissIntroView" object:nil];
    [self.view setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
    [self addIntroView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addIntroView{
    
    IntroductionViewBackground *draggableBackground = [[IntroductionViewBackground alloc]init];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    draggableBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [draggableBackground invalidateIntrinsicContentSize];
    
    //   draggableBackground.layer.masksToBounds = NO;
    //   self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
    //   self.tableBack.layer.shadowRadius = .5;
    ///   self.tableBack.layer.shadowOpacity = 0.5;
    
    
    CGFloat pad = 0, sub;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        sub = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        sub = 70;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        sub = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        sub = 55;
    }
    
    
    [self.view addSubview:draggableBackground];
    
    
    
    NSDictionary *viewsDictionary = @{@"back":draggableBackground};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


-(void) dismissIntroView:(id)sender
{
    [[DataAccess singletonInstance]setInitialUserStatus:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    //[self.navigationController popViewControllerAnimated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
