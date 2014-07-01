//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Patrick Dawson on 12.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastActionScore;
@property (nonatomic, strong) NSMutableArray* cards; // of card
@property (nonatomic) NSInteger mismatchPenalty;
@end

@implementation CardMatchingGame

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray*)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                  mismatchPenalty:(NSInteger)penalty
{
    self = [super init];
    
    if (self) {
        self.cardsToMatchCount = 2;
        for (int i = 0; i < count; i++) {
            Card* card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    self.mismatchPenalty = penalty;
    
    return self;
}

- (void)setLastActionScore:(NSInteger)lastActionScore
{
    _lastActionScore = lastActionScore;
    self.score += _lastActionScore;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (void)setCardsToMatchCount:(NSUInteger)cardsToMatchCount
{
    if (cardsToMatchCount > 1) {
        _cardsToMatchCount = cardsToMatchCount;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            NSLog(@"Unchoosing card: %@", card.contents);
            card.chosen = NO;
            [self updateChosenCards];
        } else {
            NSLog(@"Choosing card: %@", card.contents);
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [self updateChosenCards];
            
            if ([self.chosenCards count] == self.cardsToMatchCount) {
                NSLog(@"Starting match");
                
                NSMutableArray *otherChosenCards = [[NSMutableArray alloc]
                                                    initWithArray:self.chosenCards];
                [otherChosenCards removeObject:card]; // remove the current card
                
                // ready to match
                int matchScore = [card match:otherChosenCards];
                
                if (matchScore) {
                    // match
                    self.lastActionScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.matched = YES;
                    }
                    NSLog(@"Found match for %ld points", (long)self.lastActionScore);
                } else {
                    // no match
                    self.lastActionScore = -self.mismatchPenalty;
                    for (Card *otherCard in otherChosenCards) {
                        otherCard.chosen = NO;
                    }
                    NSLog(@"No match. %ld penalty!", (long)self.mismatchPenalty);
                }
            }
            else {
                // selection in progress, reset lastActionScore
                self.lastActionScore = 0;
            }
        }
    }
}

- (void)updateChosenCards
{
    [self.chosenCards removeAllObjects];
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [self.chosenCards addObject:card];
        }
    }
}

@end
