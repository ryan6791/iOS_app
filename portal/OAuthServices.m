//
//  OAuthServices.m
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import "OAuthServices.h"
#import "NSMutableURLRequest+OAuth.h"

static NSString * PercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kCHCharactersToBeEscaped = @":/?&=;+!@#$()~";
    static NSString * const kCHCharactersToLeaveUnescaped = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kCHCharactersToLeaveUnescaped, (__bridge CFStringRef)kCHCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}


#pragma mark -

@interface QueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;
@end

@implementation QueryStringPair
@synthesize field = _field;
@synthesize value = _value;

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return PercentEscapedQueryStringPairMemberFromStringWithEncoding([self.field description], stringEncoding);
    } else {
        return [NSString stringWithFormat:@"%@=%@", PercentEscapedQueryStringPairMemberFromStringWithEncoding([self.field description], stringEncoding), PercentEscapedQueryStringPairMemberFromStringWithEncoding([self.value description], stringEncoding)];
    }
}

@end

@implementation OAuthServices

+ (NSString *)queryStringFromParameters:(NSDictionary*)parameters withEncoding:(NSStringEncoding)stringEncoding {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    
    for (QueryStringPair *pair in [OAuthServices queryStringPairsFromDictionary:parameters]) {
        [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

+ (NSArray *)queryStringPairsFromDictionary:(NSDictionary *)dictionary {
    return [OAuthServices queryStringPairsFromKey:nil andValue:dictionary];
}

+ (NSArray*)queryStringPairsFromKey:(NSString *)key andValue:(id)value {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    if([value isKindOfClass:[NSDictionary class]]) {
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        [[[value allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] enumerateObjectsUsingBlock:^(id nestedKey, NSUInteger idx, BOOL *stop) {
            id nestedValue = [value objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:[OAuthServices queryStringPairsFromKey:(key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey) andValue:nestedValue]];
            }
        }];
    } else if([value isKindOfClass:[NSArray class]]) {
        [value enumerateObjectsUsingBlock:^(id nestedValue, NSUInteger idx, BOOL *stop) {
            [mutableQueryStringComponents addObjectsFromArray:[OAuthServices queryStringPairsFromKey:[NSString stringWithFormat:@"%@[]", key] andValue:nestedValue]];
        }];
    } else {
        [mutableQueryStringComponents addObject:[[QueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}


+ (NSString *)URLStringWithoutQueryFromURL:(NSURL *) url {
    NSArray *parts = [[url absoluteString] componentsSeparatedByString:@"?"];
    return [parts objectAtIndex:0];
}

+(NSData *)hmacSHA256ForKey:(NSString*)key andData:(NSString *)data {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    return [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
}

#pragma mark - Signing Strategies
+ (NSString*)signClearText:(NSString*)text withSecret:(NSString*)secret {
    NSData *hmacFinal = [OAuthServices hmacSHA256ForKey:secret andData:text];
    NSString *base64EncodedData = [hmacFinal base64EncodedStringWithOptions:0];
    
    return base64EncodedData;
}

#pragma mark - Nonce services
+ (NSString*)generateNonce {
    NSString *randomString = [OAuthServices randomString];
    
    while([randomString length] < 32) {
        [randomString stringByAppendingString:[OAuthServices randomString]];
    }
    
    return [randomString substringToIndex:32];
}

+ (NSString *)randomString {
    CFUUIDRef cfuuid = CFUUIDCreate (kCFAllocatorDefault);
    NSString *uuid = (__bridge_transfer NSString *)(CFUUIDCreateString (kCFAllocatorDefault, cfuuid));
    CFRelease (cfuuid);
    return uuid;
}

#pragma mark - Token Services

+ (OAuthToken*)retrieveRequestToken {
    NSString *url = [NSString stringWithFormat:@"%@%@", [DataAccess uri], @"/oauth/requestToken"];
    NSURL *requestTokenURL = [NSURL URLWithString:url];
    
    //GET REQUEST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestTokenURL];
    [request signRequestWithEmptyToken];
    
    NSHTTPURLResponse *response;
    NSError *error;
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
//    NSLog(@"Status Code: %ld", (long)response.statusCode);
    
    // check for an error. If there is a network error, you should handle it here.
    if(!error)
    {
        //log response
//        NSLog(@"Response from server = %@", responseString);
        //TODO: BUILD OAuthToken object
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        return [OAuthToken tokenWithDictionary:responseDictionary andType:kOAuthTokenTypeRequestToken];
    } else {
        NSLog(@"ERROR: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    
    return nil;
}

+ (OAuthToken*)retrieveAccessTokenWithRequestToken:(OAuthToken*)requestToken {
    NSString *url = [NSString stringWithFormat:@"%@%@", [DataAccess uri], @"/oauth/accessToken"];
    NSURL *accessTokenURL = [NSURL URLWithString:url];
    
    //POST REQUEST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:accessTokenURL];
    [request setHTTPMethod:@"POST"];
    [request signRequestWithRequestToken:requestToken];
    
    NSHTTPURLResponse *response;
    NSError *error;
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
//    NSLog(@"Status Code: %ld", (long)response.statusCode);
    
    // check for an error. If there is a network error, you should handle it here.
    if(!error)
    {
        //log response
//        NSLog(@"Response from server = %@", responseString);
        //TODO: BUILD OAuthToken object
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        return [OAuthToken tokenWithDictionary:responseDictionary andType:kOAuthTokenTypeAccessToken];
    } else {
        NSLog(@"ERROR: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    
    return nil;
}

+ (BOOL)refreshAccessToken {
    if([[DataAccess singletonInstance] oAuthAccessTokenExists]) {
        
        if([OAuthServices testAccessToken]) {
            return YES;
        }
        
        //get new access token by generating new request token
        OAuthToken *requestToken = [OAuthServices retrieveRequestToken];
        
        if(nil != requestToken) {
            
            OAuthToken *token = [OAuthServices retrieveAccessTokenWithRequestToken:requestToken];
            
            if(nil != token) {
                [[DataAccess singletonInstance] setOAuthAccessToken:token];
                return YES;
            }
        }
    }
    
    return NO;
}

+ (BOOL)testAccessToken {
    if(![[DataAccess singletonInstance] oAuthAccessTokenExists]) return NO;
    
    NSError *error;
    NSHTTPURLResponse *response;
    NSString *url = [NSString stringWithFormat:@"%@/%@", [DataAccess uri], @"oauth/checkToken"];
    NSURL *checkTokenURL = [NSURL URLWithString:url];
    
    //GET REQUEST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:checkTokenURL];
    [request signWithCurrentAccessToken];
    
    //send it synchronous
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // check for an error. If there is a network error, you should handle it here.
    if(!error) {
        //log response
        long status = [(NSHTTPURLResponse *)response statusCode];
//        NSLog(@"Response from server = %ld", status);
        
        if(200 == status)
            return YES;
    }
    
    return NO;
}

+ (void)startupTokenSequence {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![OAuthServices refreshAccessToken]) {
            OAuthToken *accessToken = nil;
            OAuthToken *requestToken = [OAuthServices retrieveRequestToken];
            
            if(nil == requestToken) {
                //TODO: handle error -- notify banner
            } else {
                //Get Access Token
                accessToken = [OAuthServices retrieveAccessTokenWithRequestToken:requestToken];
                
                if(nil == accessToken) {
                    
                } else {
                    [[DataAccess singletonInstance] setOAuthAccessToken:accessToken];
                }
            }
        }
    });
}

+ (void)doOAuthHeartbeat {
    if(![[DataAccess singletonInstance] oAuthAccessTokenExists]) return;
    
    NSError *error;
    NSHTTPURLResponse *response;
    NSString *url = [NSString stringWithFormat:@"%@/%@", [DataAccess uri], @"/service/pulse"];
    NSURL *heartbeatURL = [NSURL URLWithString:url];
    
    //GET REQUEST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:heartbeatURL];
    [request setHTTPMethod:@"PUT"];
    [request signWithCurrentAccessToken];
    
    //send it synchronous
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // check for an error. If there is a network error, you should handle it here.
    if(!error) {
        //log response
        long status = [(NSHTTPURLResponse *)response statusCode];
        //        NSLog(@"Response from server = %ld", status);
        
        if(200 == status) {
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSLog(@"Heartbeat: %@", responseString);
        } else {
            NSLog(@"Error retrieving heartbeat: %ld", status);
        }
    }
}

@end