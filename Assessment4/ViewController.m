//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "Person.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *arrayOfDogOwners;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    [self loadJSONData];
}

-(void)loadJSONData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"]) {
        NSURL * url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error == nil) {
                NSArray *people = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"List of JSON results: %@", people);
                if (error) NSLog(@"%@", error);
                for (NSString *name in people) {
                    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
                    person.name = name;
                }
                [self.managedObjectContext save:&error];
                if (error) NSLog(@"%@", error);
                [self loadObjectsFromCoreData];
            }
            if (error) {
                NSLog(@"%@", error);
            } else {
                [defaults setObject:@YES forKey:@"dataImported"];
                [defaults synchronize];
            }
        }];
    } else {
        [self loadObjectsFromCoreData];
    }
}

- (void)loadObjectsFromCoreData{
   NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
   request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
   NSError *error = nil;
   self.arrayOfDogOwners = [self.managedObjectContext executeFetchRequest:request error:&error];
   NSLog(@"%lu have been added from Core Data",(unsigned long)self.arrayOfDogOwners.count);
   if (error) NSLog(@"%@", error);
   [self.myTableView reloadData];
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Person *owner = [self.arrayOfDogOwners objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
    DogsViewController *viewController = segue.destinationViewController;
    viewController.dogOwner = owner;
}

                       


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return self.arrayOfDogOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [self.arrayOfDogOwners objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    cell.textLabel.text = person.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
