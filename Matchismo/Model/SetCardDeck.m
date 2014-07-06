//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Patrick Dawson on 06.07.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (int i=1; i<=[SetCard maxNumber]; ++i) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *color in [SetCard validColors]) {
                    for (NSString *shading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
