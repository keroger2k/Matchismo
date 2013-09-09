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
#import "SetCard.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) BaseMatchGame *game;
@end

@implementation SetGameViewController

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
    if(!_game) _game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}



- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if ([card isKindOfClass:[SetCard class]]){
            [cardButton setAttributedTitle:[(SetCard *)card cardFace] forState:UIControlStateNormal];
        } else {
            [cardButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:card.contents] forState:UIControlStateNormal];
        }
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
    //self.messageLabel.text = [self.game.messenger lastObject];
    
    
}

- (void)viewDidLoad{
    [self updateUI];
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    //self.flipCount++;
    [self updateUI];
}

@end
