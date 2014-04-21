/*!
 * @file		AboutWindowController.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController.h"
#import "MainWindowController+Private.h"
#import "MainWindowController+NSOutlineViewDelegate.h"
#import "MainWindowController+NSOutlineViewDataSource.h"
#import "MainWindowController+SearchFieldDelegate.h"
#import "ManualHelper.h"

@implementation MainWindowController

@synthesize loadingWindow = _loadingWindow;
@synthesize progressBar = _progressBar;
@synthesize outlineView = _outlineView;
@synthesize searchField = _searchField;
@synthesize sectionsMenu = _sectionsMenu;
@synthesize textView = _textView;
@synthesize label = _label;

- (id)init {
  if ((self = [super initWithWindowNibName:@"MainWindow"])) {
    _cells = [[NSMutableArray arrayWithCapacity:1000] retain];
    _currentSection = -10;
  }

  return self;
}

- (void)dealloc {
  [_loadingWindow release];
  [_progressBar release];
  [_outlineView release];
  [_searchField release];
  [_sectionsMenu release];
  [_textView release];
  [_label release];
  [_cells release];
  [_sections release];

  [super dealloc];
}

- (void)awakeFromNib {
  [_searchField setDelegate:self];
  [_label setStringValue:@""];
  [_loadingWindow setPreventsApplicationTerminationWhenModal:NO];
  [_progressBar startAnimation:nil];

  [self.window setContentBorderThickness:(CGFloat)25 forEdge:NSMinYEdge];
  [(NSNotificationCenter *)[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(mainWindowDidResize:)
             name:NSWindowDidEndLiveResizeNotification
           object:self.window];
}

- (void)showWindow:(id)sender {
  [super showWindow:sender];
  [NSApp beginSheet:_loadingWindow
      modalForWindow:self.window
       modalDelegate:self
      didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
         contextInfo:nil];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                 ^{
      NSString *section;
      NSString *sectionKey;
      NSString *sectionDescription;
      NSInteger i;

      [[ManualHelper sharedInstance] getAllManualPages];

      [_sectionsMenu setTarget:self];
      [_sectionsMenu setAction:@selector(sectionsMenuSelectionDidChange:)];
      [_sectionsMenu addItemWithTitle:NSLocalizedString(@"AllSections", nil)];
      [[_sectionsMenu itemAtIndex:0] setTag:-1];
      [_sectionsMenu.menu addItem:[NSMenuItem separatorItem]];

      _sections = [[[[[ManualHelper sharedInstance] sections] allKeys]
          sortedArrayUsingSelector:
              @selector(localizedCaseInsensitiveCompare:)] retain];

      i = 0;

      for (section in _sections) {
        sectionKey = [NSString stringWithFormat:@"Section-%@", section];
        sectionDescription = NSLocalizedString(sectionKey, nil);

        if ([sectionDescription isEqualToString:sectionKey]) {
          sectionDescription = NSLocalizedString(@"UnknownSection", nil);
        }

        [_sectionsMenu
            addItemWithTitle:
                [NSString
                    stringWithFormat:@"%@ - %@ (%lu)", sectionDescription,
                                     section,
                                     [[[[ManualHelper sharedInstance] sections]
                                         objectForKey:section] count]]];
        [[_sectionsMenu itemAtIndex:i + 2] setTag:i];

        i++;
      }

      self.window.title = [NSString
          stringWithFormat:@"%@ - %@", NSLocalizedString(@"WindowTitle", nil),
                           _sectionsMenu.selectedItem.title];

      [NSThread sleepForTimeInterval:0.5];

      [_outlineView performSelector:@selector(setDelegate:)
                           onThread:[NSThread mainThread]
                         withObject:self
                      waitUntilDone:YES];
      [_outlineView performSelector:@selector(setDataSource:)
                           onThread:[NSThread mainThread]
                         withObject:self
                      waitUntilDone:YES];

      [NSApp performSelector:@selector(endSheet:)
                    onThread:[NSThread mainThread]
                  withObject:_loadingWindow
               waitUntilDone:NO];
  });
}

@end
