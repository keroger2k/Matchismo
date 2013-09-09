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
        [cardButton setAttributedTitle:[self updateAttributedString:[[NSAttributedString alloc] initWithString:card.contents]
                                               withAttributesOfCard:(SetCard *)card] forState:UIControlStateNormal];
        
        if(card.isFaceUp){
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        } else {
            cardButton.alpha = 1;
            [cardButton setBackgroundColor:[UIColor whiteColor]];
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


- (NSAttributedString *)updateAttributedString:(NSAttributedString *)attributedString withAttributesOfCard:(SetCard *)card
{
    NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
    NSRange range = [[mutableAttributedString string] rangeOfString:card.contents];
    NSDictionary *colors = @{ @"green" : [UIColor greenColor], @"blue" : [UIColor blueColor], @"red" : [UIColor redColor] };
    NSDictionary *shapes = @{ @"circle" : @"●", @"triangle" :  @"▲", @"square" : @"■" };
    
    NSString *symbol = shapes[card.shape];
    symbol = [symbol stringByPaddingToLength:card.rank withString:symbol startingAtIndex:0];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:colors[card.color] forKey:NSForegroundColorAttributeName];
    
    if ([card.shade isEqualToString:@"solid"])
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    if ([card.shade isEqualToString:@"shaded"])
        [attributes addEntriesFromDictionary:@{
                 NSStrokeWidthAttributeName : @-5,
                 NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
             NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
         }];
    if ([card.shade isEqualToString:@"empty"])
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    
    [mutableAttributedString replaceCharactersInRange:range
                                 withAttributedString:[[NSAttributedString alloc] initWithString:symbol
                                                                                      attributes:attributes]];
    return mutableAttributedString;
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    //self.flipCount++;
    [self updateUI];
}

@end
