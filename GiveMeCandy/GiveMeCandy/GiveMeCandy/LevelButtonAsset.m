//
//  LevelButtonAsset.m
//  GiveMeCandy
//
//  Created by Presentation on 19/09/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "LevelButtonAsset.h"

@implementation LevelButtonAsset

+ (instancetype)nodeWithDictionary:(NSDictionary*)dict
                            parent:(SKNode*)prnt{
    
    return LH_AUTORELEASED([[self alloc] initWithDictionary:dict parent:prnt]);
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
                            parent:(SKNode*)prnt{
    
    self = [super initWithDictionary:dict parent:prnt];
    if(self)
    {
        //init your content here
//        NSLog(@"Did create object of type %@ with name %@", NSStringFromClass([self class]), [self name]);
        
        //at this point all the info should be present
        
        LHSprite* counterSprite = (LHSprite*)[self childNodeWithName:@"counter"];
        if(counterSprite){
            NSString* spriteFrameName = [NSString stringWithFormat:@"levelSelect%d", [self levelID]];
            [counterSprite setSpriteFrameWithName:spriteFrameName];
        }
        
        if([self isUnlocked]){
            LHSprite* lockSprite = (LHSprite*)[self childNodeWithName:@"lock"];
            if(lockSprite){
                [lockSprite setAlpha:0];
            }
            
            
            int unlockedStars = [self numberOfUnlockedStars];
            if(unlockedStars > 0)
            {
                LHSprite* starA = (LHSprite*)[self childNodeWithName:@"fillStarA"];
                if(starA){
                    [starA setAlpha:255];
                }
                
                if(unlockedStars > 1){
                    LHSprite* starB = (LHSprite*)[self childNodeWithName:@"fillStarB"];
                    if(starB){
                        [starB setAlpha:255];
                    }
                }
                
                if(unlockedStars > 2){
                    LHSprite* starC = (LHSprite*)[self childNodeWithName:@"fillStarC"];
                    if(starC){
                        [starC setAlpha:255];
                    }
                }
            }
        }
    }
    return self;
}

-(BOOL)isUnlocked{
    if([self levelID] == 1)return true;
    
    //check if level is unlocked here
    int topLevel = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"topLevelReached"];
    
    return [self levelID] <= topLevel;
}

-(int)numberOfUnlockedStars
{
    if(![self isUnlocked])return 0;

    NSString* info = [NSString stringWithFormat:@"starsCapturedForLevelId%d", [self levelID]];
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:info];
}

-(int)levelID{
    ButtonInfo* assetUserInfo = (ButtonInfo*)[self userProperty];
    if([assetUserInfo isKindOfClass:[ButtonInfo class]]){
        int lvlID = (int)[assetUserInfo levelID];
        return lvlID;
    }
    return -1;
}

-(NSString*)levelFile{
    ButtonInfo* assetUserInfo = (ButtonInfo*)[self userProperty];
    if([assetUserInfo isKindOfClass:[ButtonInfo class]]){
        return [assetUserInfo levelFile];
    }
    return nil;
}

@end
