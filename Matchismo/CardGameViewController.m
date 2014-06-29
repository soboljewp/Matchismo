//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Patrick Soboljew on 09.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@property (weak, nonatomic) IBOutlet UILabel *lastActionLabel;
@property (nonatomic) BOOL gameRunning;
@property (nonatomic) NSUInteger matchCount;
@end

static const int MISMATCH_PENALTY = 2;

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [self createGame];
    return _game;
}

- (NSUInteger)matchCount
{
    if (_matchCount == 0) _matchCount = 2;
    return _matchCount;
}

- (void)setGameRunning:(BOOL)gameRunning
{
    _gameRunning = gameRunning;
    self.modeControl.enabled = !self.gameRunning;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
                                       mismatchPenalty:MISMATCH_PENALTY];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.gameRunning = YES;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)tochDealButton:(UIButton *)sender {
    self.game = [self createGame];
    self.game.cardsToMatchCount = self.matchCount;
    self.gameRunning = NO;
    [self updateUI];
}

- (IBAction)touchGameModeControl:(UISegmentedControl *)sender {
    NSLog(@"Selected game mode segment: %d", sender.selectedSegmentIndex);
    
    self.matchCount = sender.selectedSegmentIndex + 2;
    self.game.cardsToMatchCount = self.matchCount;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    
    
    
    NSLog(@"Chosen card count: %d", [self.game.chosenCards count]);
    NSMutableString *chosenCardsString = [[NSMutableString alloc] init];
    for (Card *card in self.game.chosenCards) {
        [chosenCardsString appendString:card.contents];
    }
    self.lastActionLabel.text = chosenCardsString;
    
    if ([self.game.chosenCards count] == self.matchCount) {
        if (self.game.lastActionScore < 0) {
            self.lastActionLabel.text = [NSString stringWithFormat:@"%@ dont match! %d points penalty!", chosenCardsString, MISMATCH_PENALTY];
        }
        else {
            self.lastActionLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points!", chosenCardsString, self.game.lastActionScore];
        }
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
