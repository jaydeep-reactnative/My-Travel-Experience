//
//  SettingsVC.m
//  Tourist
//
//  Created by Jd's Mac on 13/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "SettingsVC.h"
#import "LogIn.h"
#import "ChangepwdVC.h"
#import "EditprofileVC.h"
#import "PrivacypolicyVC.h"
#import "AboutusVC.h"
#import "LinkedaccVC.h"


@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"changepwd"];
    }
    else if (indexPath.row == 1){
        cell=[tableView dequeueReusableCellWithIdentifier:@"editprofile"];
    }
    else if (indexPath.row == 2){
        cell=[tableView dequeueReusableCellWithIdentifier:@"linkedacc"];
    }
    else if (indexPath.row == 3){
        cell=[tableView dequeueReusableCellWithIdentifier:@"privacypolicy"];
    }
    else if (indexPath.row == 4){
        cell=[tableView dequeueReusableCellWithIdentifier:@"aboutus"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        ChangepwdVC *objChangepwd=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangepwdVC"];
            [self.navigationController pushViewController:objChangepwd animated:YES];
    }
    else if (indexPath.row==1){
        EditprofileVC *objEditprofile=[self.storyboard instantiateViewControllerWithIdentifier:@"EditprofileVC"];
        [self.navigationController pushViewController:objEditprofile animated:YES];
    }
    else if (indexPath.row==2){
        LinkedaccVC *objLinkedacc=[self.storyboard instantiateViewControllerWithIdentifier:@"LinkedaccVC"];
        [self.navigationController pushViewController:objLinkedacc animated:YES];
    }
    else if (indexPath.row==3){
        PrivacypolicyVC *objPrivacypolicy=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacypolicyVC"];
        [self.navigationController pushViewController:objPrivacypolicy animated:YES];
    }
    else if (indexPath.row==4){
        AboutusVC *objAboutus=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutusVC"];
        [self.navigationController pushViewController:objAboutus animated:YES];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnLogout:(UIButton *)sender {
    [PFUser logOut];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logged_in"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}
@end
