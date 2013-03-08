//
//  SRShow.m
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 27/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import "SRShow.h"

@implementation SRShow

- (void) fillWithDictionnary :(NSDictionary *)dic {
    _name =         [dic objectForKey:SHOW_NAME_STRING];
    _language =     [NSArray arrayWithObject:[dic objectForKey:SHOW_LANGUAGE_STRING]];
    _tvdbId =       [[[dic objectForKey:SHOW_ID_STRING] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] integerValue];
}

- (void) addLanguage:(NSString *)language {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:_language];
    [tmp addObject:language];
    _language = tmp;
}

- (NSInteger) countSeason {
    if (_numberOfSeasons)
        return _numberOfSeasons;

    BOOL isValidSeason = YES;
    while (isValidSeason) {
        NSURL *tmpUrl = [[NSURL alloc] initWithString:[NSString stringWithFormat:GET_SEASON_FORMAT(_numberOfSeasons + 1)]];
        NSURLRequest *request = [NSURLRequest requestWithURL:tmpUrl];
        NSURLResponse *response = nil;
        (void)[[NSData alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if((isValidSeason = ([((NSHTTPURLResponse *)response) statusCode] != 404)))
            ++_numberOfSeasons;
    }
    return _numberOfSeasons;
}

@end
