//
//  Card.m
//  Matchismo
//
//  Created by Patrick Dawson on 10.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSUInteger)matchCount
{
    if (_matchCount == 0) _matchCount = 2;
    return _matchCount;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
