//
//  SchoolListViewController.m
//  CoreDataBasics
//
//  Created by Ishan  on 11/21/15.
//  Copyright © 2015 Ishan . All rights reserved.
//

#import "SchoolListViewController.h"
#import "CoreDataStack.h"
#import "School.h"
#import "SchoolDetailViewController.h"

@interface SchoolListViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *schoolListArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SchoolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {

    [self fetchSchoolList];
    [self.tableView reloadData];
}


- (void)fetchSchoolList {

    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
    
    schoolListArray = [NSMutableArray arrayWithArray:[[[CoreDataStack defaultCoreDataStack] managedObjectContext] executeFetchRequest:fetchRequest error:&error]];
    
    
}


#pragma mark - UITableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return schoolListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    School *school = [schoolListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [school schoolName];
    cell.detailTextLabel.text = [school address];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if(editingStyle == UITableViewCellEditingStyleDelete) {
         School *school = [schoolListArray objectAtIndex:indexPath.row];
        
        [schoolListArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[[CoreDataStack defaultCoreDataStack] managedObjectContext] deleteObject:school];
        [[CoreDataStack defaultCoreDataStack] saveContext];
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"ROW_SELECTED_SEGUE"]){
    
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        School *school = [schoolListArray objectAtIndex:indexPath.row];
        SchoolDetailViewController *schoolDetailViewController = (SchoolDetailViewController *)segue.destinationViewController;
        schoolDetailViewController.currentSchool = school;
    }
}


@end
