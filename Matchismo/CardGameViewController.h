//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Kyle Rogers on 8/28/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck; //abstract
@property (nonatomic) NSUInteger startingCardCount; //abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //abstract

@end
