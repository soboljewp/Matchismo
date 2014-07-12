//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Patrick Soboljew on 09.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "CardGameViewController.h"
#import "GameHistoryViewController.h"


@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) NSMutableAttributedString *actionHistoryString;

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

- (NSMutableAttributedString *)actionHistoryString
{
    if (!_actionHistoryString) _actionHistoryString = [[NSMutableAttributedString alloc] init];
    return _actionHistoryString;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchDealButton:(id)sender {
    self.game = [self createGame];
    self.actionHistoryString = [[NSMutableAttributedString alloc] init];
    [self updateUI];
}

- (void)updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    NSMutableAttributedString *lastActionString = [self chosenCardString];
    NSString *pointsText = nil;
  
    if (self.game.lastActionScore < 0) {
        pointsText = [NSString stringWithFormat:@" dont match! %d points penalty!", MISMATCH_PENALTY];
    }
    else if (self.game.lastActionScore > 0) {
        pointsText = [NSString stringWithFormat:@" match! You get %d points!", self.game.lastActionScore];
    }
    
    if (pointsText) {
        [lastActionString appendAttributedString:[[NSAttributedString alloc] initWithString:pointsText]];
    }
    
    self.lastActionLabel.attributedText = lastActionString;
    
    [self.actionHistoryString appendAttributedString:lastActionString];
    NSAttributedString *newline = [[NSAttributedString alloc] initWithString:@"\n"];
    [self.actionHistoryString appendAttributedString:newline];
}

- (NSMutableAttributedString *)chosenCardString
{
    NSMutableString *cardsString = [[NSMutableString alloc] init];
    for (Card *card in self.game.chosenCards) {
        if (card.contents) {
            [cardsString appendString:card.contents];
        }
    }
    
    return [[NSMutableAttributedString alloc] initWithString:cardsString];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *historyVC = (GameHistoryViewController *)segue.destinationViewController;
            historyVC.historyString = self.actionHistoryString;
        }
    }
}

@end
