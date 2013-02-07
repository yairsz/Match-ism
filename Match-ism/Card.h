//
//  Card.h
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString * contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int) match: (NSArray *) otherCards;


@end
