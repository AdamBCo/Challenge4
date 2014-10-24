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
@property NSUserDefaults *userDefaults;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.title = @"Dog Owners";
    [self loadDogOwners];
    [self checkForUserDefaultTintColor];
}

- (void)loadDogOwners{
    [Person fetchPeople:self.managedObjectContext completion:^(NSArray *returnedArray) {
        self.arrayOfDogOwners = returnedArray;
        [self.myTableView reloadData];
    }];
}

-(void)checkForUserDefaultTintColor{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* setting = [defaults objectForKey:@"defaultTintColor"];
    if ([setting isEqualToString:@"Purple"]){
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
        
    }else if ([setting isEqualToString:@"Blue"]){
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        
    }else if ([setting isEqualToString:@"Orange"]){
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        
    }else if ([setting isEqualToString:@"Green"]){
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Person *owner = [self.arrayOfDogOwners objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
    DogsViewController *viewController = segue.destinationViewController;
    viewController.dogOwner = owner;
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    if (buttonIndex == 0){
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
        [self.userDefaults setObject:@"Purple" forKey:@"defaultTintColor"];
    }
    else if (buttonIndex == 1){
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        [self.userDefaults setObject:@"Blue" forKey:@"defaultTintColor"];
    }
    else if (buttonIndex == 2){
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        [self.userDefaults setObject:@"Orange" forKey:@"defaultTintColor"];
    }
    else if (buttonIndex == 3){
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        [self.userDefaults setObject:@"Green" forKey:@"defaultTintColor"];
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
