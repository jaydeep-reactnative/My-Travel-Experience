//
//  DetailExpenseVC.m
//  Take A Tour
//
//  Created by Ankit Patel on 31/03/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import "DetailExpenseVC.h"

@interface DetailExpenseVC ()

@end

@implementation DetailExpenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=[_dictDetails valueForKey:@"place_name"];
    
    _lblAccommodation.text=[_dictDetails valueForKey:@"acc"];
    _lblTransportation.text=[_dictDetails valueForKey:@"transport"];
    _lblMeals.text=[_dictDetails valueForKey:@"meals"];
    _lblTips.text=[_dictDetails valueForKey:@"tips"];
    _lblTickets.text=[_dictDetails valueForKey:@"tickets"];
    _lblOther.text=[_dictDetails valueForKey:@"other"];
    _lblTotal.text=[_dictDetails valueForKey:@"total"];
    _lblPerson.text=[_dictDetails valueForKey:@"no_of_persons"];
    _lblPerPerson.text=[_dictDetails valueForKey:@"per_person"];
    
    
    // Do any additional setup after loading the view.
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




@end
