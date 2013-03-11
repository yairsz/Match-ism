//
//  CardMatchingGame.h
//  Match-ism
//
//  Created by Yair Szarf on 2/4/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardGame.h"    

@interface CardMatchingGame : CardGame

- (void) flipCardAtIndex: (NSUInteger) index;


@end
