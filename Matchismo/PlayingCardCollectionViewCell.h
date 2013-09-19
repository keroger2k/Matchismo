//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Kyle Rogers on 9/18/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
