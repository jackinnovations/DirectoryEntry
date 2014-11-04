 //
//  NewEntryViewController.m
//  Archive
//
//  Created by Kendrick Daly on 10/23/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import "EntryViewController.h"
#import "ArchiveEntry.h"
#import "CoreDataStack.h"
#import <Parse/Parse.h>

@interface EntryViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage *pickedImage;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *gradeField;
@property (strong, nonatomic) IBOutlet UITextField *parentsField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    if (self.entry != nil) {
        self.nameField.text = self.entry.name;
        self.gradeField.text = self.entry.grade;
        self.parentsField.text = self.entry.parents_names;
        self.phoneNumberField.text = self.entry.phone_number;
        self.addressField.text = self.entry.address;
        self.pickedImage = [UIImage imageWithData:self.entry.image];
    }
    self.imageButton.layer.cornerRadius = CGRectGetWidth(self.imageButton.frame)/ 10.0f;
//    [self keyboardReturnActionSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateArchiveEntry {
    self.entry.name = self.nameField.text;
    self.entry.grade = self.gradeField.text;
    self.entry.parents_names = self.parentsField.text;
    self.entry.phone_number = self.phoneNumberField.text;
    self.entry.address = self.addressField.text;
    self.entry.image = UIImageJPEGRepresentation(self.pickedImage, 1.0);
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
}

- (IBAction)doneWasPressed:(id)sender {
    if (self.entry != nil) {
        [self updateArchiveEntry];
    }
    else {
        [self insertParseEntry];
    
    }
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}

- (void)insertParseEntry {
    PFObject *pEntry = [PFObject objectWithClassName:@"directoryEntry"];
    pEntry[@"name"] = self.nameField.text;
    pEntry[@"grade"] = self.gradeField.text;
    pEntry[@"parents"] = self.parentsField.text;
    pEntry[@"phone"] = self.phoneNumberField.text;
    pEntry[@"address"] = self.addressField.text;
    //pEntry[@"image"] = UIImageJPEGRepresentation(self.pickedImage, 1.0);
    [pEntry save];
    [self insertDirectoryEntry];
    
}
- (void)insertDirectoryEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack ];
    ArchiveEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"ArchiveEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    PFQuery *query = [PFQuery queryWithClassName:@"directoryEntry"];
    [query whereKey:@"phone" equalTo:self.phoneNumberField.text];
    PFObject *object = [query getFirstObject];
    
    entry.name = object[@"name"];
    entry.grade = object[@"grade"];
    entry.parents_names = object[@"parents"];
    entry.phone_number = object[@"phone"];
    entry.address = object[@"address"];
    //entry.parseID = object.objectId;

//    entry.name = self.nameField.text;
//    entry.grade = self.gradeField.text;
//    entry.parents_names = self.parentsField.text;
//    entry.phone_number = self.phoneNumberField.text;
//    entry.address = self.addressField.text;
      entry.image = UIImageJPEGRepresentation(self.pickedImage, 1.0);
    [coreDataStack saveContext];
}

- (IBAction)imageButtonWasPressd:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    }
    else {
        [self promptForPhotoRoll];
    }
}

- (void)promptForSource {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Roll", nil];
    [actionSheet showInView:self.view];
                                  
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForCamera];
        }
        else {
            [self promptForPhotoRoll];
        }
    }
}

- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPickedImage:(UIImage *)pickedImage {
    _pickedImage = pickedImage;
    
    if (pickedImage == nil) {
        [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
    }
    else {
    [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
}

//// Keyboard Stuff
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
//
//- (void)keyboardReturnActionSetup {
//    self.nameField.delegate = self;
//    self.gradeField.delegate = self;
//    self.parentsField.delegate = self;
//    self.phoneNumberField.delegate = self;
//    self.addressField.delegate = self;
//}

@end
