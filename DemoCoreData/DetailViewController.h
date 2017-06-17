//
//  DetailViewController.h
//  DemoCoreData
//
//  Created by TNKHANH on 12/23/15.
//  Copyright © 2015 TNKHANH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (nonatomic, strong)Student *currentStudent;

- (IBAction)saveStudent:(id)sender;

@end
