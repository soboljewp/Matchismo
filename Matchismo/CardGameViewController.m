//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Patrick Soboljew on 09.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@end

static const int MISMATCH_PENALTY = 2;

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [self createGame];
    return _game;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
                                       mismatchPenalty:MISMATCH_PENALTY];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)touchDealButton:(id)sender {
    self.game = [self createGame];
    [self updateUI];
}

- (void)updateUI
{

    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    NSLog(@"Chosen card count: %d", [self.game.chosenCards count]);
    NSMutableString *chosenCardsString = [[NSMutableString alloc] init];
    for (Card *card in self.game.chosenCards) {
        [chosenCardsString appendString:card.contents];
    }
    self.lastActionLabel.text = chosenCardsString;
    
    if (self.game.lastActionScore < 0) {
        self.lastActionLabel.text = [NSString stringWithFormat:@"%@ dont match! %d points penalty!", chosenCardsString, MISMATCH_PENALTY];
    }
    else if (self.game.lastActionScore > 0) {
        self.lastActionLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points!", chosenCardsString, self.game.lastActionScore];
    }
}

@end
