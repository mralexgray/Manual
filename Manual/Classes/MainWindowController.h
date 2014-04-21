/*!
 * @header	  MainWindowController.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

@interface MainWindowController : NSWindowController {
@protected

  NSWindow *_loadingWindow;
  NSProgressIndicator *_progressBar;
  NSOutlineView *_outlineView;
  NSSearchField *_searchField;
  NSPopUpButton *_sectionsMenu;
  NSTextView *_textView;
  NSTextField *_label;
  NSMutableArray *_cells;
  NSArray *_sections;
  NSInteger _currentSection;
  BOOL _outlineViewShouldNotBecomeFirstResponder;

@private

  id _MainWindowController_Reserved[5] __attribute__((unused));
}

@property(nonatomic, readwrite, retain) IBOutlet NSWindow *loadingWindow;
@property(nonatomic, readwrite, retain)
    IBOutlet NSProgressIndicator *progressBar;
@property(nonatomic, readwrite, retain) IBOutlet NSOutlineView *outlineView;
@property(nonatomic, readwrite, retain) IBOutlet NSSearchField *searchField;
@property(nonatomic, readwrite, retain) IBOutlet NSPopUpButton *sectionsMenu;
@property(nonatomic, readwrite, retain) IBOutlet NSTextView *textView;
@property(nonatomic, readwrite, retain) IBOutlet NSTextField *label;

@end
