//
//  OAuthToken.m
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import "OAuthToken.h"

@interface OAuthToken()

@property (nonatomic, unsafe_unretained) int type;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *secret;

@end

@implementation OAuthToken

+ (id)tokenWithDictionary:(NSDictionary*)dictionary andType:(int)type {
    OAuthToken *token = [[OAuthToken alloc] initWithType:type andKey:[dictionary objectForKey:@"oauthToken"] andSecret:[dictionary objectForKey:@"oauthTokenSecret"]];
    return token;
}

-(id) initWithType:(int)type {
    self = [super init];
    
    self.type = type;
    
    return self;
}

-(id) initWithType:(int)type andKey:(NSString*)key andSecret:(NSString*)secret {
    self = [self initWithType:type];
    self.key = key;
    self.secret = secret;
    
    return self;
}

-(int)getType {
    return self.type;
}

-(NSString*)getKey{
    return self.key;
}

-(NSString*)getSecret{
    return self.secret;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super init])) {
        self.type = [aDecoder decodeIntForKey:@"tokenType"];
        self.key = [aDecoder decodeObjectForKey:@"tokenKey"];
        self.secret = [aDecoder decodeObjectForKey:@"tokenSecret"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:self.type forKey:@"tokenType"];
    [aCoder encodeObject:self.key forKey:@"tokenKey"];
    [aCoder encodeObject:self.secret forKey:@"tokenSecret"];
}

- (BOOL)isEqual:(id)object {
    OAuthToken *token = (OAuthToken*)object;
    
    if([self.key isEqualToString:token.key] &&  [self.secret isEqualToString:token.secret] && self.type == token.type) {
        return YES;
    }
    
    return NO;
}

@end
