//
//  ModelData.m
//  pairedUP
//
//  Created by Neil Ballard on 1/15/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "ModelData.h"
#import "DataAccess.h"
#import "NSUserDefaults+Settings.h"


/**
 *  This is for /testing purposes only.
 *  This object sets up some fake model data.
 *  Do not actually do anything like this.
 */

@implementation ModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userName = [[DataAccess singletonInstance] getName];
        self.matchName = [[DataAccess singletonInstance] getMatchName];
        
        if ([NSUserDefaults emptyMessagesSetting]) {
            self.messages = [NSMutableArray new];
        }
        else {
            [self loadFakeMessages];
        }
        
        
        /**
         *  Create avatar images once.
         *
         *  Be sure to create your avatars one time and reuse them for good performance.
         *
         *  If you are not using avatars, ignore this.
         */
        
       UIImage *avatar_image = [[DataAccess singletonInstance] getProfileImage];
        UIImage *match_image = [[DataAccess singletonInstance] getMatchImage];


        
        JSQMessagesAvatarImage *cookImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:avatar_image
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        

        
        JSQMessagesAvatarImage *wozImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:match_image
                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        self.avatars = @{ kJSQAvatarIdCook : cookImage,
                          kJSQAvatarIdWoz : wozImage };
        
        
        self.users = @{
                        kJSQAvatarIdCook : self.userName,
                        kJSQAvatarIdWoz : self.matchName, };
        
        
        /**
         *  Create message bubble images objects.
         *
         *  Be sure to create your bubble images one time and reuse them for good performance.
         *
         */
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }
    
    return self;
}

- (void)loadFakeMessages
{
    /**
     *  Load some fake messages for .
     *
     *  You should have a mutable array or orderedSet, or something.
     */
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdCook
                                        senderDisplayName:self.userName
                                                     date:[NSDate distantPast]
                                                     text:@"Hey how's it going?"],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdWoz
                                        senderDisplayName:self.matchName
                                                     date:[NSDate distantPast]
                                                     text:@"Good"],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdCook
                                        senderDisplayName:self.userName
                                                     date:[NSDate distantPast]
                                                     text:@"Oh nice! Do you have any big plans for the weekend? I'm thinking about going to the mountain myself."],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdWoz
                                        senderDisplayName:self.matchName
                                                     date:[NSDate date]
                                                     text:@"I don't really like weekends"],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdCook
                                        senderDisplayName:self.userName
                                                     date:[NSDate date]
                                                     text:@"haha Ohhh ya why is that?"],
                     
                     [[JSQMessage alloc] initWithSenderId:kJSQAvatarIdWoz
                                        senderDisplayName:self.matchName
                                                     date:[NSDate date]
                                                     text:@"idk"],
                     nil];
    
  //  [self addPhotoMediaMessage];
    
    /**
     *  Setting to load extra messages for testing/
     */
    if ([NSUserDefaults extraMessagesSetting]) {
        NSArray *copyOfMessages = [self.messages copy];
        for (NSUInteger i = 0; i < 4; i++) {
            [self.messages addObjectsFromArray:copyOfMessages];
        }
    }
    
    
    /**
     *  Setting to load REALLY long message for testing/
     *  You should see "END" twice
     */
    if ([NSUserDefaults longMessageSetting]) {
        JSQMessage *reallyLongMessage = [JSQMessage messageWithSenderId:kJSQAvatarIdCook
                                                            displayName:self.userName
                                                                   text:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END"];
        
        [self.messages addObject:reallyLongMessage];
    }
}

- (void)addPhotoMediaMessage
{
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"goldengate"]];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:kJSQAvatarIdCook
                                                   displayName:self.userName
                                                         media:photoItem];
    [self.messages addObject:photoMessage];
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion
{
    CLLocation *ferryBuildingInSF = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];
    
    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    [locationItem setLocation:ferryBuildingInSF withCompletionHandler:completion];
    
    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:kJSQAvatarIdCook
                                                      displayName:self.userName
                                                            media:locationItem];
    [self.messages addObject:locationMessage];
}

- (void)addVideoMediaMessage
{
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJSQAvatarIdCook
                                                   displayName:self.userName
                                                         media:videoItem];
    [self.messages addObject:videoMessage];
}






@end