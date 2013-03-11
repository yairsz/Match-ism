//
//  SetGameViewController.m
//  Match-ism
//
//  Created by Yair Szarf on 2/26/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "GameResult.h"


@interface SetGameViewController()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) SetGame *game;
@property (strong, nonatomic)UIColor *color1, *color2, *color3;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong,nonatomic) NSMutableArray * flipHistory; //of strings
@property (strong,nonatomic) NSNumber * matchBonus,*mismatchPenalty,*flipCost;
@property (strong,nonatomic) NSMutableArray * last3Cards; //of AttributedString

@end


@implementation SetGameViewController

- (UIColor *) color1{
    
    if (!_color1){
        _color1 = [UIColor redColor];
    }
    return _color1;
}

- (UIColor *) color2{
    
    if (!_color2){
        _color2 = [UIColor blueColor];
    }
    return _color2;
}

- (UIColor *) color3{
    
    if (!_color3){
        _color3 = [UIColor greenColor];
    }
    return _color3;
}

-(NSMutableArray*)flipHistory{
    //LAZY INSTANTIATION!
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}

-(NSMutableArray *) last3Cards{
    if(!_last3Cards) _last3Cards = [[NSMutableArray alloc] init];
    return _last3Cards;
}



- (SetGame *) game
{
    if (!_game) {
        self.matchBonus = @4;
        self.mismatchPenalty = @2;
        self.flipCost = @1;
        _game =[[SetGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
        [_game defineBonusSchemeWithArray:@[self.matchBonus,self.mismatchPenalty,self.flipCost]];
    }
    return _game;
    
}

- (void) updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
//        cardButton.titleLabel.text = [NSString stringWithFormat:@"%d",[self.cardButtons indexOfObject:cardButton]];
        SetCard *card = (SetCard*)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        NSAttributedString * attTitle = [self contentsToAttStringofCard:card];

        [cardButton setAttributedTitle:attTitle forState:UIControlStateNormal];
        [cardButton setAttributedTitle:attTitle forState:UIControlStateSelected];
        [cardButton setAttributedTitle:nil forState:UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        cardButton.backgroundColor = cardButton.selected ? [UIColor grayColor] : nil;
    }
    // deal with score, flips, results and history slider
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.historySlider.maximumValue = [self.flipHistory indexOfObject:[self.flipHistory lastObject]];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",[self.flipHistory count]];
    
    //this "if" is a fix for the slider going back and forth at the beggining of the game
    
    if (self.flipHistory.count == 1) {
        self.historySlider.enabled =YES;
        self.historySlider.maximumValue=1;
        self.historySlider.value = 1;
    }

}


- (NSAttributedString *) contentsToAttStringofCard: (SetCard *) card {
    
    
    UIColor *foregroundColor, *strokeColor;
    NSNumber * strokeWidth = @10.0;
    switch ([card.foregroundColor intValue]) {
        case 1:
            foregroundColor = self.color1;
            break;
        case 2:
            foregroundColor = self.color2;
            break;
        case 3:
            foregroundColor = self.color3;
            break;
        default:
            foregroundColor = [UIColor blackColor];
            break;
    }
    switch ([card.strokeColor intValue]) {
        case 1: // blanco por dentro
            strokeColor = foregroundColor;
            break;
        case 2: //gris por dentro
            strokeColor = foregroundColor;
            foregroundColor = [foregroundColor colorWithAlphaComponent:0.3];
            strokeWidth = @-10;
            break;
        case 3: //color por dentro
            strokeColor = foregroundColor;
            strokeWidth = @0;
            break;
        default:
            strokeColor = [UIColor blackColor];
            break;
    }
    
    NSAttributedString *attTitle = [[NSAttributedString alloc] initWithString:card.contents attributes:
                                             @{NSForegroundColorAttributeName:foregroundColor,
                                                   NSStrokeColorAttributeName:strokeColor,
                                                   NSStrokeWidthAttributeName:strokeWidth,
                                                          NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:28]}];
    return attTitle;
}


- (NSAttributedString *) resultAttSringWithResultCode:(int)resultCode{
    NSMutableAttributedString * resultAttString;
if (resultCode == 1){ // Format the string for a match
    
        resultAttString = [[NSMutableAttributedString alloc] initWithString:@"Matched: "];
        for (int i = 0; i <= [self.last3Cards count]-1; i++) {
            [resultAttString appendAttributedString:(NSAttributedString*)[self.last3Cards objectAtIndex:i]];
            if (i < [self.last3Cards count]-1) [resultAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
        }
        [resultAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  for %d points!`",self.game.result]]];
        self.last3Cards = nil;
    
    } else if (resultCode == 2){// Format the string for a mismatch
        resultAttString = [[NSMutableAttributedString alloc] initWithString:@"Sorry, "];
        for (int i = 0; i <= [self.last3Cards count]-1; i++) {
            [resultAttString appendAttributedString:(NSAttributedString*)[self.last3Cards objectAtIndex:i]];
            if (i < [self.last3Cards count]-1) [resultAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
        }
        [resultAttString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  are not a Set. (%d point penalty)",[self.mismatchPenalty intValue]]]];
        self.last3Cards = nil;
        
    } else if (resultCode == 3) { // format the string for a normal flip
        resultAttString = [[NSMutableAttributedString alloc] initWithString:@"Flipped " attributes:nil];
        [resultAttString appendAttributedString:[self.last3Cards lastObject]];
    } else resultAttString = nil;
    
    NSMutableParagraphStyle * paragraphStyleCenter = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyleCenter setAlignment:NSTextAlignmentCenter];
    
    [resultAttString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyleCenter} range:NSMakeRange(0,[resultAttString length])];
    return resultAttString;
}




- (IBAction)flipCard:(UIButton *)sender
{
    
    SetCard *card = (SetCard*)[self.game cardAtIndex:[self.cardButtons indexOfObject:sender]];
    if (!card.isFaceUp){//user is selecting a new card
        
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        [self.last3Cards addObject:[self contentsToAttStringofCard:card]]; //add att String to the memory
        self.resultsLabel.attributedText = [self resultAttSringWithResultCode:self.game.resultCode]; //create and assign the resulting text
        [self.flipHistory addObject:self.resultsLabel.attributedText]; //add text to history
        self.historySlider.maximumValue = [self.flipHistory indexOfObject:[self.flipHistory lastObject]]; //change the max value of the slider
        
        //this line is a fix for the slider going back and forth at the beggining of the game
        if (self.flipHistory.count == 1) self.historySlider.maximumValue = 0;
    
        self.historySlider.value = self.historySlider.maximumValue;
        [self changeResultsLabelWithIndex:[self.historySlider maximumValue]];
        
        if (self.game.result == [self.mismatchPenalty intValue]) card.faceUp=NO;
        
    } else { //user is deselecting a card
        card.faceUp = !card.faceUp;
        [self.last3Cards removeLastObject];
    }
    [self updateUI];
}



- (void) changeResultsLabelWithIndex:(int)index
{
    // This method is created so flipCard can also change the results label when a card is flipped
    if (self.flipHistory.count > 0){
        self.resultsLabel.alpha = (index == self.historySlider.maximumValue) ? 1.0 : 0.3;
        self.resultsLabel.attributedText = [self.flipHistory objectAtIndex:index];
    }
}

@end
