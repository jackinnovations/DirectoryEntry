//
//  NewEntryViewController.h
//  Archive
//
//  Created by Kendrick Daly on 10/23/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArchiveEntry;

@interface EntryViewController : UIViewController // <UITextFieldDelegate>

@property (nonatomic, strong) ArchiveEntry *entry;

@end
