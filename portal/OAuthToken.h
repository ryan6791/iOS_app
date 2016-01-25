//
//  OAuthToken.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthToken : NSObject <NSCoding>

+ (id)tokenWithDictionary:(NSDictionary*)dictionary andType:(int)type;

- (id)initWithType:(int)type;
- (id)initWithType:(int)type andKey:(NSString*)key andSecret:(NSString*)secret;
- (int)getType;
- (NSString*)getKey;
- (NSString*)getSecret;

@end