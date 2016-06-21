//
//  EditprofileVC.h
//  Tourist
//
//  Created by Jd's Mac on 10/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditprofileVC : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)barBtnDone:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgChangeProfileImg;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCno;
- (IBAction)btnChangeProfileImg:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentGender;
- (IBAction)segmentGenderAction:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
 
@end
