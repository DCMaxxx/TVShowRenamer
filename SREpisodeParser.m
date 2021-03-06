//
//  SREpisodeParser.m
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 30/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import "SREpisodeParser.h"

@implementation SREpisodeParser

- (NSString *)parseEpisodeOfShow:(NSInteger)showId Season:(NSInteger)seasonIdx Episode:(NSInteger)episodeIdx andLanguage:(NSString *)language {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:GET_EPISODE_URL_FORMAT(showId, seasonIdx, episodeIdx, language)]];
    
    _isParsing = NO;
    _episodeName = [[NSMutableString alloc] init];

    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];

    return _episodeName;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    _isParsing = ([elementName isEqualToString:EPISODE_NAME_STRING]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_isParsing)
        [_episodeName appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:EPISODE_NAME_STRING])
        [parser abortParsing];
}

@end
