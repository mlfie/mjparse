//
//  main.m
//  helloworld
//
//  Created by fetaro on 5/7/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"helloworldAppDelegate");
    [pool release];
    return retVal;
}
