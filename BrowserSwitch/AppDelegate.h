#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
@public
	NSStatusItem* statusItem;
	NSMenu* menu;
	NSImage* safariIcon;
	NSImage* firefoxIcon;
	bool isSafari;
}

- (IBAction) statusItemClick: (id)sender;

@end
