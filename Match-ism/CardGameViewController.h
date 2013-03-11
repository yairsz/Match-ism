//
//  ViewController.h
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"


@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end
