//
//  myTestViewController.m
//  myTest
//
//  Created by Administrator on 15/9/29.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import "myTestViewController.h"
#include <sys/sysctl.h>
#include <sys/resource.h>
#include <sys/vm.h>
#include <dlfcn.h>
#import "MobileGestalt.h"

@implementation myTestViewController

- (NSString *)platformString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = (char*)malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *sDeviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return sDeviceModel;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    CFStringRef boardID = MGCopyAnswer(kMGHardwarePlatform);
    [self.view setBackgroundColor:[self colorFromHexString:@"#e1e4e3"]];

    NSLog(@"%@",MGCopyAnswer(kMGDeviceColor));
    boardIDLabel.text = (__bridge NSString *)boardID;
    BOOL isA9 = NO;
    addition.text = @"";
    if ([(__bridge NSString *)boardID isEqualToString:@"s8000"]) {
        addition.text = @"Samsung";
        isA9 = YES;
    }
    if ([(__bridge NSString *)boardID isEqualToString:@"s8003"]) {
        addition.text = @"TSMC";
        isA9 = YES;
    }
    
    //[boardIDLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[addition setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[boardIDLabel setFont:[UIFont systemFontOfSize:36]];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
