//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "SetGameViewController.h"
#import "BaseMatchGame.h"
#import "SetCardDeck.h"
#import "SetCardMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) BaseMatchGame *game;
@end

@implementation SetGameViewController

- (BaseMatchGame *)game
{
    if(!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}



- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
    //self.messageLabel.text = [self.game.messenger lastObject];
    
    
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    //self.flipCount++;
    [self updateUI];
}

@end
