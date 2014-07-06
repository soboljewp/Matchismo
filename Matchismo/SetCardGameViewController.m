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

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)updateUI
{
    //[super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        
        if ([setCard.symbol isEqualToString:@"Triangle"]) symbol = @"▲";
        if ([setCard.symbol isEqualToString:@"Circle"]) symbol = @"●";
        if ([setCard.symbol isEqualToString:@"Square"]) symbol = @"■";
        
        symbol = [symbol stringByPaddingToLength:setCard.number
                                      withString:symbol startingAtIndex:0];
        
        if ([setCard.color isEqualToString:@"Red"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor redColor];
        }
        if ([setCard.color isEqualToString:@"Green"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor greenColor];
        }
        if ([setCard.color isEqualToString:@"Purple"]) {
            attributes[NSForegroundColorAttributeName] = [UIColor purpleColor];
        }
        
        if ([setCard.shading isEqualToString:@"Solid"]) {
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @-5}];
        }
        if ([setCard.shading isEqualToString:@"Striped"]) {
            [attributes addEntriesFromDictionary:@{
                                                   NSStrokeWidthAttributeName: @-5,
                                                   NSStrokeColorAttributeName: attributes[NSForegroundColorAttributeName],
                                                   NSForegroundColorAttributeName: [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.2]
                                                  }];
        }
        if ([setCard.shading isEqualToString:@"Open"]) {
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @5}];
        }
    }
    
    
    return [[NSAttributedString alloc] initWithString:symbol
                                           attributes:attributes];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"setCardSelected" : @"cardfront"];
}

@end
