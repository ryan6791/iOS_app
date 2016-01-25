//
//  OAuthServices.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "OAuthToken.h"
#import "DataAccess.h"
#import "GlobalConstants.h"

@interface OAuthServices : NSObject

+ (NSString *)queryStringFromParameters:(NSDictionary*)parameters withEncoding:(NSStringEncoding)stringEncoding;
+ (NSArray *)queryStringPairsFromDictionary:(NSDictionary *)dictionary;
+ (NSArray*)queryStringPairsFromKey:(NSString *)key andValue:(id)value;
+ (NSString *)URLStringWithoutQueryFromURL:(NSURL *)url;
+ (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret;
+ (NSString*)generateNonce;
+ (NSString*)randomString;
+ (void)startupTokenSequence;
+ (void)doOAuthHeartbeat;

@end