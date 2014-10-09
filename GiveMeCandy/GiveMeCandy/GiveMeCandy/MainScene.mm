//
//  MainScene.m
//  GiveMeCandy
//
//  Created by Presentation on 29/07/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "MainScene.h"
#import "LevelSelectScene.h"

@implementation MainScene

+(id)scene{
    return [[MainScene alloc] initWithContentOfFile:@"publishedResources/MainScreen.lhplist"];
}

-(id)initWithContentOfFile:(NSString *)levelPlistFile
{
    self = [super initWithContentOfFile:levelPlistFile];
    if(self){
        
        //init your content here
        
        //for testing - reset the value
//        NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//        for (NSString *key in [defaultsDictionary allKeys]) {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//        }
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    return self;
}

-(void)didFinishedPlayingAnimation:(LHAnimation *)anim{
    
//    NSLog(@"DID FINISH ANIM %@", [anim name]);
    
    LHNode* node = (LHNode*)[anim node];
    
    if(node && ([[node name] isEqualToString:@"topLeafs"] || [[node name] isEqualToString:@"bottomLeafs"]))
    {
     
        NSArray* allAnimations = [node animations];
        int newAnimIdx = arc4random() % [allAnimations count];
        LHAnimation* newAnim = [allAnimations objectAtIndex:newAnimIdx];
        [node setActiveAnimation:newAnim];
        [newAnim restart];
    }
}

-(void)goToPlayMenu
{
    NSLog(@"GO TO PLAY");
    [[self view] presentScene:[LevelSelectScene scene]];
}

-(void)goToAboutMenu
{
    NSLog(@"GO TO ABOUT");
}

-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self gameWorldNode] nodesAtPoint:location];
    
    for(SKNode* node in nodes)
    {
        if([[node name] isEqualToString:@"playButton"])
        {
            [self goToPlayMenu];
        }
        else if([[node name] isEqualToString:@"aboutButton"])
        {
            [self goToAboutMenu];
        }
    }
}

#if TARGET_OS_IPHONE

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch* touch in touches)
    {
        CGPoint location = [touch locationInNode:[self gameWorldNode]];
        [self handleNodesAtLocation:location];
    }
    
    [super touchesEnded:touches withEvent:event];
}

#else

-(void)mouseUp:(NSEvent *)theEvent
{
    CGPoint location = [theEvent locationInNode:[self gameWorldNode]];
    [self handleNodesAtLocation:location];
}

#endif


@end
