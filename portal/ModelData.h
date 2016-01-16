//
//  ModelData.h
//  pairedUP
//
//  Created by Neil Ballard on 1/15/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "JSQMessages.h"

/**
 *  This is for /testing purposes only.
 *  This object sets up some fake model data.
 *  Do not actually do anything like this.
 */




static NSString * const kJSQAvatarIdCook = @"468-768355-23123";
static NSString * const kJSQAvatarIdWoz = @"309-41802-93823";



@interface ModelData : NSObject

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSDictionary *users;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *matchName;



- (void)addPhotoMediaMessage;

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)addVideoMediaMessage;

@end

