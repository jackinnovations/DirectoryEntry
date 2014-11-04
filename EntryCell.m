//
//  EntryCell.m
//  Archive
//
//  Created by Kendrick Daly on 10/27/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import "EntryCell.h"
#import "ArchiveEntry.h"
#import <QuartzCore/QuartzCore.h>

@interface EntryCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;



@end

@implementation EntryCell

-(void)configureCellForEntry:(ArchiveEntry *)entry {
    self.nameLabel.text = entry.name;
    self.gradeLabel.text = entry.grade;
    
    if (entry.image) {
        self.mainImage.image = [UIImage imageWithData:entry.image];
    }
    else {
        self.mainImage.image = [UIImage imageNamed:@"icn_noimage"];
    }
    self.mainImage.layer.cornerRadius = CGRectGetWidth(self.mainImage.frame)/ 2.0f;
}

@end
