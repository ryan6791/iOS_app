//
//  NSUserDefaults+Settings.m
//  pairedUP
//
//  Created by Neil Ballard on 1/15/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "NSUserDefaults+Settings.h"

static NSString * const kSettingExtraMessages = @"kSettingExtraMessages";
static NSString * const kSettingLongMessage = @"kSettingLongMessage";
static NSString * const kSettingEmptyMessages = @"kSettingEmptyMessages";
static NSString * const kSettingSpringiness = @"kSettingSpringiness";
static NSString * const kSettingIncomingAvatar = @"kSettingIncomingAvatar";
static NSString * const kSettingOutgoingAvatar = @"kSettingOutgoingAvatar";


@implementation NSUserDefaults (DemoSettings)

+ (void)saveExtraMessagesSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingExtraMessages];
}

+ (BOOL)extraMessagesSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingExtraMessages];
}

+ (void)saveLongMessageSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingLongMessage];
}

+ (BOOL)longMessageSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingLongMessage];
}

+ (void)saveEmptyMessagesSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingEmptyMessages];
}

+ (BOOL)emptyMessagesSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingEmptyMessages];
}

+ (void)saveSpringinessSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingSpringiness];
}

+ (BOOL)springinessSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingSpringiness];
}

+ (void)saveOutgoingAvatarSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingOutgoingAvatar];
}

+ (BOOL)outgoingAvatarSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingOutgoingAvatar];
}

+ (void)saveIncomingAvatarSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingIncomingAvatar];
}

+ (BOOL)incomingAvatarSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingIncomingAvatar];
}

@end
