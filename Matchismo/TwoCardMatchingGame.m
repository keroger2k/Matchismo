//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kyle Rogers on 8/29/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "TwoCardMatchingGame.h"

@interface TwoCardMatchingGame()

@end


@implementation TwoCardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super initWithCardCount:cardCount usingDeck:deck];
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp){
            int messageCount = [self.messenger count];
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        [self.messenger addObject:[NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                                                   otherCard.contents, card.contents, matchScore * MATCH_BONUS]];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        [self.messenger addObject:[NSString stringWithFormat:@"Mis-Matched %@ & %@ for -%d points",
                                                   otherCard.contents, card.contents, MISMATCH_PENALTY]];
                    }
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
