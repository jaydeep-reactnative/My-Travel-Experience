//
//  SignUp.h
//  Tourist
//
//  Created by Jd's Mac on 05/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController<UITextFieldDelegate>
- (IBAction)btnLogin:(UIButton *)sender;
- (IBAction)btnSignup:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFname;
@property (weak, nonatomic) IBOutlet UITextField *txtLname;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPass;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@end
