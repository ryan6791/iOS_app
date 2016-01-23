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
#import "DMPagerViewController.h"



@class MessagesViewController;

@protocol JSQViewControllerDelegate <NSObject>

- (void)didDismissJSQViewController:(MessagesViewController *)vc;

@end




@interface MessagesViewController : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate, DMPagerViewControllerProtocol>

@property (weak, nonatomic) id<JSQViewControllerDelegate> delegateModal;

@property (strong, nonatomic) ModelData *data;

- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;

@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;

@end

