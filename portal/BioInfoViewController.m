//
//  BioInfoViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "BioInfoViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface BioInfoViewController ()

@end

@implementation BioInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self styleNavBar];
    [self setupbioLabel];
    [self setupBioTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleNavBar {
    
    CGFloat height = 0, ypad = 0;
    
    height = 64;
    ypad = 36;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 55;
    }
    
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navBar.barTintColor = [UIColor whiteColor];
    
    
    
    // 2. create a new nav bar and style it
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    self.navBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    self.navBar.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [[UIImage imageNamed:@"back_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.leftBarButtonItem = leftBtn;
    
    /*
     UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
     [titleView setUserInteractionEnabled:NO];
     
     [titleView setBackgroundImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
     
     //  NSString *titleText = @"Portal";
     //  [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
     //  [titleView setTitle:titleText forState:UIControlStateNormal];
     
     newItem.titleView = titleView; */
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


- (void)setupbioLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.bioLabel = [[UILabel alloc] init];
    
    self.bioLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 27;
        height = 180;
        self.bioLabel.font = [UIFont systemFontOfSize:16];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 27;
        height = 180;
        self.bioLabel.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 180;
        self.bioLabel.font = [UIFont systemFontOfSize:18];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 180;
        self.bioLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    
    
    [self.bioLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bioLabel invalidateIntrinsicContentSize];
    self.bioLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
    self.bioLabel.textColor = [self cdBlue];
    
    self.bioLabel.text = @"Bio";
    
    [self.view addSubview:self.bioLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.bioLabel, @"nav":self.navBar};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupBioTextField {
    
    self.bioTextField = [[UITextField alloc]init];
    self.bioTextField.delegate = self;
    self.bioTextField.layer.cornerRadius = 7.0;
    self.bioTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bioTextField invalidateIntrinsicContentSize];
    
    NSString *bio = [[DataAccess singletonInstance] getBio];
    
      if (bio != nil) {
          self.bioTextField.text = bio;
      }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 30;
    CGFloat font_size = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 150;
        xpad = 15;
        ypad = 3;
        font_size = 12;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 200;
        xpad = 15;
        ypad = 5;
        font_size = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 45;
        xpad = 15;
        ypad = 10;
        font_size = 14;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 30;
        xpad = 15;
        ypad = 0;
        font_size = 11;
        
    }
    
    UIColor *color = [UIColor lightGrayColor];
    
    
    self.bioTextField.backgroundColor = [UIColor whiteColor];
    self.bioTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bioTextField.layer.borderWidth = 0.5f;
    self.bioTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.bioTextField forKey:@"textField"];
    [viewsDictionary setObject:self.bioLabel forKey:@"label"];
    
    [self.view addSubview:self.bioTextField];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bioTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
}




- (void)textFieldDidChange {
    //
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setReturnKeyType:UIReturnKeyDone];
    return TRUE;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.bioTextField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[DataAccess singletonInstance] setBio:self.bioTextField.text];
    [self.bioTextField resignFirstResponder];
    [self.bioTextField endEditing:YES];
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}


- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
