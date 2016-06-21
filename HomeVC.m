//
//  HomeVC.m
//  Tourist
//
//  Created by Jd's Mac on 06/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "HomeVC.h"
#import "customCellHome.h"
#import "CalsiVC.h"
#import "EditprofileVC.h"
#import "UIKit+AFNetworking.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mutArrUploadedImg;
    NSMutableArray *mutArrName;
    NSMutableArray *mutArrUname;
    NSMutableArray *mutArrCaption;
    NSMutableArray *mutArrImgprofile;
    NSMutableArray *mutArray;
    NSMutableArray *arrAdDetail;
}
@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
//        mutArray = [[NSMutableArray alloc]init];
//    mutArrImgprofile=[NSMutableArray arrayWithObjects:@"t1.png",@"t2.png",@"t3.png",@"t4.png",@"t5.png",@"t6.png",@"t7.png",@"t8.png",@"t9.png",@"t10.png",nil];
//    mutArrUploadedImg=[NSMutableArray arrayWithObjects:@"t10.png",@"t9.png",@"t8.png",@"t7.png",@"t6.png",@"t5.png",@"t4.png",@"t3.png",@"t2.png",@"t1.png",nil];
//    mutArrName=[NSMutableArray arrayWithObjects:@"Rajesh",@"Kamlesh",@"Suresh",@"Vishal",@"Milan",@"Ishan",@"Ravi",@"Krishana",@"Kavita",@"Pradip", nil];
//    mutArrUname=[NSMutableArray arrayWithObjects:@"@Rajesh21",@"@Kamlesh34",@"@Suresh45",@"@Vishal56",@"@Milan54",@"@Ishan78",@"@Ravi54",@"@Krishana43",@"@Kavita43",@"@Pradip90",nil];
//    mutArrCaption=[NSMutableArray arrayWithObjects:@"Hi",@"Hello",@"How r u",@"Fine",@"Thanks",@"Nice",@"Osam",@"Delicious",@"Nice one",@"Beautiful", nil];
//        [mutArray addObject:mutArrImgprofile];
//        [mutArray addObject:mutArrUploadedImg];
//        [mutArray addObject:mutArrName];
//        [mutArray addObject:mutArrUname];
//        [mutArray addObject:mutArrUploadedImg];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.outletTableVw addSubview:self.refreshControl];
    
}

- (void)reloadData
{
    // Reload table data
    [_outletTableVw reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    
        [self.refreshControl endRefreshing];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrAdDetail.count;
}
-(void)loadData
{
    if ([AFNetworkReachabilityManager sharedManager].isReachable)
    {
        [SVProgressHUD show];
        
        PFQuery *query = [PFQuery queryWithClassName:@"post"];
        arrAdDetail = [[NSMutableArray alloc] init];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            [SVProgressHUD dismiss];
            if (!error) {
                // The find succeeded.
                if (arrAdDetail.count>0) {
                    [arrAdDetail removeAllObjects];
                }
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count); [arrAdDetail addObjectsFromArray:objects];
                [self reloadData];
                
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    else
    {
//        L2FCustomAlert(InternetNotAvilable);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customCellHome *objCustomcell=(customCellHome *)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    objCustomcell.lblName.text = arrAdDetail[indexPath.row][@"name"];
    objCustomcell.lblUsername.text = arrAdDetail[indexPath.row][@"username"];
    objCustomcell.lblCaption.text = arrAdDetail[indexPath.row][@"caption"];
    objCustomcell.lblPlaceName.text=arrAdDetail[indexPath.row][@"location"];
    NSURL *url = [NSURL URLWithString:arrAdDetail[indexPath.row][@"profile_imgwall"]];
    [objCustomcell.imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"User.png"]];
    
//    objCustomcell.imgUploadImg.image =arrAdDetail[indexPath.row][@"images"];
    
    //Image Slider
    for (id subViews in objCustomcell.scrollvwHome.subviews)
    {
        if ([subViews isKindOfClass:[UIImageView class]])
        {
            [subViews removeFromSuperview];
        }
    }
    //    if (indexPath.row == 0) {
    int xpos = 0;
    for (int i = 0 ; i < [arrAdDetail[indexPath.row][@"images"] count]; i++)
    {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xpos,0, 400, objCustomcell.scrollvwHome.frame.size.height)];
        NSURL *url = [NSURL URLWithString:arrAdDetail[indexPath.row][@"images"][i]];
        [imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"User.png"]];
       // imgView.image = [UIImage imageNamed:[mutArrUploadedImg objectAtIndex:i]];
        [objCustomcell.scrollvwHome addSubview:imgView];
        xpos += 400;
    }
    [objCustomcell.scrollvwHome setContentSize:CGSizeMake(xpos, 261)];
    //    }
    return objCustomcell;
}

#pragma mark - Bar button Calsi
- (IBAction)barbtnCalsi:(UIBarButtonItem *)sender
{
    CalsiVC *objCalsi=[self.storyboard instantiateViewControllerWithIdentifier:@"CalsiVC"];
    [self.navigationController pushViewController:objCalsi animated:YES];
}
@end
