//
//  ThreeCardMatchingGame.h
//  Matchismo
//
//  Created by Kyle Rogers on 8/30/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "BaseMatchGame.h"

@interface ThreeCardMatchingGame : BaseMatchGame
@property (nonatomic, readonly) int score;
@end
