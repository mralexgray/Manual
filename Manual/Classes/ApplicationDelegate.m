/*!
 * @file		ApplicationDelegate.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "ApplicationDelegate.h"
#import "AboutWindowController.h"
#import "MainWindowController.h"

@implementation ApplicationDelegate

- (void)dealloc {
  [_aboutWindowController release];
  [_mainWindowController release];

  [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  (void)notification;

  _mainWindowController = [MainWindowController new];

  [_mainWindowController.window center];
  [_mainWindowController showWindow:nil];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:
                                   (NSApplication *)sender {
  (void)sender;

  return NSTerminateNow;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:
            (NSApplication *)sender {
  (void)sender;

  return YES;
}

- (IBAction)showAboutWindow:(id)sender {
  if (_aboutWindowController == nil) {
    _aboutWindowController = [AboutWindowController new];
  }

  [_aboutWindowController.window center];
  [_aboutWindowController showWindow:sender];
}

@end
