//
//  MasterViewController.h
//  TestCObject
//
//  Created by Developer on 1/5/17.
//  Copyright © 2017 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TestCObject+CoreDataModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Images *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)insertObject:(NSString *)fileName;
-(NSString *)getPath:(NSString *)fileName;
-(NSData *)getImageBinary:(NSString *)filename;

@end

