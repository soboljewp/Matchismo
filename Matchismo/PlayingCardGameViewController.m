//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Patrick Dawson on 29.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
