//
//  SetCard.m
//  Matchismo
//
//  Created by Kyle Rogers on 9/8/13.
//  Copyright (c) 2013 Kyle Rogers. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;  //because we provide setter and getter
@synthesize color = _color;  //because we provide setter and getter
@synthesize shade = _shade;  //because we provide setter and getter


- (NSString *)contents {
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.shape, self.color, self.shade, self.rank];
}

- (NSAttributedString *)cardFace {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self.contents];
    NSRange range = [[mutableAttributedString string] rangeOfString:self.contents];
    
        NSString *symbol = @"?";
        if ([self.shape isEqualToString:@"circle"]) symbol = @"●";
        if ([self.shape isEqualToString:@"triangle"]) symbol = @"▲";
        if ([self.shape isEqualToString:@"square"]) symbol = @"■";
        
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        
        if ([self.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        if ([self.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        if ([self.color isEqualToString:@"blue"])
            [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        
        if ([self.shade isEqualToString:@"solid"])
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        if ([self.shade isEqualToString:@"shaded"])
            [attributes addEntriesFromDictionary:@{
                     NSStrokeWidthAttributeName : @-5,
                     NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                 NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
             }];
        if ([self.shade isEqualToString:@"empty"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        
        symbol = [symbol stringByPaddingToLength:self.rank withString:symbol startingAtIndex:0];
        
        [mutableAttributedString replaceCharactersInRange:range
                                     withAttributedString:[[NSAttributedString alloc] initWithString:symbol
                                                                                          attributes:attributes]];
    return mutableAttributedString;
    //return [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ :TEST", self.contents]];
}


+ (NSArray *)validShapes
{
    return @[@"circle",@"square", @"triangle"];
}

- (void)setShape:(NSString *)shape
{
    if([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
    
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

- (void)setColor:(NSString *)color
{
    if([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
    
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

+ (NSArray *)validShades
{
    return @[@"solid", @"shaded", @"empty"];
}

- (void)setShade:(NSString *)shade
{
    if([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
    
}

- (NSString *)shade
{
    return _shade ? _shade : @"?";
}


+ (NSUInteger)maxRank { return 3; }

- (void)setRank:(NSUInteger)rank
{
    if(rank <= 3){
        _rank = rank;
    }
}

@end
