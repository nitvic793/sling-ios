//
//  SlingSettings.h
//  Sling
//
//  Created by Satyam Krishna on 06/12/15.
//  Copyright © 2015 Bitstax. All rights reserved.
//

#ifndef SlingSettings_h
#define SlingSettings_h

/***
 * Change when releasing app
 */

#if DEBUG
// DEVELOPMENT

#define SLING_DEBUG 1
#define SLING_CHAT_APPLICATION_ID 33581
#define SLING_CHAT_AUTH_KEY @"EzDzJWMRk9UaHaK"
#define SLING_CHAT_AUTH_SECRET @"jc7ddKMDsAqsqCT"
#define SLING_CHAT_ACCOUNT_KEY @"QyYej5Hd3zk2PUgQiqy7"

#else
// PRODUCTION

// disabling logging

#define NSLog(s,...)
#define SLING_DEBUG 0
#define SLING_CHAT_APPLICATION_ID 33581
#define SLING_CHAT_AUTH_KEY @"EzDzJWMRk9UaHaK"
#define SLING_CHAT_AUTH_SECRET @"jc7ddKMDsAqsqCT"
#define SLING_CHAT_ACCOUNT_KEY @"QyYej5Hd3zk2PUgQiqy7"

#endif


#endif /* SlingSettings_h */
