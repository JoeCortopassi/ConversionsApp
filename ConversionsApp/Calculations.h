//
//  Calculations.h
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/16/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject 

/*************************************
        Calculation Methods
 *************************************/
- (NSArray *) measurementTypesForCategory:(NSString *)category;
- (CGFloat) convert:(CGFloat)input fromMeasurementType:(NSString *)inputType toMeasurementType:(NSString *)outputType;


@end
