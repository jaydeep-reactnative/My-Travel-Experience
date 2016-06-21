//
//  ProfileVC.m
//  Tourist
//
//  Created by Jd's Mac on 06/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "ProfileVC.h"
#import "SettingsVC.h"
#import "EditprofileVC.h"
@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fbdata];
    [self.btnFollow setTitle:@"Follow"
                    forState:UIControlStateNormal];
    [self.btnFollow setTitle:@"Unfollow"
                    forState:UIControlStateSelected];
    
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self displayProfileImage];
    _lblStatus.text=[PFUser currentUser][@"status"];
    _lblName.text=[PFUser currentUser][@"fname"];
    _lblUsername.text=[PFUser currentUser][@"username"];
}

#pragma mark - Display profile image from database
-(void)displayProfileImage
{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId block:^(PFObject *  object, NSError *  error) {
        NSLog(@"Retrieved data %@",object);
        if (!error) {
            NSURL *url = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile_image"]];
            NSData *aData = [NSData dataWithContentsOfURL:url];
            _imgProfileImg.image =[UIImage imageWithData:aData];
            NSLog(@"Image size:%f kb",[aData length]/1024.0f);
        }
        else
        {
            NSLog(@"Error %@",error.description);
        }
    }];
}
#pragma mark - Get profile image from facebook
-(void)fbdata{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(200).height(200)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error)
            {
                NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                NSURL *url = [[NSURL alloc]initWithString:imageStringOfLoginUser];
                [self.imgProfileImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"User.png"]];
            }
        }];
    }
    
}
#pragma mark - Button edit profile
- (IBAction)btnEditprofile:(UIButton *)sender
{
    EditprofileVC *objEditprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"EditprofileVC"];
    [self.navigationController pushViewController:objEditprofile animated:NO];
}
#pragma mark - Bar button settings
- (IBAction)barBtnSettings:(UIBarButtonItem *)sender
{
    SettingsVC *objSettingsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    [self.navigationController pushViewController:objSettingsVC animated:NO];
}
- (IBAction)btnFollow:(UIButton *)sender
{
    
    sender.selected = !sender.isSelected;
}
@end
