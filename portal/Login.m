//
//  Login.m
//  pairedUP
//
//  Created by Neil Ballard on 1/29/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "Login.h"
#import "DataAccess.h"

@implementation Login

-(void)Request:(NSString*)access_token completion:(void (^)(void))completionBlock{
    
    
    
}

- (id)initWithLogin
{
    self = [super init];
    if (self)
    {

        
    }
    return self;
}


+ (id)singletonInstance {
    
    static Login *sharedAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAccess = [[self alloc] init];
    });
    
    return sharedAccess;
    
}

@end
