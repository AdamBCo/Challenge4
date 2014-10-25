//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "DogTableViewCell.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *arrayOfDogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
    self.arrayOfDogs = [self.dogOwner.dogs allObjects];
    NSLog(@"%lu", (unsigned long)self.dogOwner.dogs.count);
    [self.dogsTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.arrayOfDogs = [self.dogOwner.dogs allObjects];
    NSLog(@"%@", self.dogOwner.name);
    NSLog(@"%lu", (unsigned long)self.dogOwner.dogs.count);
    [self.dogsTableView reloadData];
}



#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfDogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dog *dog = [self.arrayOfDogs objectAtIndex:indexPath.row];
    DogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    cell.nameLabel.text = dog.name;
    cell.breedLabel.text = dog.breed;
    cell.colorLabel.text = dog.color;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete Dog";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Dog *dog = [self.arrayOfDogs objectAtIndex:indexPath.row];
        [self.dogOwner removeDogsObject:dog];
        [self.dogOwner.managedObjectContext save:nil];
        self.arrayOfDogs = [self.dogOwner.dogs allObjects];
        [self.dogsTableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        DogsViewController *viewController = segue.destinationViewController;
        viewController.dogOwner = self.dogOwner;
    }
    else if([segue.identifier isEqualToString:@""])
    {


    }
}

@end
