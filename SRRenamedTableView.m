//
//  SRRenamedTableView.m
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 28/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#import "SRRenamedTableView.h"

@implementation SRRenamedTableView

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    return [[_allFiles objectAtIndex:rowIndex] objectForKey:[[aTableColumn headerCell] stringValue]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [_allFiles count];
}


@end
