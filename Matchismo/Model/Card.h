//
//  Card.h
//  Matchismo
//
//  Created by Patrick Dawson on 10.06.14.
//  Copyright (c) 2014 de.mtx.cs193p.patrick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic) NSUInteger matchCount;

- (int)match:(NSArray *)otherCards;

@end
