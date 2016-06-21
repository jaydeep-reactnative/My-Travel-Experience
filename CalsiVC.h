//
//  CalsiVC.h
//  Tourist
//
//  Created by Jd's Mac on 10/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<GoogleMaps/GoogleMaps.h>
@interface CalsiVC : UIViewController<UITextFieldDelegate,GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteViewControllerDelegate,UINavigationControllerDelegate>
{
    float noofperson;
    float accommodation;
    float transportation;
    float meals;
    float tips;
    float tickets;
    float otherExpenses;
}
- (IBAction)barbtnSave:(UIBarButtonItem *)sender;
- (IBAction)btnViewExpense:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPlace;
@property (weak, nonatomic) IBOutlet UITextField *txtNoofPerson;
@property (weak, nonatomic) IBOutlet UITextField *txtAccommodation;
@property (weak, nonatomic) IBOutlet UITextField *txtTransportation;
@property (weak, nonatomic) IBOutlet UITextField *txtMeals;
@property (weak, nonatomic) IBOutlet UITextField *txtTips;
@property (weak, nonatomic) IBOutlet UITextField *txtTickets;
@property (weak, nonatomic) IBOutlet UITextField *txtOtherExpenses;
- (IBAction)btnCalculate:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalExpense;
@property (weak, nonatomic) IBOutlet UILabel *lblPerPersonExpense;

@property (weak, nonatomic) IBOutlet UITextField *txtAccommodationProp;
@property (weak, nonatomic) IBOutlet UITextField *txtTransportationProp;
@property (weak, nonatomic) IBOutlet UITextField *txtMealsProp;
@property (weak, nonatomic) IBOutlet UITextField *txtTipsProp;
@property (weak, nonatomic) IBOutlet UITextField *txtTicketsProp;
@property (weak, nonatomic) IBOutlet UITextField *txtOtherexpensesProp;
@property (weak, nonatomic) IBOutlet UITextField *txtNoofpersonProp;

@end
