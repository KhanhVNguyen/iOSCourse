//
//  DetailViewController.m
//  DemoCoreData
//
//  Created by TNKHANH on 12/23/15.
//  Copyright © 2015 TNKHANH. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.currentStudent) {
        self.txtName.text = self.currentStudent.name;
        self.txtAge.text = [NSString stringWithFormat:@"%@",self.currentStudent.age];
        self.txtAddress.text = self.currentStudent.address;
        
        //Cap nhat tieu de cho view
        self.title = @"Edit Student";
    }
    else{
        self.title = @"New Student";
    }
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
//Lay context cua AppDelegate
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (IBAction)saveStudent:(id)sender {
    //Lay context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.currentStudent) {//Cap nhat
        [self updateCoreDataWithContext:context andObject:self.currentStudent];
    }
    else{
        //Them moi, tao moi doi tuong theo entityname
        Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
        //Goi ham cap nhat coredata
        [self updateCoreDataWithContext:context andObject:newStudent];
    }
    
}
//Luu tru xuong CoreData
-(void)updateCoreDataWithContext:(NSManagedObjectContext *)managedObjectContext andObject:(Student *)currentStudent{
    currentStudent.name = self.txtName.text;
    currentStudent.age = [NSNumber numberWithInt:[self.txtAge.text intValue]];
    currentStudent.address = self.txtAddress.text;
    
    //Luu context
    NSError *error;
    [managedObjectContext save:&error];
    //Kiem tra loi
    if (!error) {//Neu khong co loi
        //Show alert luu thanh cong
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"Save successfully" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *okAction){}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:true completion:nil];
    }
    else{
        NSLog(@"%@",[error localizedDescription]);
    }
}
@end
