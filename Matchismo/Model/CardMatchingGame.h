//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Patrick Dawson on 12.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                  mismatchPenalty:(NSInteger)penalty;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger lastActionScore;
@property (nonatomic) NSUInteger cardsToMatchCount;
@property (nonatomic, strong) NSMutableArray * chosenCards;

@end
