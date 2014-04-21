/*!
 * @file		SearchField.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "SearchField.h"
#import "SearchFieldProtocol.h"

@implementation SearchField

- (void)textDidChange:(NSNotification *)notification {
  (void)notification;

  if (self.delegate != nil &&
      [self.delegate
          respondsToSelector:@selector(searchFieldValueDidChange:)]) {
    [self.delegate performSelector:@selector(searchFieldValueDidChange:)];
  }
}

@end
