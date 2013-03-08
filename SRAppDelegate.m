//
//  SRAppDelegate.m
//  SerieRenamer
//
//  Created by Maxime de Chalendar on 26/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import "TVDBSettings.h"
#import "SRAppDelegate.h"
#import "SREpisodeParser.h"

@implementation SRAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {
    ep = [[SREpisodeParser alloc] init];
    
    [searchField becomeFirstResponder];
    
    sp = [[SRSerieParser alloc] init];
    currentSeries = nil;

    renamedTableViewDelegate = [[SRRenamedTableView alloc] init];
    [files setDataSource:renamedTableViewDelegate];
}

- (IBAction)updateSearch:(id)sender {
    [progress startAnimation:self];

    currentSeries = [sp getSeriesIdsWithName:[searchField stringValue] Language:ALL_LANGUAGES_STRING andMax:-1];
    [self updateSearchResult:nil];
    [self serieWasSelected:nil];
    
    [progress stopAnimation:self];
}

- (IBAction)serieWasSelected:(id)sender {
    [season removeAllItems];
    [season addItemWithTitle:@"Season"];
    [language removeAllItems];
    [language addItemWithTitle:@"Language"];
    if ([serie indexOfSelectedItem] == 0) {
        currentSerie = nil;
        return ;
    }
    
    [progress startAnimation:self];

    currentSerie = [currentSeries objectAtIndex:[serie indexOfSelectedItem] - 1];
    NSInteger nbSeasons = [currentSerie countSeason];
    
    for (NSInteger i = 0; i < nbSeasons; ++i)
        [season addItemWithTitle:[NSString stringWithFormat:@"%zu", i + 1]];
    for (NSString *tmpLanguage in [currentSerie language])
        [language addItemWithTitle:tmpLanguage];

    [progress stopAnimation:self];
}

- (IBAction)updateSearchResult:(id)sender {
    [serie removeAllItems];
    [serie addItemWithTitle:@"Serie"];
    for (SRSerie * tmpSerie in currentSeries) {
        [serie addItemWithTitle:[tmpSerie name]];
    }
}

- (IBAction)selectFiles:(id)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowsMultipleSelection:YES];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if ([openDlg runModal] == NSOKButton) {
        NSArray * selectedFiles = [openDlg URLs];
        for (NSString *file in selectedFiles) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:file forKey:@"path"];
            [dic setObject:[file lastPathComponent] forKey:@"Old name"];
            [result addObject:dic];
        }
    }
    [renamedTableViewDelegate setAllFiles:result];
    [files reloadData];
}

- (IBAction)changeSeason:(id)sender {
}

- (IBAction)previewRename:(id)sender {
    if (!currentSerie || ![season indexOfSelectedItem] || ![language indexOfSelectedItem] || ![[format stringValue] length] ||
        ![[renamedTableViewDelegate allFiles] count]) {
        [textError setTextColor:[NSColor redColor]];
        return ;
    } else {
        [textError setTextColor:[NSColor blackColor]];
    }
    
    [progress2 startAnimation:self];
    
    NSInteger serieId = [currentSerie tvdbId];
    NSInteger seasonIdx = [season indexOfSelectedItem];
    NSString *currentLanguage = [[language selectedItem] title];

    int i = 0;
    for (NSMutableDictionary *file in [renamedTableViewDelegate allFiles]) {
        NSString * episode = [ep parseEpisodeOfSerie:serieId Season:seasonIdx Episode:++i andLanguage:currentLanguage];
        if (episode == nil) {
            [file setObject:[self parseWithName:@"Warning : Unknown episode !" andNumber:i andExtension:[[file objectForKey:@"Old name"] pathExtension]] forKey:@"New name"];
        } else {
            [file setObject:[self parseWithName:episode andNumber:i andExtension:[[file objectForKey:@"Old name"] pathExtension]] forKey:@"New name"];
        }
    }
    
    [files reloadData];
    [progress2 stopAnimation:self];
    
}

- (IBAction)renameAllFiles:(id)sender {
    NSArray * allfiles = [renamedTableViewDelegate allFiles];
    if (!allfiles || ![allfiles count]) {
        [self previewRename:nil];
        return ;
    } else if (![[allfiles objectAtIndex:0] objectForKey:@"New name"] ||
               ![[[allfiles objectAtIndex:0] objectForKey:@"New name"] length]) {
        [self previewRename:nil];
        if (![[textError textColor] isEqualTo:[NSColor blackColor]])
            return ;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL errorB = NO;
    for (NSMutableDictionary *file in allfiles) {
        NSURL *oldPath = [file objectForKey:@"path"];
        NSURL *newPath = [[oldPath URLByDeletingLastPathComponent] URLByAppendingPathComponent:[file objectForKey:@"New name"]];
        if (![oldPath isEqualTo:newPath])
            [fm moveItemAtURL:oldPath toURL:newPath error:&error];
        if (error != nil) {
            [file setObject:@"Oops... there was an error" forKey:@"New name"];
            errorB = YES;
        }
    }
    if (!errorB) {
        [renamedTableViewDelegate setAllFiles:nil];
    }
    [files reloadData];
}

- (NSString *)parseWithName :(NSString *)name andNumber:(NSInteger)number andExtension:(NSString *)ext {
    NSString * serieName = [[serie selectedItem] title];
    NSInteger seasonIdx = [season indexOfSelectedItem];
    
    NSString *formatStr = [NSString stringWithString:[format stringValue]];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\$serie" options:NSRegularExpressionCaseInsensitive error:&error];
    formatStr = [regex stringByReplacingMatchesInString:formatStr options:0 range:NSMakeRange(0, [formatStr length]) withTemplate:serieName];
    regex = [NSRegularExpression regularExpressionWithPattern:@"\\$episode" options:NSRegularExpressionCaseInsensitive error:&error];
    formatStr = [regex stringByReplacingMatchesInString:formatStr options:0 range:NSMakeRange(0, [formatStr length]) withTemplate:name];
    regex = [NSRegularExpression regularExpressionWithPattern:@"#season" options:NSRegularExpressionCaseInsensitive error:&error];
    formatStr = [regex stringByReplacingMatchesInString:formatStr options:0 range:NSMakeRange(0, [formatStr length]) withTemplate:[NSString stringWithFormat:@"%02zu", seasonIdx]];
    regex = [NSRegularExpression regularExpressionWithPattern:@"#episode" options:NSRegularExpressionCaseInsensitive error:&error];
    formatStr = [regex stringByReplacingMatchesInString:formatStr options:0 range:NSMakeRange(0, [formatStr length]) withTemplate:[NSString stringWithFormat:@"%02zu", number]];

    if (![ext isEqualTo:@""])
        return [NSString stringWithFormat:@"%@.%@", formatStr, ext];
    else
        return formatStr;
}

@end
