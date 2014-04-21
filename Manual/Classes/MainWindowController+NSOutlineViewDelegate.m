/*!
 * @file		MainWindowController+NSOutlineViewDelegate.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController+NSOutlineViewDelegate.h"
#import "ManualPage.h"

@implementation MainWindowController (NSOutlineViewDelegate)

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
  NSCell *cell;
  ManualPage *page;
  NSString *contents;
  NSMutableArray *lines;
  NSString *line;
  NSMutableAttributedString *attributedLine;
  NSMutableAttributedString *attributedContents;

  (void)notification;

  if ([_cells count] == 0) {
    return;
  }

  cell = [_cells objectAtIndex:(NSUInteger)[_outlineView selectedRow]];
  page = (ManualPage *)cell.representedObject;
  contents =
      [page contentsForWidth:(NSUInteger)(_textView.frame.size.width / 6)];
  lines = [[contents componentsSeparatedByString:@"\n"] mutableCopy];
  attributedContents = [[NSMutableAttributedString alloc] init];

  [_label setStringValue:[NSString stringWithFormat:@"%@ (%@) - %@", page.name,
                                                    page.section, page.about]];

  for (line in lines) {
    attributedLine = [[NSMutableAttributedString alloc]
        initWithString:[line stringByAppendingString:@"\n"]];

    if (line.length > 0 &&
        ([line characterAtIndex:0] == 9 || [line characterAtIndex:0] == 32)) {
      [attributedLine removeAttribute:NSFontAttributeName
                                range:NSMakeRange(0, attributedLine.length)];
      [attributedLine
          addAttributes:@{NSFontAttributeName:[NSFont fontWithName:@"UbuntuMono-Bold" size:15.],
                          NSForegroundColorAttributeName: [NSColor colorWithDeviceWhite:.95 alpha:1]}
                 range:NSMakeRange(0, attributedLine.length)];
    } else {
      [attributedLine removeAttribute:NSFontAttributeName
                                range:NSMakeRange(0, attributedLine.length)];
      [attributedLine addAttributes:@{NSFontAttributeName:[NSFont fontWithName:@"UbuntuTitling-Bold" size:18],
                                      NSForegroundColorAttributeName:NSColor.orangeColor}
                             range:NSMakeRange(0, attributedLine.length)];
    }

    [attributedContents insertAttributedString:attributedLine
                                       atIndex:attributedContents.length];
    [attributedLine release];
  }

  [_textView.textStorage setAttributedString:attributedContents];
  [lines release];
  [attributedContents release];

  if (_outlineViewShouldNotBecomeFirstResponder == NO) {
    [_outlineView becomeFirstResponder];
    [self.window makeFirstResponder:_outlineView];
  }
}

@end
