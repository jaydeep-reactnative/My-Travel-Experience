//
//  UploadVC.h
//  Tourist
//
//  Created by Jd's Mac on 06/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<GoogleMaps/GoogleMaps.h>
@interface UploadVC : UIViewController<UITextFieldDelegate,GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtCaption;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UIButton *outletUploadImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionImages;


- (IBAction)onLaunchClicked:(UIButton *)sender;
- (IBAction)barBtnUpload:(UIBarButtonItem *)sender;
- (IBAction)btnTagFriend:(UIButton *)sender;
- (IBAction)btnUploadImage:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *arrayOfImages;

@end
