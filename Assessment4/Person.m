//
//  Person.m
//  Assessment4
//
//  Created by Adam Cooper on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "Person.h"
#import "Dog.h"


@implementation Person
@dynamic name;
@dynamic dogs;

//+(instancetype)retrieveArrayOfOwnersWithCompletion:(void(^)(NSArray *))complete{
//
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"dataImported"]) {
//        NSURL * url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
//            if (error == nil) {
//                NSArray *people = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//                NSLog(@"List of JSON results: %@", people);
//                if (error) NSLog(@"%@", error);
//                for (NSString *name in people) {
//                    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
//                    person.name = name;
//                }
//                [self save:&error];
//                if (error) NSLog(@"%@", error);
//                [self loadObjectsFromCoreData];
//            }
//            if (error) {
//                NSLog(@"%@", error);
//            } else {
//                [defaults setObject:@YES forKey:@"dataImported"];
//                [defaults synchronize];
//            }
//        }];
//    } else {
//        [self loadObjectsFromCoreData];
//    }
//}
//
//- (void)loadObjectsFromCoreData{
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
//    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
//    NSError *error = nil;
//    self.arrayOfDogOwners = [self.managedObjectContext executeFetchRequest:request error:&error];
//    NSLog(@"%lu have been added from Core Data",(unsigned long)self.arrayOfDogOwners.count);
//    if (error) NSLog(@"%@", error);
////    [self.myTableView reloadData];
////    
//}

@end
