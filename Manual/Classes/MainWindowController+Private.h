/*!
 * @header	  MainWindowController+Private.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "MainWindowController.h"

@interface MainWindowController (Private)

- (void)didEndSheet:(NSWindow *)sheet
         returnCode:(NSInteger)returnCode
        contextInfo:(void *)contextInfo;
- (void)sectionsMenuSelectionDidChange:(id)sender;
- (void)mainWindowDidResize:(NSNotification *)notification;

@end
