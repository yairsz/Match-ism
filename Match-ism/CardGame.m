//
//  CardGame.m
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "CardGame.h"

@interface CardGame ()
@property (readwrite, nonatomic) int score;
@property (nonatomic, readwrite) NSString * resultSring;


@end

@implementation CardGame

#pragma mark Initializers
-(CardGame *) init
{
    return nil;
}


-(id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i =0; i < count; i++)
        {
            Card * card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

#pragma mark Setters and Getters

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


#pragma mark Instance methods

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}

-(void) flipCardAtIndex:(NSUInteger)index {
    //abstract
}

-(void) defineBonusSchemeWithArray:(NSArray *)array {
    self.matchBonus = [array[0] intValue];
    self.mismatchPenalty = [array[1] intValue];
    self.flipCost = [array[2] intValue];
}

@end

