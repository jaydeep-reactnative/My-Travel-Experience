//
//  ExpenseVC.h
//  Take A Tour
//
//  Created by Ankit Patel on 31/03/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface ExpenseVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    Database *db;
    NSMutableArray *arrExpense;
    NSDictionary *dictDetailsExpense;
}

@end
