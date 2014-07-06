//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Patrick Dawson on 29.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)updateUI
{
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSAttributedString *content = [[NSAttributedString alloc] initWithString:@"?"];
    
    if ([card isKindOfClass:[SetCard class]]) {
        
        
    }

    return content;
}

@end
