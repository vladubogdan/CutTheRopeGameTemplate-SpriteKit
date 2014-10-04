//
//  GameGuide.h
//  GiveMeCandy
//
//  Created by Presentation on 13/08/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "GameLogic.h"

@interface GameGuide : GameLogic

+(id)sceneWithLevelFile:(NSString*)levelFileName;

@end
