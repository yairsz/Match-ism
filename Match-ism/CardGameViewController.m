//
//  ViewController.m
//  Match-ism
//
//  Created by Yair Szarf on 2/1/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *playModeSegmentedControl;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;
@property (strong,nonatomic) NSMutableArray * flipHistory; //of strings

@end

@implementation CardGameViewController


# pragma mark Setters and Getters
- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}

- (void)setFlipCount:(int)flipCount
{
    //LAZY INSTANTIATION!
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Cards Flipped: %d",self.flipCount];
}

-(NSMutableArray*)flipHistory{
    //LAZY INSTANTIATION!
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}



- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //set up card
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        
        UIImage * cardBackImage = [UIImage imageNamed:@"card-back@2x.png"];
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        if (!cardButton.isEnabled)[cardButton setImage:nil forState:UIControlStateNormal];
        
    }
    
    // deal with score, results and history slider
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.resultsLabel.text = self.game.resultSring;
    if (self.resultsLabel.text) [self.flipHistory addObject:self.resultsLabel.text];
    self.historySlider.maximumValue = [self.flipHistory indexOfObject:[self.flipHistory lastObject]];
    [self.historySlider setValue:self.historySlider.maximumValue animated:NO];

    //this "if" is a fix for the slider going back and forth at the beggining of the game    
    if (self.flipHistory.count == 1) {
        self.historySlider.enabled =YES;
        self.historySlider.maximumValue=1;
        self.historySlider.value = 1;
    }
    if (self.playModeSegmentedControl.enabled) self.playModeSegmentedControl.enabled = NO;
    
}

# pragma mark IBActions
- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    //this line is a fix for the slider going back and forth at the beggining of the game
    if (self.flipHistory.count == 1) self.historySlider.maximumValue = 0;
    
    [self changeResultsLabelWithIndex:[self.historySlider maximumValue]];
    [self updateUI];
}


- (IBAction)deal
{
    // Remember previous play mode
    int playMode = self.game.playMode;
    
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                              usingDeck:[[PlayingCardDeck alloc]init]];
    //reset play mode
    self.game.playMode = playMode;
    
    //reset all game UI stuff
    self.flipHistory = nil;
    self.historySlider.maximumValue=0;
    self.historySlider.enabled = NO;
    self.flipCount = 0;
    [self updateUI];    
    self.playModeSegmentedControl.enabled = YES;
}


- (IBAction)playModeChange:(UISegmentedControl *)sender {
    
    self.game.playMode = sender.selectedSegmentIndex;
}


- (IBAction)historySliderValueChange:(UISlider *)sender {
    int index = sender.value;

    [self changeResultsLabelWithIndex:index];
}

- (void) changeResultsLabelWithIndex:(int)index
{
    // This method is created so flipCard can also change 
    if (self.flipHistory.count > 0){
    self.resultsLabel.alpha = (index == self.historySlider.maximumValue) ? 1.0 : 0.3;
    self.resultsLabel.text = [self.flipHistory objectAtIndex:index];
    }
}


@end
