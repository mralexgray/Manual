/*!
 * @header	  ManualHelper.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

@interface ManualHelper : NSObject {
@protected

  NSMutableDictionary *_sections;

@private

  id _ManualHelper_Reserved[5] __attribute__((unused));
}

@property(atomic, readonly) NSMutableDictionary *sections;

+ (ManualHelper *)sharedInstance;
- (void)getAllManualPages;

@end
