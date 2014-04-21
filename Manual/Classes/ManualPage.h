/*!
 * @header	  ManualPage.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

@interface ManualPage : NSObject {
@protected

  NSString *_section;
  NSString *_name;
  NSString *_about;
  NSString *_contents;
  NSUInteger _contentsWidth;

@private

  id _Manual_Reserved[5] __attribute__((unused));
}

@property(atomic, readonly) NSString *section;
@property(atomic, readonly) NSString *name;
@property(atomic, readonly) NSString *about;
@property(atomic, readonly) NSString *contents;

+ (ManualPage *)manualWithName:(NSString *)n section:(NSString *)s;
- (id)initWithName:(NSString *)n section:(NSString *)s;
- (NSString *)contentsForWidth:(NSUInteger)width;

@end
