//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/18/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"


@implementation PlayingCardViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return 20;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            
            if(animate && playingCard.isFaceUp && !playingCard.isUnplayable) {
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.isFaceUp;
                                }
                                completion:NULL];
            } else {
                playingCardView.faceUp = playingCard.isFaceUp;
            }
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

@end
