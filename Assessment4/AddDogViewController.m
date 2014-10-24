//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.dogOwner.managedObjectContext];
    self.nameTextField.text = dog.name;
    self.breedTextField.text = dog.breed;
    self.colorTextField.text = dog.color;
}
- (IBAction)addDogToOwner:(id)sender {
    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.dogOwner.managedObjectContext];
    dog.name = self.nameTextField.text;
    dog.breed = self.breedTextField.text;
    dog.color = self.colorTextField.text;
    [self.dogOwner addDogsObject:dog];
    [self.dogOwner.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
