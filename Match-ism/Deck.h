//
//  Deck.h
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard: (Card *)card atTop:(BOOL)atTop;

-(Card*) drawRandomCard;


@end
