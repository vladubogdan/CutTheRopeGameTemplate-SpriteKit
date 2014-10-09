//
//  GameGuide.m
//  GiveMeCandy
//
//  Created by Presentation on 13/08/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "GameGuide.h"

@implementation GameGuide

+(id)scene{
    return [[GameGuide alloc] initWithContentOfFile:@"publishedResources/bambooForest_level2.lhplist"];
}

+(id)sceneWithLevelFile:(NSString*)levelFileName{
    
    NSString* file = [NSString stringWithFormat:@"publishedResources/%@.lhplist", levelFileName];
    return [[GameGuide alloc] initWithContentOfFile:file];
}

-(id)initWithContentOfFile:(NSString *)levelPlistFile{
    self = [super initWithContentOfFile:levelPlistFile];
    if(self){
        
        NSLog(@"WE CREATED A LEVEL WITH GAME GUIDE");
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"DidPresentGuide"])
        {
            [self hideGuide];
        }
    }
    return self;
}

-(void)hideGuide
{
    LHNode* node = (LHNode*)[self childNodeWithName:@"guideLine"];
    if(node){
        [node removeFromParent];
    }
    node = (LHNode*)[self childNodeWithName:@"guideHand"];
    if(node){
        [node removeFromParent];
    }
}

-(void)didCutRopeJoint:(LHRopeJointNode *)joint
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"DidPresentGuide"];
    
    [self performSelector:@selector(hideGuide) withObject:nil afterDelay:1];
}

@end
