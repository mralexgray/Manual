/*!
 * @file		ManualHelper.m
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

#import "ManualHelper.h"
#import "ManualPage.h"

static ManualHelper *__sharedInstance = nil;

@implementation ManualHelper

@synthesize sections = _sections;

+ (ManualHelper *)sharedInstance {
  @synchronized(self) {
    if (__sharedInstance == nil) {
      __sharedInstance = [[super allocWithZone:NULL] init];
    }
  }

  return __sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
  (void)zone;

  @synchronized(self) {
    return [[self sharedInstance] retain];
  }
}

- (id)copyWithZone:(NSZone *)zone {
  (void)zone;

  return self;
}

- (id)retain {
  return self;
}

- (NSUInteger)retainCount {
  return UINT_MAX;
}

- (oneway void)release {
}

- (id)autorelease {
  return self;
}

- (id)init {
  if ((self = [super init])) {
    _sections = [[NSMutableDictionary dictionaryWithCapacity:25] retain];
  }

  return self;
}

- (void)dealloc {
  [_sections release];

  [super dealloc];
}

- (void)getAllManualPages {
  NSTask *task;
  NSPipe *p;
  NSData *data;
  NSString *str;
  NSArray *lines;
  NSString *line;
  NSString *man;
  NSString *section;
  ManualPage *manual;
  NSRange range;

  @autoreleasepool {
    task = [NSTask new];
    p = [NSPipe pipe];

    [task setLaunchPath:@"/bin/zsh"];
    [task
        setArguments:[NSArray arrayWithObjects:@"-cl",
                                               @"apropos . | awk '{print $1}'",
                                               nil]];
    [task setStandardOutput:p];

    [task launch];

    data = [[p fileHandleForReading] readDataToEndOfFile];

    [task waitUntilExit];

    str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    lines = [str componentsSeparatedByString:@"\n"];
    lines = [lines
        sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    for (line in lines) {
      if (!line || !line.length) {
        continue;
      }

      range = [line rangeOfString:@"(" options:NSBackwardsSearch];

      @try {
        man = [line substringToIndex:range.location];
        section = [line substringFromIndex:range.location + 1];
        range = [section rangeOfString:@")"];
        section = [section substringToIndex:range.location];
      }
      @catch (NSException *e) {
        (void)e;

        continue;
      }

      if ([_sections objectForKey:section] == nil) {
        [_sections setObject:[NSMutableArray arrayWithCapacity:100]
                      forKey:section];
      }

      manual = [ManualPage manualWithName:man section:section];

      [[_sections objectForKey:section] addObject:manual];
    }
  }
}

@end
