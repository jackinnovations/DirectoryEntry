//
//  EntryCell.h
//  Archive
//
//  Created by Kendrick Daly on 10/27/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArchiveEntry;

@interface EntryCell : UITableViewCell

- (void)configureCellForEntry:(ArchiveEntry *)entry;

@end
