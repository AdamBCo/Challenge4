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
    [self loadObjectsFromCoreData];
    NSLog(@"DogOwner Name: %@", self.dogOwner.name);
    NSLog(@"Has dogs: %lu", (unsigned long)self.dogOwner.dogs.count);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.arrayOfDogs = [NSArray new];
    [self loadObjectsFromCoreData];
}

- (void)loadObjectsFromCoreData{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Dog"];
    request.predicate = [NSPredicate predicateWithFormat:@"owner=%@", self.dogOwner];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSLog(@"%@",request);
    NSError *error = nil;
    self.arrayOfDogs = [self.dogOwner.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"%lu have been added from Core Data",(unsigned long)self.arrayOfDogs.count);
    if (error) NSLog(@"%@", error);
    [self.dogsTableView reloadData];


}

-(IBAction)undwindFromAddDogViewController:(UIStoryboardSegue *)segue{
    AddDogViewController *viewController = segue.sourceViewController;
    Dog *dog = [viewController addDogToOwner];
    [self.dogOwner addDogsObject:dog];
    [self.dogOwner.managedObjectContext save:nil];
    [self loadObjectsFromCoreData];
    
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
        [self loadObjectsFromCoreData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        Person *owner = self.dogOwner;
        DogsViewController *viewController = segue.destinationViewController;
        viewController.dogOwner = owner;
        NSLog(@"DogOwner Name: %@", self.dogOwner.name);
    }
    else if([segue.identifier isEqualToString:@""])
    {


    }
}

@end
