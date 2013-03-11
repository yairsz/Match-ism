//
//  SetCardDeck.m
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "SetCardDeck.h"


@implementation SetCardDeck

- (id) init
{
    self = [super init];
    if (self) {
        for (NSNumber * numberOfSymbols in [SetCard validNumbers]){
            for (NSString * strokeColor in [SetCard validStrokeColors]){
                for (NSString * foregroundColor in [SetCard validForegroundColors]) {
                    for (NSString * symbol in [SetCard validSymbols]) {
                    
                        SetCard * card = [[SetCard alloc] init];
                        for (int i=1; i <= numberOfSymbols.intValue; i++) {
                            if (i==1) card.contents = symbol;
                            else card.contents = [card.contents stringByAppendingString:symbol];
                        }
                        card.symbol = symbol;
                        card.number = numberOfSymbols;
                        card.strokeColor = strokeColor;
                        card.foregroundColor = foregroundColor;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    
    }
    return self;
}

@end
