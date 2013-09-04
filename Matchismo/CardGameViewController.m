//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kyle Rogers on 8/28/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "TwoCardMatchingGame.h"
#import "ThreeCardMatchingGame.h"
#import "BaseMatchGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) BaseMatchGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;

@end

@implementation CardGameViewController

- (id)init
{
    self = [super init];
    if(self) {
    
    }
    [self updateUI];
    return self;
}

- (BaseMatchGame *)game
{
    if(!_game) {
        if(self.gameSelector.selectedSegmentIndex == 0){
        _game = [[TwoCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
        } else {
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
        }
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
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
        if(card.isFaceUp){
            [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateNormal];
        } else {
            [cardButton setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
    self.messageLabel.text = [self.game.messenger lastObject];
    
    
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)changeGame:(UISegmentedControl *)sender {
    _game = nil;
    [self setFlipCount:0];
    [self updateUI];    
}

- (IBAction)dealCards:(UIButton *)sender {
    _game = nil;
    [self setFlipCount:0];
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
