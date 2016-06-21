//
//  customCellHome.h
//  Tourist
//
//  Created by indianic on 14/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface customCellHome : UITableViewCell<EDStarRatingProtocol>
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UIImageView *imgUploadImg;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblCaption;
@property (weak, nonatomic) IBOutlet UIView *vwSubview;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblTagfriend;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnTagfriend;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollvwHome;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceName;

@end
