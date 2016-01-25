//
//  OAuthSecurity.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthSecurity : NSObject

+ (NSString*)base64HashForString:(NSString*)forHashing;
+ (NSString*)retrievePasswordSalt;
+ (NSString*)retriveOAuthConsumerKey;
+ (NSString*)retrieveOAauthConsumerSecret;

@end