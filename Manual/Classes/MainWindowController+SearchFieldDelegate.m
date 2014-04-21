/*!
 * @file		MainWindowController+SearchFieldDelegate.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController+SearchFieldDelegate.h"
#import "MainWindowController+NSOutlineViewDelegate.h"

@implementation MainWindowController (SearchFieldDelegate)

- (void)searchFieldValueDidChange:(SearchField *)searchField {
  (void)searchField;

  [_outlineView reloadData];

  _outlineViewShouldNotBecomeFirstResponder = YES;

  [self outlineViewSelectionDidChange:nil];

  _outlineViewShouldNotBecomeFirstResponder = NO;
}

@end
