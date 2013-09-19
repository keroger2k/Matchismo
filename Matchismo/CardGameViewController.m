//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kyle Rogers on 8/28/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "TwoCardMatchingGame.h"
#import "ThreeCardMatchingGame.h"
#import "BaseMatchGame.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) BaseMatchGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@end

@implementation CardGameViewController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView
                   cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:FALSE];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    //abstract
}

- (id)init
{
    self = [super init];
    if(self) {
        self.title = @"Name me!";
    }
    [self updateUI];
    return self;
}

- (BaseMatchGame *)game
{
    if(!_game) {
        if(self.gameSelector.selectedSegmentIndex == 0){
        _game = [[TwoCardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                         usingDeck:[self createDeck]];
        } else {
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                         usingDeck:[self createDeck]];
        }
    }
    return _game;
}

- (Deck *)createDeck { return nil; } //abstract


- (void)updateUI
{

    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:TRUE];
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

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        [self updateUI];
    }
}

@end
