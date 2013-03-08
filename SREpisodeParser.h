//
//  SREpisodeParser.h
//  SerieRenamer
//
//  Created by Maxime de Chalendar on 30/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVDBSettings.h"

#define GET_EPISODE_URL_FORMAT(serieId, seasonIdx, episodeIdx, language) @"http://thetvdb.com/api/"TVDB_API_KEY"/series/%zu/default/%zu/%zu/%@.xml",serieId, seasonIdx, episodeIdx, language

@interface SREpisodeParser : NSObject <NSXMLParserDelegate> {
    BOOL _isParsing;
    NSMutableString * _episodeName;
}

- (NSString *)parseEpisodeOfSerie:(NSInteger)serieId Season:(NSInteger)seasonIdx Episode:(NSInteger)episodeIdx andLanguage:(NSString *)language;

@end
