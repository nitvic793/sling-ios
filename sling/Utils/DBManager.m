//
//  DBManager.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import "DBManager.h"
#import "FMResultSet.h"
#import "FMDatabaseQueue.h"

@implementation DBManager
{
    NSString *databasePath;
    FMDatabaseQueue *queue;
}

static DBManager *sharedInstance = nil;

#pragma DB Setup Methods

+ (DBManager*)sharedDBManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance openDatabase];
    });
    
    return sharedInstance;
}

+ (NSString *) getDatabasePath
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"grofers.db"]];
    
    return databasePath;
}

+ (NSString *) getTemporaryDatabasePath
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"grofers_temp.db"]];
    
    return databasePath;
}

+ (NSNumber *) getPrepackagedDBVersion
{
    NSNumber *dbVersion = [[NSNumber alloc] initWithInt:0];
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"package.db"];
    NSString *tempDbPath = [DBManager getTemporaryDatabasePath];
    NSData *data = [[NSData alloc] initWithContentsOfFile:defaultDBPath];
    [data writeToFile:tempDbPath atomically:YES];
    
    BOOL dbFileExists = [[NSFileManager alloc] fileExistsAtPath:tempDbPath];
    
    if(!dbFileExists)
    {
        NSAssert(0, @"Packaged file does not exist.");
    }
    
    sqlite3 *prepackagedDBConnection;
    
    if (sqlite3_open([tempDbPath UTF8String], &prepackagedDBConnection) != SQLITE_OK)
    {
        NSAssert1(0, @"[ERROR] Could not connect to database - %s", sqlite3_errmsg(prepackagedDBConnection));
    }
    else
    {
        sqlite3_stmt *statement;
        
        NSString *querySQL = @"SELECT VERSION_NUMBER FROM VERSION";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(prepackagedDBConnection, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                dbVersion = [[NSNumber alloc] initWithInt:sqlite3_column_int(statement, 0)];
            }
            
            sqlite3_finalize(statement);
        }
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:tempDbPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:tempDbPath error:nil];
    }
    
    return dbVersion;
}

+ (NSDictionary *) getPreviousUserDataWithConnection : (sqlite3 *) connection
{
    NSMutableDictionary *storedDbDict = [[NSMutableDictionary alloc] init];
    
    
    return storedDbDict;
}

+ (NSNumber *) getDbVersionWithConnection: (sqlite3 *) db
{
    sqlite3_stmt *statement;
    NSNumber *dbVersion = [[NSNumber alloc] initWithInt:0];
    
    NSString *querySQL = @"SELECT VERSION_NUMBER FROM VERSION";
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            dbVersion = [[NSNumber alloc] initWithInt:sqlite3_column_int(statement, 0)];
        }
        
        sqlite3_finalize(statement);
    }
    
    return dbVersion;
}

-(void) openDatabase
{
    databasePath = [DBManager getDatabasePath];
    queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
}


-(void) updateDatabaseFrom:(int) oldVersion toNewVersion:(int) newVersion
{
    [queue inDatabase:^(FMDatabase *db)
    {
        
    }];
}

-(void) executeRawStatement:(NSString *) sql
{
    if ([sql length] > 0)
    {
        [queue inDatabase:^(FMDatabase *db)
        {
            [db executeUpdate:sql];
            
            if ([db hadError])
            {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            }
        }];
    }
}

@end
