/*!
 * @file		ManualPage.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "ManualPage.h"

@implementation ManualPage

@synthesize section = _section;
@synthesize name = _name;

+ (ManualPage *)manualWithName:(NSString *)n section:(NSString *)s {
  ManualPage *man;

  man = [[ManualPage alloc] initWithName:n section:s];

  return [man autorelease];
}

- (id)init {
  if ((self = [super init])) {
    _contentsWidth = 80;
  }

  return self;
}

- (id)initWithName:(NSString *)n section:(NSString *)s {
  if ((self = [self init])) {
    _section = [s copy];
    _name = [n copy];
  }

  return self;
}

- (void)dealloc {
  [_section release];
  [_name release];
  [_about release];
  [_contents release];

  [super dealloc];
}

- (NSString *)description {
  return [[super description]
      stringByAppendingFormat:@" - %@ (%@)", _name, _section];
}

- (NSString *)contentsForWidth:(NSUInteger)width {
  _contentsWidth = width;

  return self.contents;
}

- (NSString *)contents {
  NSTask *t;
  NSPipe *p;
  NSData *d;
  NSString *s;

  @autoreleasepool {
    t = [NSTask new];
    p = [NSPipe pipe];

    [t setLaunchPath:@"/bin/zsh"];
    [t setArguments:
            [NSArray arrayWithObjects:
                         @"-c",
                         [NSString stringWithFormat:
                                       @"man %@ %@ | col -b | awk '{print $0}'",
                                       _section, _name],
                         nil]];
    [t setStandardOutput:p];
    [t setEnvironment:[NSDictionary
                          dictionaryWithObjectsAndKeys:
                              [NSString
                                  stringWithFormat:@"%lu", _contentsWidth],
                              @"MANWIDTH", nil]];

    [t launch];

    d = [[p fileHandleForReading] readDataToEndOfFile];

    [t waitUntilExit];

    s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];

    [t release];

    _contents = s;

    return _contents;
  }
}

- (NSString *)about {
  NSTask *t;
  NSPipe *p;
  NSData *d;
  NSString *s;
  NSArray *lines;
  NSRange range;

  @autoreleasepool {
    if (_about != nil) {
      return _about;
    }

    t = [NSTask new];
    p = [NSPipe pipe];

    [t setLaunchPath:@"/bin/zsh"];
    [t setArguments:[NSArray
                        arrayWithObjects:
                            @"-c",
                            [NSString stringWithFormat:@"whatis ^%@\\(%@\\)",
                                                       _name, _section],
                            nil]];
    [t setStandardOutput:p];

    [t launch];

    d = [[p fileHandleForReading] readDataToEndOfFile];

    [t waitUntilExit];

    s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    lines = [s componentsSeparatedByString:@"\n"];

    [s release];
    [t release];

    s = [lines objectAtIndex:0];
    range = [s rangeOfString:@"- "];

    @try {
      s = [s substringFromIndex:range.location + 1];
      s = [s stringByTrimmingCharactersInSet:[NSCharacterSet
                                                     whitespaceCharacterSet]];
    }
    @catch (NSException *e) {
      (void)e;

      s = nil;
    }

    _about = [s copy];

    return _about;
  }
}

@end
