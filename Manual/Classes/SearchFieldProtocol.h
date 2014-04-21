/*!
 * @header	  SearchFieldProtocol.h
 * @copyright   (c) 2013, Jean-David Gadina - www.xs-labs.com
 * @abstract	...
 */

@class SearchField;

@protocol SearchFieldProtocol <NSTextFieldDelegate>

@optional

- (void)searchFieldValueDidChange:(SearchField *)searchField;

@end
