/*
 
 Erica Sadun, http://ericasadun.com
 
 */

@import Foundation;

@interface NSObject (ESDebuggingExtensions)
@property (nonatomic, readonly) NSString *objectIdentifier;
@property (nonatomic, readonly) NSString *objectName;
@property (nonatomic, readonly) NSString *consoleDescription;
@end

