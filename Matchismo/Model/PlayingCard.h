//
//  PlayingCard.h
//  Matchismo
//
//  Created by Kyle Rogers on 8/28/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
