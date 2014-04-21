/*!
 * @header	  ApplicationDelegate.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

@class AboutWindowController;
@class MainWindowController;

@interface ApplicationDelegate : NSObject {
@protected

  AboutWindowController *_aboutWindowController;
  MainWindowController *_mainWindowController;

@private

  id _ApplicationDelegate_Reserved[5] __attribute__((unused));
}

- (IBAction)showAboutWindow:(id)sender;

@end
