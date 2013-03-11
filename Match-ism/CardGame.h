//
//  CardGame.h
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardGame : NSObject


@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString * resultSring;
@property (nonatomic) int playMode;
@property (strong, nonatomic) NSMutableArray * cards; //of card
@property int matchBonus,mismatchPenalty,flipCost;

//designated Initializer
- (id) initWithCardCount:(NSUInteger)cardCount
               usingDeck:(Deck *) deck;

- (void) flipCardAtIndex: (NSUInteger) index; //abstract

- (Card *) cardAtIndex: (NSUInteger) index;


- (void) defineBonusSchemeWithArray:(NSArray *) array; //order:Bonus,Penalty,Cost

@end
