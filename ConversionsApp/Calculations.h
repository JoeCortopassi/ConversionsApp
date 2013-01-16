//
//  Calculations.h
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/16/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject <UIPickerViewDataSource>

@property (nonatomic, strong) NSString *fromInput;
@property (nonatomic, strong) NSString *toInput;
@property (nonatomic, readonly) NSArray *lengthDataSource;

@end
