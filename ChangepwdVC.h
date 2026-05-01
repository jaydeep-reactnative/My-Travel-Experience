//
//  ChangepwdVC.h
//  Tourist
//
//  Created by Jd's Mac on 14/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangepwdVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtNewPass;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPass;
- (IBAction)btnChangePassword:(UIButton *)sender;
@end
