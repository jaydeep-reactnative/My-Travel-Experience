//
//  ChangepwdVC.m
//  Tourist
//
//  Created by Jd's Mac on 14/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "ChangepwdVC.h"

@interface ChangepwdVC ()


@end

@implementation ChangepwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#define Password changed
-(void)cloudChangePass
{
    NSLog(@"LITERALLY CHANGING PASSWORD");
    
    if (![_txtNewPass.text isEqualToString:_txtConfirmPass.text]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Password error"
                                      message:@"Password doesn't match"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                _txtNewPass.text=@"";
                                _txtConfirmPass.text=@"";
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if(_txtNewPass.text.length<6)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Password error" message:@"Password length must be 6 character" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _txtNewPass.text=@"";
                                 _txtConfirmPass.text=@"";
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
    [PFUser currentUser].password = self.txtNewPass.text;
    [[PFUser currentUser] saveInBackgroundWithBlock:
     ^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             [self txtNewPass];
             UIAlertController * alert=   [UIAlertController
                                           alertControllerWithTitle:@"Congratulations!!!!"
                                           message:@"Password changed successfully"
                                           preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction* ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      //Do some thing here
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
                                  }];
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
             return;
         }
         else
         {
         
         }
         
     }];
    }
}
- (IBAction)btnChangePassword:(UIButton *)sender {
    [self cloudChangePass];
}
@end
