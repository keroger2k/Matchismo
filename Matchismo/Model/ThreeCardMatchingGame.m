//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Kyle Rogers on 8/30/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface ThreeCardMatchingGame()

@end


@implementation ThreeCardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super initWithCardCount:cardCount usingDeck:deck];
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 8
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsInPlay = [[NSMutableArray alloc] init];
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [cardsInPlay addObject:otherCard];
                }
            }
            int messageCount = [self.messenger count];
            if([cardsInPlay count] == 2) {
                int matchScore = [card match:cardsInPlay];
                Card *cardOne = cardsInPlay[0];
                Card *cardTwo = cardsInPlay[1];
                if(matchScore){
                    cardOne.unplayable = YES;
                    cardTwo.unplayable = YES;
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    [self.messenger addObject:[NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points",
                                               cardOne.contents, cardTwo.contents, card.contents, matchScore * MATCH_BONUS]];
                } else {
                    cardOne.faceUp = NO;
                    cardTwo.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    [self.messenger addObject:[NSString stringWithFormat:@"Mis-Matched %@ & %@ & %@ for -%d points",
                                               cardOne.contents, cardTwo.contents, card.contents, MISMATCH_PENALTY]];
                }
            }
            
            if(messageCount == [self.messenger count]) {
                [self.messenger addObject:[NSString stringWithFormat:@"Flipped %@", card.contents]];
            }
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
