//
//  StudentDetailViewController.m
//  CoreDataBasics
//
//  Created by Ishan  on 11/22/15.
//  Copyright © 2015 Ishan . All rights reserved.
//

#import "StudentDetailViewController.h"
#import "CoreDataStack.h"
#import "School.h"
#import "Student.h"

@interface StudentDetailViewController ()<UIPickerViewDataSource,UIPickerViewDelegate> {

     NSMutableArray *schoolListArray;
}


@property (strong, nonatomic) IBOutlet UITextField *txtStudentName;

@property (strong, nonatomic) IBOutlet UITextField *txtAge;

@property (strong, nonatomic) IBOutlet UIPickerView *pkrSchool;

@end

@implementation StudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self fetchSchoolList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchSchoolList {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"School"];
    
    schoolListArray = [NSMutableArray arrayWithArray:[[[CoreDataStack defaultCoreDataStack] managedObjectContext] executeFetchRequest:fetchRequest error:&error]];
    
    
}

#pragma mark - hide keyboard

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}



#pragma mark - Button action

- (IBAction)pressedSaveButton:(id)sender {
    
    if(self.txtStudentName.text.length > 0) {
        
        CoreDataStack *defaultStack = [CoreDataStack defaultCoreDataStack];
        
            // Add new student
            Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:defaultStack.managedObjectContext];
        
        //get school from picker view
            School *school = [schoolListArray objectAtIndex:[self.pkrSchool selectedRowInComponent:0]];
            
            [student setStudentName:self.txtStudentName.text];
            [student setAge:@(self.txtAge.text.intValue)];
            [student setSchool:school];
        
        
        [defaultStack saveContext];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


#pragma mark - UIPicker datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return schoolListArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    School *school = [schoolListArray objectAtIndex:row];
    return school.schoolName;
}

@end
