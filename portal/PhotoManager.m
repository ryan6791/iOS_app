//
//  PhotoManager.m
//  portal
//
//  Created by Neil Ballard on 10/10/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "PhotoManager.h"

@implementation PhotoManager

-(void)getFacebookProfileInfos:(int)type completion:(void (^)(void))completionBlock{
    
    //need to get
    
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields": @"id, first_name"}];
    
    self.albums = [[NSMutableArray alloc]init];
    self.photos = [[NSMutableArray alloc]init];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if(result)
        {
            
            self.userid = [result objectForKey:@"id"];
            
            if(type == 1)
            {

                                
                PhotoManager *singleton = [PhotoManager singletonInstance];
                
                NSString *aurl = @"/%@/albums";
                
                NSString *url = [NSString stringWithFormat:aurl, singleton.userid];
                
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                              initWithGraphPath:url
                                              parameters:@{@"fields": @"name"}
                                              HTTPMethod:@"GET"];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                      id result,
                                                      NSError *error) {
        
                    NSArray *data =  result[@"data"];
                    NSDictionary *albums_id;
                    for(albums_id in data) {
                        PhotoManager *albumObject = [[PhotoManager alloc] init];
                        albumObject.album_id = (NSString*)[albums_id objectForKey:@"id"];
                        albumObject.album_name = (NSString*)[albums_id objectForKey:@"name"];
                      //  NSLog(@"%@", albumObject.album_name);
                        [singleton.albums addObject: albumObject];
                    }
                    
                    completionBlock();
                    
                }];
            }
            else if(type == 2)
            {
                
                PhotoManager *singleton = [PhotoManager singletonInstance];
                 
                 NSString *aurl = @"/%@/photos";
                 
                 NSString *url = [NSString stringWithFormat:aurl, self.album_id];
                 
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                 initWithGraphPath:url
                 parameters:@{@"fields": @"images"}
                 HTTPMethod:@"GET"];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                 id result,
                 NSError *error) {
                
                  //   NSLog(@"%@", result);
                     
                
            
                 NSArray *data =  result[@"data"];
                     
                     NSLog(@"%@", data);
                
                
                 NSDictionary *albums_id;
                for(albums_id in data) {
                PhotoManager *albumObject = [[PhotoManager alloc] init];
                 albumObject.photo_id = (NSString*)[albums_id objectForKey:@"id"];
                 NSArray *images = [albums_id objectForKey:@"images"];
                    
                // (NSString*)[albums_id objectForKey:@"source"]
                  
                    NSDictionary *dict;
          //           NSLog(@"%@", albumObject.photo);
                for(dict in images){
                 //    NSLog(@"%@", dict);
                    NSString *photo = [dict valueForKey:@"height"];

                    int height = [photo intValue];
                    
                    if (height < 200) {
                        NSString *data = [dict valueForKey:@"source"];
             //           NSLog(@"%@", albumObject.photo);
                        albumObject.photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data]]];
                        
                    }
                    
                    if ((height > 500) && (height < 600)) {
                        NSString *data = [dict valueForKey:@"source"];
                        //           NSLog(@"%@", albumObject.photo);
                        albumObject.fullSizePhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data]]];
                        
                    }
                    
                 }
           //         NSLog(@"%@", albumObject.photo_id);
         //            NSLog(@"%@", albumObject.photo);
                 [singleton.photos addObject: albumObject];
                 }
                     NSLog(@"%u", [singleton.photos count]);
                 completionBlock();
                 
                 }];
                 
                
            }
            
            
        }
        
    }];
    
    [connection start];
}


-(void)getAlbums{
    

    
}


-(void)getPhoto{
    
    NSString *url = [@"/" stringByAppendingString:self.photo_id];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:url
                                  parameters:@{@"fields": @"link"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        
        
    }];
    
}


-(void)getPhotos{
    
    NSString *aurl = @"/%@/photos";
    
    NSString *url = [NSString stringWithFormat:aurl, self.album_id];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:url
                                  parameters:@{@"fields": @"images"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSLog(@"%@", result);
        
    }];
    
}


+ (id)singletonInstance {
    
    static PhotoManager *sharedOTTODataAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOTTODataAccess = [[self alloc] init];
    });
    
    return sharedOTTODataAccess;
    
}

@end
