//
//  CardMatchingGame.h
//  Match-ism
//
//  Created by Yair Szarf on 2/4/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated Initializer
- (id) initWithCardCount:(NSUInteger)cardCount
               usingDeck:(Deck *) deck;

- (void) flipCardAtIndex: (NSUInteger) index;

- (Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString * resultSring;
@property (nonatomic) int playMode;


@end
