/*
 
 Erica Sadun, http://ericasadun.com
 
 */

@import Foundation;

// A nametag is an associated string object that can be assigned to any object.
// Similar in intent and nature to UIView's "tag" property, it allows you to
// assign readable text to objects for annotation and searching.

#pragma mark - Support nametags universally
@interface NSObject (ESNametags)
@property (nonatomic, strong) NSString *nametag;
@end

