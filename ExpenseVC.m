//
//  ExpenseVC.m
//  Take A Tour
//
//  Created by Ankit Patel on 31/03/16.
//  Copyright © 2016 indianic. All rights reserved.
//

#import "ExpenseVC.h"
#import "ExpenseTableViewCell.h"
#import "Database.h"
#import "DetailExpenseVC.h"

@interface ExpenseVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ExpenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
    
//    db = [[Database alloc]init];
    arrExpense=[Database executeQuery:[NSString stringWithFormat:@"SELECT * from Expense"]];
    
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrExpense.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpenseTableViewCell *cell = (ExpenseTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"ExpenseTableViewCell"];
    cell.lblPlace.text=[arrExpense[indexPath.row]valueForKey:@"place_name"];
    cell.lblTotal.text=[arrExpense[indexPath.row]valueForKey:@"total"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailExpenseVC *objDVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailExpenseVC"];
    objDVC.dictDetails=arrExpense[indexPath.row];
    [self.navigationController pushViewController:objDVC animated:YES];
    
}



@end
