//
//  ProfileVC.h
//  Tourist
//
//  Created by Jd's Mac on 06/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController
- (IBAction)btnEditprofile:(UIButton *)sender;
- (IBAction)barBtnSettings:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileImg;
- (IBAction)btnFollow:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;



@end
