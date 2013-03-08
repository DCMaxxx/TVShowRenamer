//
//  SRShowParser.h
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 27/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRShow.h"
#import "TVDBSettings.h"

#define SHOW_ID 0
#define SHOW_LANGUAGE 1
#define SHOW_NAME 2
#define SHOW_NB_KEYS 3

#define GET_ID_FORMAT(name, language) @"http://www.thetvdb.com/api/GetSeries.php?seriesname=%@&language=%@", name, language
#define GET_SHOW_URL_FORMAT(name, language) @"http://thetvdb.com/api/"TVDB_API_KEY"/series/%@/%@.xml", name, language

@interface SRShowParser : NSObject <NSXMLParserDelegate> {
    NSString * _stringsWeakParsing[SHOW_NB_KEYS];
    BOOL _typeWeakParsing[SHOW_NB_KEYS];
    NSMutableString * _currentWeakParsing[SHOW_NB_KEYS];

    NSString *_currentLang;
    NSMutableArray * _currentParsingArray;
    NSInteger _currentMax;
}

- (NSArray *) getShowsIdsWithName :(NSString *)name Language:(NSString *)language andMax:(NSInteger)max;

@end
