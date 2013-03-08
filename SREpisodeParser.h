//
//  SREpisodeParser.h
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 30/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVDBSettings.h"

#define GET_EPISODE_URL_FORMAT(showId, seasonIdx, episodeIdx, language) @"http://thetvdb.com/api/"TVDB_API_KEY"/series/%zu/default/%zu/%zu/%@.xml",showId, seasonIdx, episodeIdx, language

@interface SREpisodeParser : NSObject <NSXMLParserDelegate> {
    BOOL _isParsing;
    NSMutableString * _episodeName;
}

- (NSString *)parseEpisodeOfShow:(NSInteger)showId Season:(NSInteger)seasonIdx Episode:(NSInteger)episodeIdx andLanguage:(NSString *)language;

@end
