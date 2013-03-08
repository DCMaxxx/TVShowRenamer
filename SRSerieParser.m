//
//  SRSerieParser.m
//  SerieRenamer
//
//  Created by Maxime de Chalendar on 27/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import "SRSerieParser.h"

@implementation SRSerieParser


- (id) init {
    self = [super init];
    if (self) {
        _stringsWeakParsing[SERIE_ID] = SERIE_ID_STRING;
        _stringsWeakParsing[SERIE_LANGUAGE] = SERIE_LANGUAGE_STRING;
        _stringsWeakParsing[SERIE_NAME] = SERIE_NAME_STRING;
    }
    return self;
}


- (NSArray *) getSeriesIdsWithName :(NSString *)name Language:(NSString *)language andMax:(NSInteger)max {
    _currentMax = max;
    _currentLang = language;
    
    for (int i = 0; i < SERIE_NB_KEYS; ++i)
        _typeWeakParsing[i] = NO, _currentWeakParsing[i] = nil;

    _currentParsingArray = [[NSMutableArray alloc] init];

    NSString *urlText = [NSString stringWithFormat:GET_ID_FORMAT(name, _currentLang)];
    urlText = [urlText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *idsUrl = [NSURL URLWithString: urlText];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:idsUrl];
    [parser setDelegate:self];
    [parser parse];
    
    return _currentParsingArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
                                     qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    for (int i = 0; i < SERIE_NB_KEYS; ++i)
        if ([elementName isEqualToString:_stringsWeakParsing[i]])
            _typeWeakParsing[i] = YES;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    for (int i = 0; i < SERIE_NB_KEYS; ++i)
        if (_typeWeakParsing[i]) {
            if (!_currentWeakParsing[i])
                _currentWeakParsing[i] = [NSMutableString stringWithString:string];
            else
                [_currentWeakParsing[i] appendString:string];
        }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    BOOL allWeak = YES;
    for (int i = 0; i < SERIE_NB_KEYS; ++i) {
        allWeak = allWeak && (_currentWeakParsing[i] != nil);
        _typeWeakParsing[i] = NO;
    }
    if (allWeak) {
        NSUInteger result = [_currentParsingArray indexOfObjectPassingTest:
                             ^ BOOL (id obj, NSUInteger idx, BOOL *v) { return [obj tvdbId] == [_currentWeakParsing[SERIE_ID] integerValue]; }
                             ];
        if (result != NSNotFound) {
            SRSerie *tmp = [_currentParsingArray objectAtIndex:result];
            [tmp addLanguage: _currentWeakParsing[SERIE_LANGUAGE]];
        } else {
            SRSerie *tmp = [[SRSerie alloc] init];
            NSDictionary *tmpDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                    _currentWeakParsing[SERIE_ID], _stringsWeakParsing[SERIE_ID],
                                    _currentWeakParsing[SERIE_LANGUAGE], _stringsWeakParsing[SERIE_LANGUAGE],
                                    _currentWeakParsing[SERIE_NAME], _stringsWeakParsing[SERIE_NAME],
                                    nil];
            [tmp fillWithDictionnary:tmpDic];
            [_currentParsingArray addObject:tmp];
        }
        for (int i = 0; i < SERIE_NB_KEYS; ++i)
            _currentWeakParsing[i] = nil;
    }
    if ([_currentParsingArray count] == _currentMax)
        [parser abortParsing];
}

@end
