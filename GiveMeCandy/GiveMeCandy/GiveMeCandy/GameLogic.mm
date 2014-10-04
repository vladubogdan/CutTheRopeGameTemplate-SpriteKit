//
//  GameLogic.m
//  GiveMeCandy
//
//  Created by Presentation on 13/08/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "GameLogic.h"
#import "MainScene.h"
#import "LevelSelectScene.h"

@implementation GameLogic
{
    int totalStarsCaptured;
}
+(id)scene{    
    return [[GameLogic alloc] initWithContentOfFile:@"publishedResources/bambooForest_level2.lhplist"];
}

-(id)initWithContentOfFile:(NSString *)levelPlistFile{
    self = [super initWithContentOfFile:levelPlistFile];
    if(self){
        
        totalStarsCaptured = 0;
    }
    return self;
}

-(int)currentLevelID
{
    LevelInfo* lvlInfo = (LevelInfo*)[[self gameWorldNode] userProperty];
    
    if([lvlInfo isKindOfClass:[LevelInfo class]]){
        int lvlID = (int)[lvlInfo levelID];
        return lvlID;
    }
    return 0;
}

-(void)saveUserInfo
{
    NSUserDefaults* uDef = [NSUserDefaults standardUserDefaults];
    
    //we now create the key to save the total captured stars
    NSString* starsCapturedInfoKey = [NSString stringWithFormat:@"starsCapturedForLevelId%d", [self currentLevelID]];
    
    int savedStarsCount = (int)[uDef integerForKey:starsCapturedInfoKey];
    if(savedStarsCount <= totalStarsCaptured){
        [uDef setInteger:totalStarsCaptured forKey:starsCapturedInfoKey];
    }
    
    int topLevel = (int)[uDef integerForKey:@"topLevelReached"];
    if(topLevel <= [self currentLevelID]){
        [uDef setInteger:[self currentLevelID]+1 forKey:@"topLevelReached"];
    }
}

-(void)handleCandy:(SKNode*)candy collisionWithNode:(SKNode*)other
{
    if([other conformsToProtocol:@protocol(LHNodeProtocol)])
    {
        LHNode* n = (LHNode*)other;
        if([[n tags] containsObject:@"STAR"])
        {
            [n removeFromParent];
            
            ++totalStarsCaptured;
            
            return;//very important or else we might test for name using a dangled pointer later in this method
        }
    }
    if([[other name] isEqualToString:@"win"])
    {
        NSLog(@"WE HAVE WON THE LEVEL");
        [candy removeFromParent];
 
        [self saveUserInfo];
        
        [[self view] performSelector:@selector(presentScene:) withObject:[LevelSelectScene scene] afterDelay:2];
    }
    else{
        //we may have collided with an element from the level or the physics boundary (fail situation)
        
        if([[other name] isEqualToString:@"LHPhysicsBottomBoundary"])
        {
            [candy removeFromParent];
            NSLog(@"WE HAVE FAILED");
            
            [[self view] performSelector:@selector(presentScene:) withObject:[LevelSelectScene scene] afterDelay:2];
        }
    }
}

-(BOOL)shouldDisableCandy:(SKNode*)candy collisionWithNode:(SKNode*)other
{
    if([other conformsToProtocol:@protocol(LHNodeProtocol)])
    {
        LHNode* n = (LHNode*)other;
        if([[n tags] containsObject:@"STAR"])
        {
            return YES;
        }
    }
    
    return NO;
}

#if LH_USE_BOX2D

-(BOOL)shouldDisableContactBetweenNodeA:(SKNode *)a andNodeB:(SKNode *)b
{
    if([[a name] isEqualToString:@"candy"])
    {
        return [self shouldDisableCandy:a collisionWithNode:b];
    }
    else if([[b name] isEqualToString:@"candy"])
    {
        return [self shouldDisableCandy:b collisionWithNode:a];
    }
    
    return NO;
}


-(void)didBeginContactBetweenNodeA:(SKNode *)a andNodeB:(SKNode *)b atLocation:(CGPoint)scenePt withImpulse:(float)impulse
{

    if([[a name] isEqualToString:@"candy"])
    {
        [self handleCandy:a collisionWithNode:b];
    }
    else if([[b name] isEqualToString:@"candy"])
    {
        [self handleCandy:b collisionWithNode:a];
    }
}

#else //spritekit native collision handling
//when using spritekit native collision handling there is no way of disabling a contact
//you can use masks to ignore collision but then you will no longer get collision notifications

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKNode* a = [[contact bodyA] node];
    SKNode* b = [[contact bodyB] node];
    
    if([[a name] isEqualToString:@"candy"])
    {
        [self handleCandy:a collisionWithNode:b];
    }
    else if([[b name] isEqualToString:@"candy"])
    {
        [self handleCandy:b collisionWithNode:a];
    }
}

#endif

@end
