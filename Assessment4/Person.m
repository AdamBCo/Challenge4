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

+(void)fetchPeople:(NSManagedObjectContext *)context completion:(void(^)(NSArray *returnedArray))completionHandler{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"]) {
        
        //Request JSON Data Array
        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSMutableArray *jsonPeopleArray = [NSMutableArray new];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
            NSArray *people = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            for (NSString *name in people) {
                Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
                person.name = name;
                [jsonPeopleArray addObject:person];
            }
            [defaults setObject:@YES forKey:@"dataImported"];
            [defaults synchronize];
            NSArray *webArray = [NSArray arrayWithArray:jsonPeopleArray];
            completionHandler(webArray);
            [context save:nil];
        }];

    } else {
        //Request Core Data Array
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:nil];
        completionHandler(fetchedArray);
    }
}
@end
