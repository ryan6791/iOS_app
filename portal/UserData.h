//
//  UserData.h
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface UserData : NSObject

@property (nonatomic, strong) UIImage *image;


+ (id)singletonInstance;
- (void)setImage:(UIImage*)image;
-(UIImage*)getImage;

@end
