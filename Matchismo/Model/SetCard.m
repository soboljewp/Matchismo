//
//  SetCard.m
//  Matchismo
//
//  Created by Patrick Dawson on 01.07.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.matchCount = 3;
    }
    return self;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    NSMutableArray *symbols = [[NSMutableArray alloc] init];
    NSMutableArray *shadings = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    // Apply rules of set card game:
    //    A set consists of three cards which satisfy all of these conditions:
    //    They all have the same number, or they have three different numbers.
    //    They all have the same symbol, or they have three different symbols.
    //    They all have the same shading, or they have three different shadings.
    //    They all have the same color, or they have three different colors.
    [numbers addObject:@(self.number)];
    [symbols addObject:self.symbol];
    [shadings addObject:self.shading];
    [colors addObject:self.color];
    
    for (id card in otherCards) {
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *otherCard = card;
            if (![numbers containsObject:@(otherCard.number)]) [numbers addObject:@(otherCard.number)];
            if (![symbols containsObject:otherCard.symbol]) [symbols addObject:otherCard.symbol];
            if (![shadings containsObject:otherCard.shading]) [shadings addObject:otherCard.shading];
            if (![colors containsObject:otherCard.color]) [colors addObject:otherCard.color];
        }
    }
    
    if (([numbers count] == 1 || [numbers count] == self.matchCount) &&
        ([symbols count] == 1 || [symbols count] == self.matchCount) &&
        ([shadings count] == 1 || [shadings count] == self.matchCount) &&
        ([colors count] == 1 || [colors count] == self.matchCount))
    {
        score = 4;
    }
    
    return score;
}

+(int) maxNumber
{
    return 3;
}

+(NSArray *)validSymbols
{
    return @[@"Triangle", @"Circle", @"Square"];
}

+(NSArray *)validColors
{
    return @[@"Red", @"Green", @"Purple"];
}

+(NSArray *)validShadings
{
    return @[@"Solid", @"Striped", @"Open"];
}



@end
