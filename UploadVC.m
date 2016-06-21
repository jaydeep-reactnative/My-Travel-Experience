//
//  UploadVC.m
//  Tourist
//
//  Created by Jd's Mac on 06/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//
#import "UploadVC.h"
#import<GoogleMaps/GoogleMaps.h>
#import "customCellUploadImg.h"
@interface UploadVC ()
{
    NSMutableArray *urlImages;
    PFObject *adImage;
    PFObject *adDetail;
    PFFile *imageFile;
    NSData *aData;
    int counter;
}
@end

@implementation UploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayOfImages=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return[self.arrayOfImages count];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    customCellUploadImg *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"uploadImg" forIndexPath:indexPath];
    cell.imgVwUpload.image=_arrayOfImages[indexPath.row];
//    cell.imgVwUpload.image=[self.arrayOfImages objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)btnUploadImage:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    }
#define Bar button Upload
- (IBAction)barBtnUpload:(UIBarButtonItem *)sender {
    urlImages=[NSMutableArray array];
    counter=(int)_arrayOfImages.count;
    
    for(int i=0;i<_arrayOfImages.count;i++)
    {
        NSData *data=UIImageJPEGRepresentation(_arrayOfImages[i], 0.0);
        
        PFFile *file=[PFFile fileWithData:data];
        
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             [urlImages addObject:file.url];
             NSLog(@"Array %@",urlImages);
             counter--;
             if(counter==0){
                 [self storedata];
             }
         }];
    }
    if(_arrayOfImages.count==1)
    {
        [self storedata];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [_arrayOfImages addObject:chosenImage];
    
    [_collectionImages reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



// GoogleMaps Implementation start
- (IBAction)onLaunchClicked:(UIButton *)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    _txtLocation.text=place.name;
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}
// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
// GoogleMaps Implementation End

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)btnTagFriend:(UIButton *)sender {
}


#define store caption location image in database
-(void)storedata
{
    PFUser *cuser=[PFUser currentUser];
    NSString *aUsername=[cuser objectForKey:@"username"];
    NSString *aName=[cuser objectForKey:@"fname"];
    NSString *pimage=[cuser objectForKey:@"profile_image"];
    if(_txtCaption.text.length == 0 || _txtLocation.text.length == 0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Text Field Error" message:@"Fill details properly" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                             }];
        [alert addAction:ok];

        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [SVProgressHUD show];

#define first store caption and location in database
        adDetail = [PFObject objectWithClassName:@"post"];
        [adDetail setObject:[PFUser currentUser].objectId forKey:@"owner_id"];
        [adDetail setObject:_txtCaption.text forKey:@"caption"];
        [adDetail setObject:_txtLocation.text forKey:@"location"];
        [adDetail setObject:urlImages forKey:@"images"];
        [adDetail setObject:aUsername forKey:@"username"];
        [adDetail setObject:aName forKey:@"name"];
        [adDetail setObject:pimage forKey:@"profile_imgwall"];
        
        [adDetail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (!error && succeeded==YES)
            {
                // Show success message
                [SVProgressHUD dismiss];
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Congratulations!!!" message:@"Your image is uploaded." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         _txtLocation.text=@"";
                                         _txtCaption.text=@"";
                                     }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else
            {
                [SVProgressHUD dismiss];
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Sorry!!!" message:@"Something goes wrong. Image can't uploaded." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                    
                                     }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}
@end

