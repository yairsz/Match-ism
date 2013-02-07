//
//  PlayingCard.m
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit; //This property must be synthesized because we are customizing get/set

- (int) match: (NSArray *) otherCards
{
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard * otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    }else if (otherCards.count == 2) {
        PlayingCard * card2 = [otherCards objectAtIndex:0];
        PlayingCard * card3 = [otherCards objectAtIndex:1];
        if ([card2.suit isEqualToString:self.suit] && [card3.suit isEqualToString:self.suit]) {
            score = 4;
        } else if (card2.rank ==self.rank && card3.rank == self.rank){
            score = 12;
            
        }
    }
    
    return score;
}


+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings [self.rank] stringByAppendingString:self.suit];
    
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }


-(void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }        
}

@end
