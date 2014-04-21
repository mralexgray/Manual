

#import "AboutWindowController.h"
#import "BackgroundView.h"

@implementation AboutWindowController

@synthesize backgroundView = _backgroundView;
@synthesize versionText = _versionText;

- (id)init {
  return [self initWithWindowNibName:@"AboutWindow" owner:self];
}

- (void)dealloc {
  [_backgroundView release];
  [_versionText release];

  [super dealloc];
}

- (void)awakeFromNib {
  NSString *version;

  version = [[[NSBundle mainBundle] infoDictionary]
      objectForKey:@"CFBundleShortVersionString"];

  _backgroundView.backgroundColor = [NSColor whiteColor];
  _versionText.stringValue =
      [NSString stringWithFormat:NSLocalizedString(@"Version", nil), version];
}

@end
