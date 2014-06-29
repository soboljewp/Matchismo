//
//  PlayingCard.m
//  Matchismo
//
//  Created by Patrick Dawson on 10.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int matchRankCount = 0;
    int matchSuitCount = 0;
    
    NSMutableArray *cardsToMatch = [[NSMutableArray alloc] initWithArray:otherCards];
    [cardsToMatch addObject:self];
    
    for (int i=0; i<[cardsToMatch count]; ++i) {
        for (int j=i+1; j<[cardsToMatch count]; ++j) {
            PlayingCard *card = cardsToMatch[i];
            PlayingCard *otherCard = cardsToMatch[j];
            if (card.rank == otherCard.rank) {
                matchRankCount += 1;
            }
            else if ([card.suit isEqualToString:otherCard.suit]) {
                matchSuitCount += 1;
            }
        }
    }
    
    score = matchRankCount * 4 + matchSuitCount * 1;
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+(NSArray *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
             @"J", @"Q", @"K"];
}

@end
