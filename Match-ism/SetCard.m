//
//  SetCard.m
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

# pragma mark Class Methods
+ (NSArray *) validNumbers{
    return @[@1,@2,@3];
}
+ (NSArray *) validStrokeColors{
    return @[@1,@2,@3];
}

+ (NSArray *) validForegroundColors {
    return @[@1,@2,@3];
}

+ (NSArray *) validSymbols{
    return @[@"▲",@"●",@"■"];  
}

//+ (NSArray *) attributes {
//    return @[];
//}

#pragma mark Setters and Getters

- (void) setNumber:(NSNumber *)number
{
    if ([[SetCard validNumbers] containsObject:number])
        _number = number;
}

- (void) setStrokeColor:(NSString *)strokeColor
{
    if ([[SetCard validStrokeColors] containsObject:strokeColor])
        _strokeColor =strokeColor;
}


-(void) setForegroundColor:(NSString *)foregroundColor
{
    if ([[SetCard validForegroundColors] containsObject:foregroundColor])
        _foregroundColor = foregroundColor;
}


-(void) setSymbol:(NSString *)symbol
{
    if([[SetCard validSymbols] containsObject:symbol])
        _symbol =symbol;
}



#pragma mark Instance Methods
- (int) match: (NSArray *) otherCards
{
    int score = 0;

    if (otherCards.count == 2) {
        SetCard * card2 = otherCards[0];
        SetCard * card3 = otherCards[1];
        if (([self isEqualOrAllDifferent:@[self.number,card2.number,card3.number]]) &&
            ([self isEqualOrAllDifferent:@[self.strokeColor,card2.strokeColor,card3.strokeColor]]) &&
            ([self isEqualOrAllDifferent:@[self.foregroundColor,card2.foregroundColor,card3.foregroundColor]]) &&
            ([self isEqualOrAllDifferent:@[self.symbol,card2.symbol,card3.symbol]]))
              {
                  score = 12;
              }
    }
    
    return score;
}

-(BOOL) isEqualOrAllDifferent:(NSArray *) objects {
    
    BOOL isEqualOrAllDifferent = NO;
    if ([objects count] == 3){
        if (([objects[0] isEqual:objects[1]] && [objects[0] isEqual:objects[2]]) ||
            (![objects[0] isEqual:objects[1]] && ![objects[0] isEqual:objects[1]] && ![objects[1] isEqual:objects[2]]))
        {
            isEqualOrAllDifferent =YES;
        }
    }
    return isEqualOrAllDifferent;
}


@end
