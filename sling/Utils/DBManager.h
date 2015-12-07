//
//  DBManager.h
//  grofer-consumer
//
//  Created by Satyam Krishna on 07/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "Constants.h"

@interface DBManager : NSObject

-(void) updateDatabaseFrom:(int) oldVersion toNewVersion:(int) newVersion;

// Static Methods
+ (DBManager*)sharedDBManager;
+ (NSString *) getDatabasePath;
+ (NSString *) getTemporaryDatabasePath;
+ (NSNumber *) getDbVersionWithConnection:(sqlite3 *) db;
+ (NSNumber *) getPrepackagedDBVersion;
+ (NSDictionary *) getPreviousUserDataWithConnection : (sqlite3 *) connection;

@end
