//
//  SRAppDelegate.h
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 26/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SRShowParser.h"
#import "SREpisodeParser.h"
#import "SRRenamedTableView.h"

@interface SRAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSProgressIndicator *progress;
    IBOutlet NSProgressIndicator *progress2;
    
    IBOutlet NSTextField *searchField;
    IBOutlet NSPopUpButton *show;
    IBOutlet NSPopUpButton *language;
    IBOutlet NSPopUpButton *season;
    
    IBOutlet NSComboBox *format;
    
    IBOutlet NSTextField *textError;
        
    IBOutlet NSTableView *files;
    SRRenamedTableView *renamedTableViewDelegate;
    
    SRShowParser * sp;
    NSArray *currentShows;
    SRShow *currentShow;
    
    SREpisodeParser *ep;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)updateSearch:(id)sender;
- (IBAction)showWasSelected:(id)sender;
- (IBAction)updateSearchResult:(id)sender;
- (IBAction)selectFiles:(id)sender;
- (IBAction)changeSeason:(id)sender;
- (IBAction)previewRename:(id)sender;
- (IBAction)renameAllFiles:(id)sender;

- (NSString *)parseWithName :(NSString *)name andNumber:(NSInteger) number andExtension:(NSString *)ext;

@end
