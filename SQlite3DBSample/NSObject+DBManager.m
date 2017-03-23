//
//  NSObject+DBManager.m
//  SQlite3DBSample
//
//  Created by Developer on 12/19/16.
//  Copyright © 2016 Developer. All rights reserved.
//

#import "NSObject+DBManager.h"

@implementation NSObject (DBManager)

-(instancetype)initWithDatabaseFile:(NSString *)dbFilename{
    self = [super init];
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        self.documentsDirectory = [paths objectAtIndex:0];
        self.databaseFilename = dbFilename;
    
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

@end
