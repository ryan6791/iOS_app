//
//  AlbumsTableViewController.m
//  portal
//
//  Created by Neil Ballard on 10/11/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "AlbumsTableViewController.h"
#import "PhotoManager.h"
#import "DeviceManager.h"
#import "PhotosCollectionViewController.h"

@interface AlbumsTableViewController ()

@property (nonatomic, retain) UIActivityIndicatorView * activityindicator;
@property (strong, nonatomic) PhotoManager *album;



@end

@implementation AlbumsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*
     self.refreshControl = [[UIRefreshControl alloc] init];
     [self.refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
     
     self.activityindicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((view.frame.size.width/2) - 15, (view.frame.size.height/2) - 15, 30, 30)];
     [self.activityindicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
     [self.activityindicator setColor:[UIColors white]];
     [self.activityindicator startAnimating];
     [self.view addSubview:self.activityindicator];
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
dispatch_async(dispatch_get_main_queue(), ^{
    
        PhotoManager *albums = [PhotoManager singletonInstance];
        [albums getFacebookProfileInfos:1 completion:^{
            
            
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
           //         [self.tableView reloadData];
                    
                    
            
        }];
                               });


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PhotoManager *albums = [PhotoManager singletonInstance];
    return [albums.albums count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

        PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] albums] objectAtIndex:indexPath.row];
        cell.textLabel.text = album.album_name;
        UIFont *font;
        CGFloat indent = 0.0;
        if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(36/2)];
            indent = ceilf(30/2);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(42/2)];
            indent = ceilf(34/2);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(70/3)];
            indent = ceilf(58/3);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(35/2)];
            indent = ceilf(35/2);
        }
        
        cell.textLabel.font = font;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    return NO;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] albums] objectAtIndex:indexPath.row];
    
    PhotoManager *instance = [PhotoManager singletonInstance];
    
    instance.album_id = album.album_id;
    
    NSLog(@"%@", album.album_id);
    
    PhotoManager *albums = [PhotoManager singletonInstance];
    [albums getFacebookProfileInfos:2 completion:^{
        
       // PhotosCollectionViewController *photos = [[PhotosCollectionViewController alloc] init];
       // [self.navigationController pushViewController:photos animated:YES];
        
        NSString * storyboardName = @"Main2";
        NSString * viewControllerID = @"PhotosCollectionViewController";
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        PhotosCollectionViewController * controller = (PhotosCollectionViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    
    


}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
