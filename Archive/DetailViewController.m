//
//  DetailViewController.m
//  Archive
//
//  Created by Kendrick Daly on 10/28/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import "DetailViewController.h"
#import "EntryViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backWasPressed:(id)sender {
    [self dismissSelf];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"edit"]) {
        UINavigationController *navigationController = segue.destinationViewController;
         EntryViewController *entryViewController = (EntryViewController *) navigationController.topViewController;
        entryViewController.entry = self.entry;
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
