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
@property (nonatomic, unsafe_unretained) BOOL useFB;
@property (nonatomic, unsafe_unretained) BOOL fbPublic;
@property (nonatomic, unsafe_unretained) BOOL instagramPublic;
@property (nonatomic, unsafe_unretained) BOOL linkedinPublic;
@property (nonatomic, unsafe_unretained) BOOL snapchatPublic;







- (BOOL)UserIsLoggedIn;
- (void)setUserLoginStatus:(BOOL)status;
+ (id)singletonInstance;
- (void)persistToUserDefaults;
- (void)initUserDefaults;
-(void)setProfileImage:(UIImage*)image;
- (void)setProfileImageStatus:(BOOL)status;
- (BOOL)ProfileImageIsSet;
-(UIImage*)getProfileImage;

- (BOOL)LoggedInWithFB;
- (BOOL)LoggedInWithLinkedin;

- (void)setisLoggedInWithLinkedin:(BOOL)status;
- (void)setisLoggedInWithFB:(BOOL)status;

- (BOOL)AddedFB;
- (BOOL)AddedLinkedin;

- (void)setAddedLinkedin:(BOOL)status;
- (void)setAddedFB:(BOOL)status;


- (void)setUsefbOptionStatus:(BOOL)status;
- (BOOL)useFBOption;

- (void)setUselinkedinOptionStatus:(BOOL)status;
- (BOOL)uselinkedinOption;


- (void)setfbPublicStatus:(BOOL)status;
- (BOOL)fbIsPublic;

- (void)setinstagramPublicStatus:(BOOL)status;
- (BOOL)instagramIsPublic;

- (void)setlinkedinPublicStatus:(BOOL)status;
- (BOOL)linkedinIsPublic;

- (void)setsnapchatPublicStatus:(BOOL)status;
- (BOOL)snapchatIsPublic;

-(void)setFacebook:network;
-(NSString*)getFacebook;
-(void)setInstagram:network;
-(NSString*)getInstagram;
-(void)setLinkedin:network;
-(NSString*)getLinkedin;
-(void)setSnapchat:network;
-(NSString*)getSnapchat;

-(void)setName:name;
-(NSString*)getName;
    
    
@end
