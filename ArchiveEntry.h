//
//  ArchiveEntry.h
//  Archive
//
//  Created by Kendrick Daly on 11/3/14.
//  Copyright (c) 2014 JACK Innovations L.L.C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArchiveEntry : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * grade;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parents_names;
@property (nonatomic, retain) NSString * phone_number;
@property (nonatomic, retain) NSString * parseID;

@end
