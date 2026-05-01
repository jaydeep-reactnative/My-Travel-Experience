//
//  EditprofileVC.m
//  Tourist
//
//  Created by Jd's Mac on 10/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "EditprofileVC.h"
#import "ProfileVC.h"
#import "AppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface EditprofileVC ()
{
    UIImagePickerController *pickImage;
    NSString *gender;
}
@end

@implementation EditprofileVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fbdata];
    // Do any additional setup after loading the view.
}
- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    _txtName.text=[PFUser currentUser][@"fname"];
    _txtEmail.text=[PFUser currentUser][@"email"];
    _txtCno.text=[PFUser currentUser][@"cno"];
    _txtStatus.text=[PFUser currentUser][@"status"];
    gender=[PFUser currentUser][@"gender"];
    [self displayProfileImage];
}
- (IBAction)btnChangeProfileImg:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _imgChangeProfileImg.image = chosenImage;
    
    NSData* aData = UIImageJPEGRepresentation(_imgChangeProfileImg.image, 0.0f);
    NSLog(@"Image size:%.2f kb",[aData length]/1024.0f);
    PFFile *imageFile = [PFFile fileWithData:aData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *  error) {
        if (!error) {
            PFUser *aUser = [PFUser currentUser];
            [aUser setObject:imageFile.url forKey:@"profile_image"];
            
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if(succeeded){
                    NSLog(@"succeeded");
                    [aUser saveInBackground];
                    
                }else{
                    NSLog(@"Error %@",error.description);
                }
            }];
        }
    }];
}
-(void)displayProfileImage
{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId block:^(PFObject *  object, NSError *  error) {
        NSLog(@"Retrieved data %@",object);
        if (!error) {
            NSURL *url = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile_image"]];
            NSData *aData = [NSData dataWithContentsOfURL:url];
            _imgChangeProfileImg.image =[UIImage imageWithData:aData];
            NSLog(@"Image size:%f kb",[aData length]/1024.0f);
        }
        else
        {
            NSLog(@"Error %@",error.description);
        }
    }];
}

-(void)displayData
{
#define store cno status gender
    PFUser *objUser=[PFUser currentUser];
    
    if ([PFUser currentUser]){
        [objUser setObject:_txtCno.text forKey:@"cno"];
        [objUser setObject:_txtStatus.text forKey:@"status"];
        [objUser setObject:gender forKey:@"gender"];
    }
    [objUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if(succeeded)
         {
             [SVProgressHUD dismiss];
             NSLog(@"success");
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             NSLog(@"Error.");
         }
     }];
}
-(void)fbdata{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(200).height(200)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                _txtName.text = [result valueForKey:@"name"];
//                _txtEmail.text=[result valueForKey:@"email"];
//                gender=[result valueForKey:@"gender"];
                
                NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                NSURL *url = [[NSURL alloc]initWithString:imageStringOfLoginUser];
                [self.imgChangeProfileImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"User.png"]];
//                _imgView.layer.cornerRadius = _imgView.frame.size.width / 2;
//                _imgView.clipsToBounds = YES;
            }
        }];
    }

}
- (IBAction)barBtnDone:(UIBarButtonItem *)sender
{
    [self displayData];
}

- (IBAction)segmentGenderAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        gender = @"Male";
    }
    else
    {
        gender = @"Female";
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
