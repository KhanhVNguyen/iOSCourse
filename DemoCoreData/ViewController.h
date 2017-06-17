//
//  ViewController.h
//  DemoCoreData
//
//  Created by TNKHANH on 12/23/15.
//  Copyright © 2015 TNKHANH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *studentList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

