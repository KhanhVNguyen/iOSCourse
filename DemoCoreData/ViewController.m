//
//  ViewController.m
//  DemoCoreData
//
//  Created by TNKHANH on 12/23/15.
//  Copyright © 2015 TNKHANH. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "DetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [self getData];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData{
    //Lay context
    NSManagedObjectContext *context = [self managedObjectContext];
    //Tao fetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    fetchRequest.returnsObjectsAsFaults = false;
    NSError *error;
    //Lay ket qua tu coreData thong qua fetchRequest
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if(!error){
        self.studentList  = [[NSMutableArray alloc] initWithArray:result];
        
    }
}
//Lay context cua AppDelegate
-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.studentList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellId = @"Cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    
    Student *currentStudent = self.studentList[indexPath.row];
    
    cell.textLabel.text = currentStudent.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",currentStudent.age];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //Pass data
    Student *currentStudent = self.studentList[indexPath.row];
    detailView.currentStudent = currentStudent;
    
    //Push view
    [self.navigationController pushViewController:detailView animated:true];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Xoa du lieu khoi CoreData
        NSManagedObjectContext *context = [self managedObjectContext];
        Student *currentStudent = self.studentList[indexPath.row];
        //Xoa doi tuong khoi CoreData
        [context deleteObject:currentStudent];
        NSError *error;
        [context save:&error];
        if (!error) {//Xoa thanh cong
            [self.studentList removeObject:currentStudent];
            //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    Student *currentStudent = self.studentList[indexPath.row];
    NSLog(@"%@",currentStudent.name);
}
@end
