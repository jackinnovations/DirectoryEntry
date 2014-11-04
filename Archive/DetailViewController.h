//
//  DetailViewController.h
//  Archive
//
//  Created by Kendrick Daly on 10/28/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArchiveEntry;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) ArchiveEntry *entry;

@end
