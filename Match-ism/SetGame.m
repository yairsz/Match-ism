//
//  SetGame.m
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "SetGame.h"

@interface SetGame()
@property (readwrite, nonatomic)  int score;



@end

@implementation SetGame

-(void)flipCardAtIndex:(NSUInteger)index
{
 
Card * card = [self cardAtIndex:index];
NSMutableArray * otherCards = [[NSMutableArray alloc] init]; //of faceUp Cards

if (!card.isUnplayable) {
    self.result = self.flipCost;
    self.resultCode = 3;
    if (!card.isFaceUp) {
        for (Card *otherCard in self.cards) {   //search through cards for faceup cards
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                [otherCards addObject:otherCard];
                if  ([otherCards count] == 2) { //3 cards are selected and we need to check for a match
                    int matchScore = [card match:otherCards];
                    
                    //get the cards from array
                    Card * card2 = [otherCards objectAtIndex:0];
                    Card * card3 = [otherCards objectAtIndex:1];
                    
                    if (matchScore) {// WE HAVE A SET!
                        card2.unplayable = card3.unplayable = card.unplayable = YES; //make all three cards unplayable
                        self.score += matchScore * (self.matchBonus+2);  //update score
                        self.result= matchScore * (self.matchBonus+2);
                        self.resultCode=1;
                    } else { // THIRD CARD WASN'T A MATCH!! OOPS!
                        card.faceUp = NO;
                        card2.faceUp = NO;
                        card3.faceUp = NO;
                        self.score -= self.mismatchPenalty;
                        self.result= self.mismatchPenalty;
                        self.resultCode=2;
                    }
                    break;
                } else if ([otherCards count] == 1) { //this is the first faceup card,so we need another card to check for a set
                        otherCard.faceUp = YES;
//                        self.score -= self.mismatchPenalty;
                }
                
            }
        }
        self.score -= self.flipCost;
        
    }
    if (card.faceUp) self.result = nil;
    card.faceUp = !card.faceUp;
}

}



@end
