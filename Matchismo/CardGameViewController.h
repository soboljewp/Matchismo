//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Patrick Soboljew on 09.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
-(Deck *)createDeck; // abstract

@end
