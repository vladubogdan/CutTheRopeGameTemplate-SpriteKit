//
//  AppDelegate.m
//  SpriteKitMac
//
//  Created by Bogdan Vladu on 26/07/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "AppDelegateMac.h"
#import "MainScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate
{
    AVAudioPlayer* backgroundMusicPlayer;
}

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [MainScene scene];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    
    NSError *error = nil;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"jungleTheme" withExtension:@"caf"];
    backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    backgroundMusicPlayer.numberOfLoops = INFINITY;
    [backgroundMusicPlayer play];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
