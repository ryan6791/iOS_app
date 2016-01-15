//
//  DataAccess.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface DataAccess : NSObject <NSCoding>


@property (nonatomic, unsafe_unretained) BOOL IsLoggedIn;
@property (nonatomic, unsafe_unretained) BOOL isProfileImageSet;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, unsafe_unretained) BOOL isProfileImageSet2;
@property (nonatomic, strong) UIImage *profileImage2;
@property (nonatomic, unsafe_unretained) BOOL isProfileImageSet3;
@property (nonatomic, strong) UIImage *profileImage3;
@property (nonatomic, unsafe_unretained) BOOL isProfileImageSet4;
@property (nonatomic, strong) UIImage *profileImage4;

@property (nonatomic, unsafe_unretained) BOOL isMatchImageSet;
@property (nonatomic, strong) UIImage *matchImage;








- (BOOL)UserIsLoggedIn;
- (void)setUserLoginStatus:(BOOL)status;
+ (id)singletonInstance;
- (void)persistToUserDefaults;
- (void)initUserDefaults;
-(void)setProfileImage:(UIImage*)image;
- (void)setProfileImageStatus:(BOOL)status;
- (BOOL)ProfileImageIsSet;
-(UIImage*)getProfileImage;



-(void)setProfileImage2:(UIImage*)image;
- (void)setProfileImageStatus2:(BOOL)status;
- (BOOL)ProfileImageIsSet2;
-(UIImage*)getProfileImage2;

-(void)setProfileImage3:(UIImage*)image;
- (void)setProfileImageStatus3:(BOOL)status;
- (BOOL)ProfileImageIsSet3;
-(UIImage*)getProfileImage3;

-(void)setProfileImage4:(UIImage*)image;
- (void)setProfileImageStatus4:(BOOL)status;
- (BOOL)ProfileImageIsSet4;
-(UIImage*)getProfileImage4;

- (BOOL)LoggedInWithFB;

- (void)setisLoggedInWithFB:(BOOL)status;

-(void)setFacebook:(NSString*)network;
-(NSString*)getFacebook;


-(void)setName:name;
-(NSString*)getName;


//Matches data
- (BOOL)UserHasMatch;
- (void)setUserMatchStatus:(BOOL)status;

-(void)setMatchName:name;
-(NSString*)getMatchName;

-(void)setMatchImage:(UIImage*)image;
- (void)setMatchProfileImageStatus:(BOOL)status;
- (BOOL)matchImageIsSet;
-(UIImage*)getMatchImage;


@end
