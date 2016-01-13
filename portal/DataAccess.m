//
//  DataAccess.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "DataAccess.h"

@implementation DataAccess



#pragma mark - Account Methods

- (BOOL)UserIsLoggedIn {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]) {
        return YES;
    }
    return NO;
}

- (void)setUserLoginStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"isLoggedIn"];
}

- (void)setProfileImageStatus:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus2:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet2 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus3:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet3 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}

- (void)setProfileImageStatus4:(BOOL)status {
    DataAccess *Data = [DataAccess singletonInstance];
    Data.isProfileImageSet = status;
    [Data persistToUserDefaults];
}

- (BOOL)ProfileImageIsSet4 {
    DataAccess *Data = [DataAccess singletonInstance];
    return Data.isProfileImageSet;
}


- (void)setisLoggedInWithFB:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"LoggedInWithFB"];
}

- (BOOL)LoggedInWithFB {
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"LoggedInWithFB"]) {
        return YES;
    }
    
    return NO;
}




-(void)setProfileImage:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage2:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage2{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage2"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage3:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage3{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage3"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

-(void)setProfileImage4:(UIImage*)image{
    
    DataAccess *Data = [DataAccess singletonInstance];
    Data.profileImage = image;
    [Data persistToUserDefaults];
    
    
}

-(UIImage*)getProfileImage4{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage4"];
    UIImage* image = [UIImage imageWithData:imageData];
    return image;
    
}

#pragma - user info

-(void)setName:(id)name{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"username"];
    
}

-(NSString*)getName{
    
    NSString *name = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"username"];
    
    return name;
}


#pragma - social networks

-(void)setFacebook:(NSString*)network{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:network forKey:@"facebook_id"];
    
}

-(NSString*)getFacebook{
    
    NSString *network = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"facebook_id"];
    
    return network;
}




#pragma mark - NSCoding serialization

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    DataAccess *singletonInstance = [DataAccess singletonInstance];
    
    BOOL loggedInStatus = [aDecoder decodeBoolForKey:@"LoggedInStatus"];
    [singletonInstance setUserLoginStatus:loggedInStatus];
    
    BOOL profileImageStatus = [aDecoder decodeBoolForKey:@"ProfileImageIsSet"];
    [singletonInstance setProfileImageStatus:profileImageStatus];
    
    UIImage *ProfileImage = [aDecoder decodeObjectForKey:@"ProfileImage"];
    [singletonInstance setProfileImage:ProfileImage];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    DataAccess *singletonInstance = [DataAccess singletonInstance];
    
    [aCoder encodeBool:[singletonInstance UserIsLoggedIn] forKey:@"LoggedInStatus"];
    
    [aCoder encodeBool:[singletonInstance isProfileImageSet] forKey:@"ProfileImageIsSet"];
    
    
    
    
}


- (void)persistToUserDefaults {
    if(!self){
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DataAccess"];
    
}


- (void)initUserDefaults {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataAccess"];
    
    [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - Singleton Methods
+ (id)singletonInstance {
    
    static DataAccess *sharedOTTODataAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOTTODataAccess = [[self alloc] init];
    });
    
    return sharedOTTODataAccess;
    
}

@end
