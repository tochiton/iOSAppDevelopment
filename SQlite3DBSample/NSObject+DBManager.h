//
//  NSObject+DBManager.h
//  SQlite3DBSample
//
//  Created by Developer on 12/19/16.
//  Copyright © 2016 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface NSObject (DBManager)

-(instancetype)initWithDatabaseFile:(NSString *)dbFilename;

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic, strong) NSString *databaseFilename;

-(void)copyDatabaseIntoDocumentsDirectory;


@end
