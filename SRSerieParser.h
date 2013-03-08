//
//  SRSerieParser.h
//  SerieRenamer
//
//  Created by Maxime de Chalendar on 27/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRSerie.h"
#import "TVDBSettings.h"

#define SERIE_ID 0
#define SERIE_LANGUAGE 1
#define SERIE_NAME 2
#define SERIE_NB_KEYS 3

#define GET_ID_FORMAT(name, language) @"http://www.thetvdb.com/api/GetSeries.php?seriesname=%@&language=%@", name, language
#define GET_SERIE_URL_FORMAT(name, language) @"http://thetvdb.com/api/"TVDB_API_KEY"/series/%@/%@.xml", name, language

@interface SRSerieParser : NSObject <NSXMLParserDelegate> {
    NSString * _stringsWeakParsing[SERIE_NB_KEYS];
    BOOL _typeWeakParsing[SERIE_NB_KEYS];
    NSMutableString * _currentWeakParsing[SERIE_NB_KEYS];

    NSString *_currentLang;
    NSMutableArray * _currentParsingArray;
    NSInteger _currentMax;
}

- (NSArray *) getSeriesIdsWithName :(NSString *)name Language:(NSString *)language andMax:(NSInteger)max;

@end
