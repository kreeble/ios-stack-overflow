/*
 
 Erica Sadun, http://ericasadun.com
 
 */


#import "NSObject+ESNametag.h"
#import <objc/runtime.h>

static const char nametag_key; // Thanks Oliver Drobnik

@implementation NSObject (ESNametags)
// Nametag getter
- (id) nametag
{
    return objc_getAssociatedObject(self, (void *) &nametag_key);
}

// Nametag setter
- (void)setNametag:(NSString *) theNametag
{
    objc_setAssociatedObject(self, (void *) &nametag_key, theNametag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end