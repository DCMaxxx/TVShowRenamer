//
//  SRSerie.h
//  SerieRenamer
//
//  Created by Maxime de Chalendar on 27/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVDBSettings.h"

#define GET_BANNER_FORMAT(name) @"%@/%@", @"http://thetvdb.com/banners/", name
#define GET_SEASON_FORMAT(season) @"http://www.thetvdb.com/data/series/%zu/default/%zu/1/%@.xml", _tvdbId, season, [_language objectAtIndex:0]

@interface SRSerie : NSObject {
    NSInteger _numberOfSeasons;
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *language;
@property (nonatomic, readonly) NSInteger tvdbId;

- (void) fillWithDictionnary :(NSDictionary *)dic;
- (void) addLanguage:(NSString *)language;
- (NSInteger) countSeason;

@end
