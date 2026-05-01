//
//  SignUp.m
//  Tourist
//
//  Created by Jd's Mac on 05/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "SignUp.h"
#import "LogIn.h"

@interface SignUp ()

@end

@implementation SignUp

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login button
- (IBAction)btnLogin:(UIButton *)sender
{
    for (UIViewController *objLogin in self.navigationController.viewControllers)
    {
        if ([objLogin isKindOfClass:[LogIn class]])
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
    }
}

#pragma mark - Username validation
-(BOOL) isValidUsername:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[a-z0-9]+";
    NSString *laxString = @"[a-z0-9]+";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Email validation
-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Signup button
- (IBAction)btnSignup:(UIButton *)sender
{
    if (_txtUsername.text.length == 0 || _txtFname.text.length == 0 || _txtLname.text.length == 0 || _txtPassword.text.length == 0 || _txtConfirmPass.text.length == 0 || _txtEmail.text.length == 0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Text field error" message:@"Please fill up the informaiton" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self isValidUsername:_txtUsername.text]== NO)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Username error" message:@"All letters must be small.                          Special characters not allowed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                    _txtUsername.text=@"";
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self isValidEmail:_txtEmail.text]== NO)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"E-Mail address error" message:@"Enter valid e-maill Address" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                    _txtEmail.text=@"";
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if (![_txtPassword.text isEqualToString:_txtConfirmPass.text])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Password error" message:@"Password doesn't match" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _txtPassword.text=@"";
                                 _txtConfirmPass.text=@"";
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(_txtPassword.text.length < 6)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Password error" message:@"Password length must be 6 character" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                    _txtPassword.text=@"";
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [SVProgressHUD show];
        PFUser *objUser = [[PFUser alloc]init];
        [objUser setUsername:_txtUsername.text];
        [objUser setEmail:_txtEmail.text];
        [objUser setPassword:_txtPassword.text];
        [objUser setObject:_txtFname.text forKey:@"fname"];
        [objUser setObject:_txtLname.text forKey:@"lname"];
        
        
        
        //        [aUser setObject:gender forKey:@"Gender"];
        //        [aUser setObject:txtMobNo.text forKey:@"MobileNo"];
        
        [objUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if(succeeded)
             {
                 [SVProgressHUD dismiss];
                 NSLog(@"Welcome to hell");
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 NSLog(@"Error.");
             }
         }];
        [SVProgressHUD dismiss];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
