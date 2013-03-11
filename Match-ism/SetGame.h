//
//  SetGame.h
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCardDeck.h"
#import "CardGame.h"

@interface SetGame : CardGame

- (void) flipCardAtIndex:(NSUInteger)index;
@property (nonatomic, readwrite) int result;
@property (readwrite, nonatomic) int resultCode;
@end
