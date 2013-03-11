//
//  GameResultViewController.m
//  Match-ism
//
//  Created by Yair Szarf on 2/13/13.
//  Copyright (c) 2013 Yair Szarf. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController


-(void) updateUI
{
     NSString * displayText = @"";
    for (GameResult * result in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score,result.end,round(result.duration)] ;
    }
    self.display.text = displayText;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) setup {
    
}

- (void) awakeFromNib {
    [self setup];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}



@end
