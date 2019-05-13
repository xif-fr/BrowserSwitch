#import <Cocoa/Cocoa.h>
#import <AppDelegate.h>

int main(int argc, const char * argv[]) {
	NSApplication* application = [NSApplication sharedApplication];
	AppDelegate* appDel = [[AppDelegate alloc] init];
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
	ProcessSerialNumber psn = { 0, kCurrentProcess };
	TransformProcessType(&psn, kProcessTransformToUIElementApplication);
	[application setDelegate:appDel];
	[application run];
	[appDel release];
	return 0;
}
