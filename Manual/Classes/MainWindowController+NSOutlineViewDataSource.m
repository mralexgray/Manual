/*!
 * @file		MainWindowController+NSOutlineViewDataSource.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController+NSOutlineViewDataSource.h"
#import "ManualHelper.h"
#import "ManualPage.h"
#import "ManualCell.h"

@implementation MainWindowController (NSOutlineViewDataSource)

- (NSInteger)outlineView:(NSOutlineView *)outlineView
    numberOfChildrenOfItem:(id)item {
  NSMutableArray *pages;
  NSDictionary *sections;
  NSString *section;
  ManualPage *page;
  NSCell *cell;
  NSRange range;

  (void)outlineView;

  [_cells removeAllObjects];

  if (item != nil) {
    return 0;
  }

  sections = [[ManualHelper sharedInstance] sections];

  if (_sectionsMenu.selectedTag == -1) {
    pages = [NSMutableArray arrayWithCapacity:1000];

    for (section in sections) {
      [pages addObjectsFromArray:[sections objectForKey:section]];

      if (_currentSection != -1) {
        [pages sortUsingComparator:^(id obj1, id obj2) {
            ManualPage *p1;
            ManualPage *p2;

            p1 = (ManualPage *)obj1;
            p2 = (ManualPage *)obj2;

            return [p1.name caseInsensitiveCompare:p2.name];
        }];
      }
    }
  } else {
    pages = [sections
        objectForKey:[_sections objectAtIndex:(NSUInteger)(
                                                  _sectionsMenu.selectedTag)]];
  }

  for (page in pages) {
    if (_searchField.stringValue.length > 0) {
      range = [page.name rangeOfString:_searchField.stringValue
                               options:NSCaseInsensitiveSearch];

      if (range.length == 0) {
        continue;
      }
    }

    cell = [ManualCell new];
    cell.representedObject = page;

    [_cells addObject:cell];
    [cell release];
  }

  return (NSInteger)[_cells count];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
  (void)outlineView;
  (void)item;

  return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item {
  (void)outlineView;
  (void)item;

  if (item != nil) {
    return nil;
  }

  return [_cells objectAtIndex:(NSUInteger)index];
}

- (id)outlineView:(NSOutlineView *)outlineView
    objectValueForTableColumn:(NSTableColumn *)tableColumn
                       byItem:(id)item {
  NSCell *cell;
  ManualPage *page;

  (void)outlineView;
  (void)tableColumn;

  cell = (NSCell *)item;
  page = (ManualPage *)cell.representedObject;

  if ([_sectionsMenu selectedTag] == -1) {
    return [NSString stringWithFormat:@"%@ (%@)", page.name, page.section];
  }

  return page.name;
}

@end
