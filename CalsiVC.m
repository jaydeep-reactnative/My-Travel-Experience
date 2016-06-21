//
//  CalsiVC.m
//  Tourist
//
//  Created by Jd's Mac on 10/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "CalsiVC.h"
#import "Database.h"
#import "ExpenseVC.h"
#import<GoogleMaps/GoogleMaps.h>
@interface CalsiVC ()
{
    float total,perperson;
    
}
@end

@implementation CalsiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path=[Database getDatabasePath];
    NSLog(@"%@",path);
    // Do any additional setup after loading the view.
}
- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)barbtnSave:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Input error" message:@"Please enter valid values" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okButton];
    
    if ([_txtPlace.text isEqualToString:@""] || [_txtNoofPerson.text isEqual:@""])
    {
        if ([_txtAccommodation.text isEqualToString:@""] || [_txtTransportation.text isEqualToString:@""] || [_txtMeals.text isEqualToString:@""] || [_txtTips.text isEqualToString:@""] || [_txtTickets.text isEqualToString:@""] || [_txtOtherExpenses.text isEqualToString:@""])
        {
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else
    {
//        Database *db = [[Database alloc]init];
    
        BOOL isSuccess =  [Database executeScalerQuery:[NSString stringWithFormat:@"INSERT into Expense values('%@','%f','%f','%f','%f','%f','%f','%f','%@','%@')",_txtPlace.text,noofperson,accommodation,transportation,meals,tips,tickets,otherExpenses,_lblTotalExpense.text,_lblPerPersonExpense.text]];
       
        if(isSuccess)
        {
            NSLog(@"Query Successfully Executed");
            ExpenseVC *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExpenseVC"];
            [self.navigationController pushViewController:evc animated:YES];
        }
        else
        {
            NSLog(@"Sorry!!!Something Goes Wrong");
        }
        
    }

}

- (IBAction)btnViewExpense:(UIButton *)sender {
    ExpenseVC *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExpenseVC"];
    [self.navigationController pushViewController:evc animated:YES];
}

- (IBAction)btnCalculate:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Input error" message:@"Please enter valid value" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okButton];
    
    if ([_txtPlace.text isEqualToString:@""] || [_txtNoofPerson.text isEqual:@""])
    {
        if ([_txtAccommodation.text isEqualToString:@""] || [_txtTransportation.text isEqualToString:@""] || [_txtMeals.text isEqualToString:@""] || [_txtTips.text isEqualToString:@""] || [_txtTickets.text isEqualToString:@""] || [_txtOtherExpenses.text isEqualToString:@""])
        {
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else
    {
        _lblTotalExpense.hidden=NO;
        _lblPerPersonExpense.hidden=NO;
        
        noofperson=([_txtNoofPerson.text floatValue]);
        accommodation=([_txtAccommodation.text floatValue]);
        transportation=([_txtTransportation.text floatValue]);
        meals=([_txtMeals.text floatValue]);
        tips=([_txtTips.text floatValue]);
        tickets=([_txtTickets.text floatValue]);
        otherExpenses=([_txtOtherExpenses.text floatValue]);
        
        [_lblTotalExpense setText:[NSString stringWithFormat:@"%.2f",accommodation+transportation+meals+tips+tickets+otherExpenses]];
        float totalexpense=([_lblTotalExpense.text floatValue]);
        [_lblPerPersonExpense setText:[NSString stringWithFormat:@"%.2f",totalexpense/noofperson]];
    }
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
    _txtPlace.text=place.name;
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
