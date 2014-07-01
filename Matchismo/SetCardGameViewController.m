//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Patrick Dawson on 29.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "SetCardGameViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    // Create new set game here.
    return nil;
}

- (void)updateUI
{
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:@""
                    forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
}
@end
