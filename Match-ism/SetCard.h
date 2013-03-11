//
//  SetCard.h
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber * number;
@property (strong, nonatomic) NSString * strokeColor;
@property (strong, nonatomic) NSString * foregroundColor;
@property (strong, nonatomic) NSString * symbol;

+ (NSArray *) validNumbers;
+ (NSArray *) validStrokeColors;
+ (NSArray *) validForegroundColors;
+ (NSArray *) validSymbols;

@end
