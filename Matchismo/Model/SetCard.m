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
    return @[@"red", @"gren", @"blue"];
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
