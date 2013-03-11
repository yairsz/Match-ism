//
//  GameResult.h
//  Match-ism
//
//  Created by Yair Szarf on 2/13/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *) allGameResults;

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
