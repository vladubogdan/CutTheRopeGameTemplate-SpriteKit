//
//  LevelSelectScene.m
//  GiveMeCandy
//
//  Created by Bogdan Vladu on 29/07/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "LevelSelectScene.h"
#import "GameLogic.h"
#import "GameGuide.h"
#import "LevelButtonAsset.h"
#import "MainScene.h"

@implementation LevelSelectScene

+(id)scene{
    return [[LevelSelectScene alloc] initWithContentOfFile:@"publishedResources/levelSelectScreen.lhplist"];
}

-(id)initWithContentOfFile:(NSString *)levelPlistFile
{
    self = [super initWithContentOfFile:levelPlistFile];
    if(self){
        
        //init your content here
        
    }
    return self;
}

-(Class)createNodeObjectForSubclassWithName:(NSString *)subclassTypeName superTypeName:(NSString *)superTypeName
{
    //you may ask why doesn't LevelHelper2-API do this - thats because the API does not have access to your own classes. NSClassFromString will return nil if the class in question is not imported in the file where it's executed.
    
    //DO NOT FORGET TO #import your class header.
    return NSClassFromString(subclassTypeName);
}


-(void)goToLevel:(NSString*)levelName
{
    [[self view] presentScene:[GameGuide sceneWithLevelFile:levelName]];
}

-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self gameWorldNode] nodesAtPoint:location];
    
    for(SKNode* node in nodes)
    {
        if([node isKindOfClass:[LevelButtonAsset class]])
        {
            if([(LevelButtonAsset*)node isUnlocked]){
                [self goToLevel:[(LevelButtonAsset*)node levelFile]];
            }
        }
        
        if([[node name] isEqualToString:@"goToMainMenu"])
        {
            [[self view] presentScene:[MainScene scene]];
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
