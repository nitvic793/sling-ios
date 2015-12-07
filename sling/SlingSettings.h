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

#else
// PRODUCTION

// disabling logging

#define NSLog(s,...)
#define SLING_DEBUG 0

#endif


#endif /* SlingSettings_h */
