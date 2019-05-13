#import "AppDelegate.h"

NSString* firefoxBundleIdentifier = @"org.mozilla.firefox";
NSString* safariBundleIdentifier = @"com.apple.safari";

@implementation AppDelegate

- (void)applicationDidFinishLaunching: (NSNotification*)n {
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	NSBundle* bundle = [NSBundle mainBundle];
	safariIcon = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"safari" ofType:@"tiff"]];
	firefoxIcon = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"firefox" ofType:@"tiff"]];
	
	CFStringRef cf_defaultHandler = LSCopyDefaultHandlerForURLScheme((__bridge CFStringRef)@"https");
	NSString* defaultHandler = (__bridge NSString*) cf_defaultHandler;
	if ([defaultHandler isEqualToString:firefoxBundleIdentifier]) {
		[statusItem setImage:firefoxIcon];
		isSafari = false;
	} else if ([defaultHandler isEqualToString:safariBundleIdentifier]) {
		[statusItem setImage:safariIcon];
		isSafari = true;
	} else {
		NSAlert *alert = [NSAlert alertWithMessageText:@"Default browser unknown" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
		[alert runModal];
		[NSApp terminate:nil];
	}
	CFRelease(cf_defaultHandler);
	
	[statusItem setHighlightMode:YES];
	[statusItem setAction:@selector(statusItemClick:)];
	[statusItem setTarget:self];
	[statusItem setToolTip:@"⌘-click to quit"];
}

- (IBAction) statusItemClick: (id)sender {
	NSEvent* event = [NSApp currentEvent];
	if ([[NSApp currentEvent] modifierFlags] & NSCommandKeyMask) {
		[NSApp terminate:nil];
	} else {
		
		NSString* newBundleIdentifier = nil;
		if (isSafari) {
			newBundleIdentifier = firefoxBundleIdentifier;
			[statusItem setImage:firefoxIcon];
			isSafari = false;
		} else {
			newBundleIdentifier = safariBundleIdentifier;
			[statusItem setImage:safariIcon];
			isSafari = true;
		}
		
		LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)@"https", (__bridge CFStringRef)newBundleIdentifier);
		LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)@"http", (__bridge CFStringRef)newBundleIdentifier);
		
	}
}

@end
