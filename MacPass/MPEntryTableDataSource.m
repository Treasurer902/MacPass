//
//  MPEntyTableDataSource.m
//  MacPass
//
//  Created by Michael Starke on 09.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "MPEntryTableDataSource.h"
#import "MPEntryViewController.h"

#import "KeePassKit/KeePassKit.h"

@interface MPEntryTableDataSource ()

@end

@implementation MPEntryTableDataSource

// FIXME: change drag image to use only the first column regardless of drag start

- (id<NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row {
  id item = self.viewController.entryArrayController.arrangedObjects[row];
  if([item isKindOfClass:KPKEntry.class]) {
    return item;
  }
  return nil;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
  BOOL makeCopy = (info.draggingSourceOperationMask == NSDragOperationCopy);
  if(dropOperation == NSTableViewDropOn) {
    [tableView setDropRow:row+1 dropOperation:NSTableViewDropAbove];
  }
  return makeCopy ? NSDragOperationCopy : NSDragOperationMove;
}

- (void)tableView:(NSTableView *)tableView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(nonnull NSIndexSet *)rowIndexes {
  session.draggingFormation = NSDraggingFormationList;
}

@end
