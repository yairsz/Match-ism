//
//  CardMatchingGame.m
//  Match-ism
//
//  Created by Yair Szarf on 2/4/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray * cards; //of card
@property (readwrite, nonatomic) int score;
@property (nonatomic, readwrite) NSString * resultSring;

@end

@implementation CardMatchingGame

-(CardMatchingGame *) init
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

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH2_BONUS 4
#define MATCH3_BONUS 8
#define MISMATCH_PENALTY 2

- (void) flipCardAtIndex:(NSUInteger)index
{
    switch (self.playMode) { //card matching will depend on the playMode
        case 1:
            [self match3:index];
            break;
        default: //go by default to case 2 might be modified if other playModes are added in the future
            [self match2:index];
            break;
    }    
}

- (void) match2:(NSUInteger) index
{
    Card * card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        self.resultSring = [NSString stringWithFormat:@"Flipped %@\n",card.contents];
        if (!card.isFaceUp) {
            //see if flipping this card up creates a match
            for (Card *otherCard in self.cards) { //search through cards for faceup cards
                if (otherCard.isFaceUp && !otherCard.isUnplayable) { 
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        int playScore = matchScore * MATCH2_BONUS;
                        self.score += playScore;
                        self.resultSring = [NSString stringWithFormat:@"Matched %@ & %@\nfor %d points",card.contents,otherCard.contents,playScore];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.resultSring = [NSString stringWithFormat:@"%@ & %@ don't match!\n%d point penalty",card.contents,otherCard.contents,MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
            
        }
        if (card.faceUp) self.resultSring = nil;
        card.faceUp = !card.faceUp;
    }
    
}

- (void) match3:(NSUInteger) index
{
    Card * card = [self cardAtIndex:index];
    NSMutableArray * otherCards = [[NSMutableArray alloc] init]; //of faceUp Cards
   
    if (!card.isUnplayable) {
        self.resultSring = [NSString stringWithFormat:@"Flipped %@\n",card.contents];
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {   //search through cards for faceup cards
                if (otherCard.isFaceUp && !otherCard.isUnplayable) { 
                    [otherCards addObject:otherCard];
                    if  ([otherCards count] == 2) { //the 2nd card is matched already and we need to check the 3rd card
                        int matchScore = [card match:otherCards];
                        
                        //get the cards from array
                        Card * card2 = [otherCards objectAtIndex:0];
                        Card * card3 = [otherCards objectAtIndex:1];
                        
                        if (matchScore) {// WE HAVE A TRIPLE MATCH!
                            card2.unplayable = card3.unplayable = card.unplayable = YES; //make all three cards unplayable
                            int playScore = matchScore * MATCH3_BONUS;
                            self.score += playScore;                                     //update score
                            self.resultSring = [NSString stringWithFormat:@"Matched %@ %@ %@\nfor %d points!",card.contents,card2.contents, card3.contents,playScore];
                        } else { // THIRD CARD WASN'T A MATCH!! OOPS!
                        card2.faceUp = NO;
                        card3.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.resultSring = [NSString stringWithFormat:@"%@ %@ %@ don't match!\n%d point penalty",card.contents,card2.contents,card3.contents,MISMATCH_PENALTY];
                        }
                    break;
                    } else if ([otherCards count] == 1) { //this is the first faceup card,so we need to check if its a match
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) { 
                            self.resultSring = [NSString stringWithFormat:@"Matched %@ & %@\nfind another match",card.contents,otherCard.contents];
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.resultSring = [NSString stringWithFormat:@"%@ & %@ don't match!\n%d point penalty",card.contents,otherCard.contents,MISMATCH_PENALTY];
                        }                    
                    }

                }
            }
            self.score -= FLIP_COST;
            
        }
        if (card.faceUp) self.resultSring = nil;
        card.faceUp = !card.faceUp;
    }
    
}


@end
