//
//  OTTOOpenAuthConsumerServices.m
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableURLRequest+OAuth.h"
#import "GlobalConstants.h"
#import "NSURL+QueryParser.h"
#import "NSString+URLEncoding.h"
#import "DataAccess.h"
#import "OAuthServices.h"
#import "OAuthSecurity.h"

@implementation NSMutableURLRequest (OAuth)

- (BOOL)signWithCurrentAccessToken {
    OAuthToken *token = [[DataAccess singletonInstance] retrieveOAuthAccessToken];
    
    if(nil == token) return NO;
    
    NSString *url = [[self URL] absoluteString];
    NSMutableString *mutableURL = [[NSMutableString alloc] init];
    [mutableURL appendString:url];
    
    int paramPairCount = 0;
    NSDictionary *queryParams = [[self URL] queryDictionary];
    
    for (NSString *queryParam in [queryParams keyEnumerator]) {
        if (paramPairCount > 0)
            [mutableURL appendString:@"&"];
        [mutableURL appendFormat:@"%@=%@", queryParam, (NSString*)[queryParams objectForKey:queryParam]];
        paramPairCount++;
    }
    
    // oauth fields
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%lu", (unsigned long)[NSDate.date timeIntervalSince1970] * 1000];
    NSString *oauth_nonce = [OAuthServices generateNonce];
    NSString *oauth_consumer_key = [OAuthSecurity retriveOAuthConsumerKey];
    NSString *oauth_token = [token getKey];
    NSString *oauth_signature_method = @"HMAC-SHA256";
    NSString *oauth_version = @"1.0";
    
    NSMutableDictionary *standardParameters = [NSMutableDictionary dictionary];
    [standardParameters setValue:oauth_consumer_key     forKey:@"oauth_consumer_key"];
    [standardParameters setValue:oauth_nonce            forKey:@"oauth_nonce"];
    [standardParameters setValue:oauth_signature_method forKey:@"oauth_signature_method"];
    [standardParameters setValue:oauth_timestamp        forKey:@"oauth_timestamp"];
    [standardParameters setValue:oauth_version          forKey:@"oauth_version"];
    [standardParameters setValue:oauth_token            forKey:@"oauth_token"];
    
    NSMutableArray *paramPairKeys = [[NSMutableArray alloc] init];
    for (NSString *keyName in [queryParams keyEnumerator]) {
        NSString *value = (NSString*)[queryParams objectForKey:keyName];
        
        [standardParameters setValue:value forKey:keyName];
        [paramPairKeys addObject:keyName];
    }
    
    NSString *parametersString = [OAuthServices queryStringFromParameters:standardParameters withEncoding:NSUTF8StringEncoding];
    
    // use URL and remove ? (always at end of URL)
    NSString *request_url = [url stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSString *oauth_consumer_secret = [OAuthSecurity retrieveOAauthConsumerSecret];
    NSString *oauth_token_secret = [token getSecret];
    NSString *baseString = [self.HTTPMethod stringByAppendingFormat:@"&%@&%@", request_url.utf8AndURLEncode, parametersString.utf8AndURLEncode];
//    NSLog(@"[iOS]Signature Base String: %@", baseString);
    
    // append oauth token secret to consumer secret
    NSString *secretString = [oauth_consumer_secret.utf8AndURLEncode stringByAppendingFormat:@"&%@", oauth_token_secret.utf8AndURLEncode];
    NSString *oauth_signature = [OAuthServices signClearText:baseString withSecret:secretString];
    standardParameters[@"oauth_signature"] = oauth_signature;
//    NSLog(@"[iOS]Signature: %@", oauth_signature);
    
    // remove symbols portion for header before doing request
    for (NSString* keyToRemove in paramPairKeys) {
        [standardParameters removeObjectForKey:keyToRemove];
    }
    
    [standardParameters removeObjectForKey:@"symbols"];
    
    NSMutableArray *parameterPairs = [NSMutableArray array];
    for (NSString *name in standardParameters) {
        NSString *aPair = [name stringByAppendingFormat:@"=\"%@\"", [standardParameters[name] utf8AndURLEncode]];
        [parameterPairs addObject:aPair];
    }
    
    parameterPairs = [NSMutableArray arrayWithArray:[parameterPairs sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSString *oAuthHeader = [@"OAuth " stringByAppendingFormat:@"%@", [parameterPairs componentsJoinedByString:@", "]];
    [self setValue:oAuthHeader forHTTPHeaderField:@"Authorization"];
    
//    NSLog(@"OAUTH HEADER FINAL: %@", oAuthHeader);
    
    return YES;
}

- (BOOL)signRequestWithRequestToken:(OAuthToken*)token {
    if(nil == token) return NO;
    
    NSString *url = [[self URL] absoluteString];
    NSMutableString *mutableURL = [[NSMutableString alloc] init];
    [mutableURL appendString:url];
    
    int paramPairCount = 0;
    NSDictionary *queryParams = [[self URL] queryDictionary];
    
    for (NSString *queryParam in [queryParams keyEnumerator]) {
        if (paramPairCount > 0)
            [mutableURL appendString:@"&"];
        [mutableURL appendFormat:@"%@=%@", queryParam, (NSString*)[queryParams objectForKey:queryParam]];
        paramPairCount++;
    }
    
    // oauth fields
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%lu", (unsigned long)[NSDate.date timeIntervalSince1970] * 1000];
    NSString *oauth_nonce = [OAuthServices generateNonce];
    NSString *oauth_consumer_key = [OAuthSecurity retriveOAuthConsumerKey];
    NSString *oauth_token = [token getKey];
    NSString *oauth_signature_method = @"HMAC-SHA256";
    NSString *oauth_version = @"1.0";
    
    NSMutableDictionary *standardParameters = [NSMutableDictionary dictionary];
    [standardParameters setValue:oauth_consumer_key     forKey:@"oauth_consumer_key"];
    [standardParameters setValue:oauth_nonce            forKey:@"oauth_nonce"];
    [standardParameters setValue:oauth_signature_method forKey:@"oauth_signature_method"];
    [standardParameters setValue:oauth_timestamp        forKey:@"oauth_timestamp"];
    [standardParameters setValue:oauth_version          forKey:@"oauth_version"];
    [standardParameters setValue:oauth_token            forKey:@"oauth_token"];
    
    NSMutableArray *paramPairKeys = [[NSMutableArray alloc] init];
    for (NSString *keyName in [queryParams keyEnumerator]) {
        NSString *value = (NSString*)[queryParams objectForKey:keyName];
        
        [standardParameters setValue:value forKey:keyName];
        [paramPairKeys addObject:keyName];
    }
    
    NSString *parametersString = [OAuthServices queryStringFromParameters:standardParameters withEncoding:NSUTF8StringEncoding];
    
    // use URL and remove ? (always at end of URL)
    NSString *request_url = [url stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSString *oauth_consumer_secret = [OAuthSecurity retrieveOAauthConsumerSecret];
    NSString *oauth_token_secret = [token getSecret];
    NSString *baseString = [self.HTTPMethod stringByAppendingFormat:@"&%@&%@", request_url.utf8AndURLEncode, parametersString.utf8AndURLEncode];
//    NSLog(@"[iOS]Signautre Base String: %@", baseString);
    
    // append oauth token secret to consumer secret
    NSString *secretString = [oauth_consumer_secret.utf8AndURLEncode stringByAppendingFormat:@"&%@", oauth_token_secret.utf8AndURLEncode];
    NSString *oauth_signature = [OAuthServices signClearText:baseString withSecret:secretString];
    standardParameters[@"oauth_signature"] = oauth_signature;
    
    // remove symbols portion for header before doing request
    for (NSString* keyToRemove in paramPairKeys) {
        [standardParameters removeObjectForKey:keyToRemove];
    }
    
    [standardParameters removeObjectForKey:@"symbols"];
    
    NSMutableArray *parameterPairs = [NSMutableArray array];
    for (NSString *name in standardParameters) {
        NSString *aPair = [name stringByAppendingFormat:@"=\"%@\"", [standardParameters[name] utf8AndURLEncode]];
        [parameterPairs addObject:aPair];
    }
    
    parameterPairs = [NSMutableArray arrayWithArray:[parameterPairs sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSString *oAuthHeader = [@"OAuth " stringByAppendingFormat:@"%@", [parameterPairs componentsJoinedByString:@", "]];
    [self setValue:oAuthHeader forHTTPHeaderField:@"Authorization"];
    
    return YES;
}

- (BOOL)signRequestWithEmptyToken {
    NSString *url = [[self URL] absoluteString];
    NSMutableString *mutableURL = [[NSMutableString alloc] init];
    [mutableURL appendString:url];
    
    int paramPairCount = 0;
    NSDictionary *queryParams = [[self URL] queryDictionary];
    
    for (NSString *queryParam in [queryParams keyEnumerator]) {
        if (paramPairCount > 0)
            [mutableURL appendString:@"&"];
        [mutableURL appendFormat:@"%@=%@", queryParam, (NSString*)[queryParams objectForKey:queryParam]];
        paramPairCount++;
    }
    
    // oauth fields
    NSDate *dateNow = [[NSDate alloc] init];
    //Timestamp in Millis
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%lu", (unsigned long)[dateNow timeIntervalSince1970]  * 1000];
    NSString *oauth_nonce = [OAuthServices generateNonce];
    NSString *oauth_consumer_key = [OAuthSecurity retriveOAuthConsumerKey];
    
    NSString *oauth_signature_method = @"HMAC-SHA256";
    NSString *oauth_version = @"1.0";
    
    NSMutableDictionary *standardParameters = [NSMutableDictionary dictionary];
    [standardParameters setValue:oauth_consumer_key     forKey:@"oauth_consumer_key"];
    [standardParameters setValue:oauth_nonce            forKey:@"oauth_nonce"];
    [standardParameters setValue:oauth_signature_method forKey:@"oauth_signature_method"];
    [standardParameters setValue:oauth_timestamp        forKey:@"oauth_timestamp"];
    [standardParameters setValue:oauth_version          forKey:@"oauth_version"];
    
    NSMutableArray *paramPairKeys = [[NSMutableArray alloc] init];
    for (NSString *keyName in [queryParams keyEnumerator]) {
        NSString *value = (NSString*)[queryParams objectForKey:keyName];
        
        [standardParameters setValue:value forKey:keyName];
        [paramPairKeys addObject:keyName];
    }
    
    NSString *parametersString = [OAuthServices queryStringFromParameters:standardParameters withEncoding:NSUTF8StringEncoding];
    
    // use URL and remove ? (always at end of URL)
    NSString *request_url = [url stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSString *oauth_consumer_secret = [OAuthSecurity retrieveOAauthConsumerSecret];

    NSString *baseString = [self.HTTPMethod stringByAppendingFormat:@"&%@&%@", request_url.utf8AndURLEncode, parametersString.utf8AndURLEncode];
//    NSLog(@"[iOS]Signautre Base String: %@", baseString);
    
    // append oauth token secret to consumer secret
    NSString *secretString = [[oauth_consumer_secret utf8AndURLEncode] stringByAppendingFormat:@"&%@", @""];
    NSString *oauth_signature = [OAuthServices signClearText:baseString withSecret:secretString];
    standardParameters[@"oauth_signature"] = oauth_signature;
    
    // remove symbols portion for header before doing request
    for (NSString* keyToRemove in paramPairKeys) {
        [standardParameters removeObjectForKey:keyToRemove];
    }
    
    [standardParameters removeObjectForKey:@"symbols"];
    
    NSMutableArray *parameterPairs = [NSMutableArray array];
    for (NSString *name in standardParameters) {
        NSString *aPair = [name stringByAppendingFormat:@"=\"%@\"", [standardParameters[name] utf8AndURLEncode]];
        [parameterPairs addObject:aPair];
    }
    
    parameterPairs = [NSMutableArray arrayWithArray:[parameterPairs sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSString *oAuthHeader = [@"OAuth " stringByAppendingFormat:@"%@", [parameterPairs componentsJoinedByString:@", "]];
    [self setValue:oAuthHeader forHTTPHeaderField:@"Authorization"];
    
    return YES;
}

@end