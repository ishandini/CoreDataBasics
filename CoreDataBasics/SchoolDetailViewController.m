//
//  SchoolDetailViewController.m
//  CoreDataBasics
//
//  Created by Ishan  on 11/21/15.
//  Copyright © 2015 Ishan . All rights reserved.
//

#import "SchoolDetailViewController.h"
#import "CoreDataStack.h"
#import "School.h"

@interface SchoolDetailViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtAddress;


@end

@implementation SchoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCurrentSchoolDetailsOnTextFields];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setCurrentSchoolDetailsOnTextFields {

    if (self.currentSchool != nil) {
        self.txtName.text = self.currentSchool.schoolName;
        self.txtAddress.text = self.currentSchool.address;
    }
    
}


#pragma mark - hide keyboard

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

#pragma mark - pressed button

- (IBAction)pressedButton:(id)sender {
    
    if(self.txtName.text.length > 0) {
    
        CoreDataStack *defaultStack = [CoreDataStack defaultCoreDataStack];
        
        if(self.currentSchool == nil) {
        
            // Add new school
            School *school = [NSEntityDescription insertNewObjectForEntityForName:@"School" inManagedObjectContext:defaultStack.managedObjectContext];
            
            [school setSchoolName:self.txtName.text];
            [school setAddress:self.txtAddress.text];
            
            
        }else {
        //Change current school details
            
            [self.currentSchool setSchoolName:self.txtName.text];
            [self.currentSchool setAddress:self.txtAddress.text];
            
        }
        
       [defaultStack saveContext];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


@end
