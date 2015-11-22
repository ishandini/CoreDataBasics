//
//  StudentListViewController.m
//  CoreDataBasics
//
//  Created by Ishan  on 11/22/15.
//  Copyright © 2015 Ishan . All rights reserved.
//

#import "StudentListViewController.h"
#import "CoreDataStack.h"
#import "Student.h"
#import "School.h"

@interface StudentListViewController () {

    NSMutableArray *studentListArray;
}

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchStudentList];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchStudentList {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    studentListArray = [NSMutableArray arrayWithArray:[[[CoreDataStack defaultCoreDataStack] managedObjectContext] executeFetchRequest:fetchRequest error:&error]];
    
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return studentListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Student *student = [studentListArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = student.studentName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",student.school.schoolName,student.school.address];
    
    return cell;
}
 


@end
