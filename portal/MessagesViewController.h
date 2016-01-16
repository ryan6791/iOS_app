//
//  MessagesViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/15/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "JSQMessages.h"

#import "ModelData.h"
#import "NSUserDefaults+Settings.h"


@class MessagesViewController;

@protocol JSQViewControllerDelegate <NSObject>

- (void)didDismissJSQViewController:(MessagesViewController *)vc;

@end




@interface MessagesViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate>

@property (weak, nonatomic) id<JSQViewControllerDelegate> delegateModal;

@property (strong, nonatomic) ModelData *data;

- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;

@end

