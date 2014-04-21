

@class BackgroundView;

@interface AboutWindowController : NSWindowController {
@private

  BackgroundView *_backgroundView;
  NSTextField *_versionText;
}

@property(nonatomic, readwrite, retain) IBOutlet BackgroundView *backgroundView;
@property(nonatomic, readwrite, retain) IBOutlet NSTextField *versionText;

@end
