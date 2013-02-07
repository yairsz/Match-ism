//
//  PlayingCard.h
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*) validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end

