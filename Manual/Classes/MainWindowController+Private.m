/*!
 * @file		MainWindowController+Private.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController+Private.h"
#import "MainWindowController+NSOutlineViewDelegate.h"

@implementation MainWindowController (Private)

- (void)didEndSheet:(NSWindow *)sheet
         returnCode:(NSInteger)returnCode
        contextInfo:(void *)contextInfo {
  (void)sheet;
  (void)returnCode;
  (void)contextInfo;

  [sheet orderOut:self];
}

- (void)sectionsMenuSelectionDidChange:(id)sender {
  (void)sender;

  _currentSection = [(NSPopUpButton *)sender selectedTag];

  [_outlineView reloadData];
  [_outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:0]
            byExtendingSelection:NO];
  [self outlineViewSelectionDidChange:nil];

  self.window.title = [NSString
      stringWithFormat:@"%@ - %@", NSLocalizedString(@"WindowTitle", nil),
                       _sectionsMenu.selectedItem.title];
}

- (void)mainWindowDidResize:(NSNotification *)notification {
  [self outlineViewSelectionDidChange:notification];
}

@end
