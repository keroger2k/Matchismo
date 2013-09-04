//
//  BaseMatchGame.m
//  Matchismo
//
//  Created by Kyle Rogers on 8/30/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "BaseMatchGame.h"

@implementation BaseMatchGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)messenger
{
    if(!_messenger) _messenger = [[NSMutableArray alloc] init];
    return _messenger;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self) {
        
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    
}

@end
