//
//  Student+CoreDataProperties.h
//  CoreDataBasics
//
//  Created by Ishan  on 11/22/15.
//  Copyright © 2015 Ishan . All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *studentName;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) School *school;

@end

NS_ASSUME_NONNULL_END
