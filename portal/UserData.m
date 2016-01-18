//
//  UserData.m
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "UserData.h"

@implementation UserData



+ (id)singletonInstance {
    
    static UserData *sharedDragView = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDragView = [[self alloc] init];
    });
    
    return sharedDragView;
    
}



-(UIImage*)getImage{
    
    return self.image;
}

@end
