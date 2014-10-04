//
//  LevelButtonAsset.h
//  GiveMeCandy
//
//  Created by Presentation on 19/09/14.
//  Copyright (c) 2014 VLADU BOGDAN DANIEL PFA. All rights reserved.
//

#import "LHAsset.h"
#import "LevelHelper2API.h"

@interface LevelButtonAsset : LHAsset

+ (instancetype)nodeWithDictionary:(NSDictionary*)dict
                            parent:(SKNode*)prnt;

- (instancetype)initWithDictionary:(NSDictionary*)dict
                            parent:(SKNode*)prnt;

-(BOOL)isUnlocked;

-(NSString*)levelFile;

@end
