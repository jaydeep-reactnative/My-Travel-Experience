//
//  DetailExpenseVC.h
//  Take A Tour
//
//  Created by Ankit Patel on 31/03/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailExpenseVC : UIViewController

@property(nonatomic,strong)NSDictionary* dictDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblAccommodation;
@property (weak, nonatomic) IBOutlet UILabel *lblTransportation;
@property (weak, nonatomic) IBOutlet UILabel *lblMeals;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;
@property (weak, nonatomic) IBOutlet UILabel *lblTickets;
@property (weak, nonatomic) IBOutlet UILabel *lblOther;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblPerson;
@property (weak, nonatomic) IBOutlet UILabel *lblPerPerson;

@end
