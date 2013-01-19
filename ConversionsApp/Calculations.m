//
//  Calculations.m
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/16/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "Calculations.h"

@interface Calculations ()
@property (nonatomic, readonly) NSString *standardUnitOfMeasure;

@property (nonatomic, readonly) NSDictionary *lengthTypes;
@property (nonatomic, readonly) NSArray *lengthOrder;
@property (nonatomic, readonly) NSDictionary *weightTypes;
@property (nonatomic, readonly) NSArray *weightOrder;
@property (nonatomic, readonly) NSDictionary *volumeTypes;
@property (nonatomic, readonly) NSArray *volumeOrder;
@property (nonatomic, readonly) NSDictionary *timeTypes;
@property (nonatomic, readonly) NSArray *timeOrder;
@end


@implementation Calculations

@synthesize category, standardUnitOfMeasure;
@synthesize lengthOrder, lengthTypes, weightOrder, weightTypes, volumeOrder, volumeTypes, timeOrder, timeTypes;


- (id) init
{
    if (self = [super init])
    {
        
    }
    
    return  self;
}


- (NSString *) standardUnitOfMeasure
{
    NSString *standard;
    
    if ([self.category caseInsensitiveCompare:@"length"])
    {
        standard = @"Meters";
    }
    
    return standard;
}



/*************************************
        Calculation Methods
 *************************************/
- (NSArray *) measurementTypes
{
    NSArray *measurementTypes;
    
    if ([self.category caseInsensitiveCompare:@"length"] == NSOrderedSame)
    {
        measurementTypes = self.lengthOrder;
    }
    else if ([self.category caseInsensitiveCompare:@"weight"] == NSOrderedSame)
    {
        measurementTypes = self.weightOrder;
    }
    else if ([self.category caseInsensitiveCompare:@"volume"] == NSOrderedSame)
    {
        measurementTypes = self.volumeOrder;
    }
    else if ([self.category caseInsensitiveCompare:@"time"] == NSOrderedSame)
    {
        measurementTypes = self.timeOrder;
    }
    else
    {
        measurementTypes = nil;
    }
    
    return measurementTypes;
}


- (CGFloat) getStandardConversionUnitsForMeasurementType:(NSString *)type
{
    
    NSDictionary *measurementTypes;
    
    if ([self.category caseInsensitiveCompare:@"length"] == NSOrderedSame)
    {
        measurementTypes = self.lengthTypes;
    }
    else if ([self.category caseInsensitiveCompare:@"weight"] == NSOrderedSame)
    {
        measurementTypes = self.weightTypes;
    }
    else if ([self.category caseInsensitiveCompare:@"volume"] == NSOrderedSame)
    {
        measurementTypes = self.volumeTypes;
    }
    else if ([self.category caseInsensitiveCompare:@"time"] == NSOrderedSame)
    {
        measurementTypes = self.timeTypes;
    }
    else
    {
        measurementTypes = nil;
    }
    
    return [(NSNumber *)[measurementTypes objectForKey:type] floatValue];

}


- (CGFloat) convert:(CGFloat)input fromMeasurementType:(NSString *)inputType toMeasurementType:(NSString *)outputType
{
    double inputStandardUnits = [self getStandardConversionUnitsForMeasurementType:inputType];
    double outputStandardUnits = [self getStandardConversionUnitsForMeasurementType:outputType];
    
    
    CGFloat convertedInput = (input * inputStandardUnits);
    CGFloat convertedOutput = (convertedInput / outputStandardUnits);
    
    
//    CGFloat ratioStandards = (inputStandardUnits/outputStandardUnits);
//    CGFloat ratioConverted = (convertedInput/convertedOutput);

    
    convertedOutput = roundf(convertedOutput * 100000)/100000;
    
    return convertedOutput;
    
}





/*************************************
 Getters for Category Arrays
 *************************************/
- (NSDictionary *)lengthTypes
{
    return    @{@"Inches"       : [NSNumber numberWithDouble:0.0254],
                @"Feet"         : [NSNumber numberWithDouble:0.3048],
                @"Yards"        : [NSNumber numberWithDouble:0.9144],
                @"Miles"        : [NSNumber numberWithDouble:1609.344],
                @"Centimeters"  : [NSNumber numberWithDouble:0.01],
                @"Meters"       : [NSNumber numberWithDouble:1.0],   // standard
                @"Kilometers"   : [NSNumber numberWithDouble:1000.0]};
}


- (NSArray *)lengthOrder
{
    return    @[@"Centimeters",
                @"Inches",
                @"Feet",
                @"Yards",
                @"Meters",
                @"Kilometers",
                @"Miles"];
}


- (NSDictionary *) weightTypes
{
    return    @{@"Milligrams"   : [NSNumber numberWithDouble:0.000001],
                @"Grams"        : [NSNumber numberWithDouble:0.001],
                @"Ounces"       : [NSNumber numberWithDouble:0.028349523125],
                @"Pounds"       : [NSNumber numberWithDouble:0.45359237],
                @"Kilograms"    : [NSNumber numberWithDouble:1.0], // standard
                @"Tons"         : [NSNumber numberWithDouble:907.18474],
                @"Metric Tons"  : [NSNumber numberWithDouble:1000.0]};
}


- (NSArray *) weightOrder
{
    return    @[@"Milligrams",
                @"Grams", // standard
                @"Ounces",
                @"Pounds",
                @"Kilograms",
                @"Tons",
                @"Metric Tons"];
}


- (NSDictionary *) volumeTypes
{
    return    @{@"Teaspoons"    : [NSNumber numberWithDouble:0.00000492892],
                @"Tablespoons"  : [NSNumber numberWithDouble:0.00001478676],
                @"Cups"         : [NSNumber numberWithDouble:0.00023658823],
                @"Pints"        : [NSNumber numberWithDouble:0.00047317647],
                @"Quarts"       : [NSNumber numberWithDouble:0.00094635294],
                @"Liters"       : [NSNumber numberWithDouble:0.001],  // standard
                @"Gallons (US)" : [NSNumber numberWithDouble:0.00378541178]};
}


- (NSArray *) volumeOrder
{
    return    @[@"Teaspoons",
                @"Tablespoons",
                @"Cups",
                @"Liters",
                @"Quarts",
                @"Pints",
                @"Gallons (US)"];
}


- (NSDictionary *) timeTypes
{
    return    @{@"Seconds"  : [NSNumber numberWithDouble:(1/3600.0)],
                @"Minutes"  : [NSNumber numberWithDouble:(1/60.0)],
                @"Hours"    : [NSNumber numberWithDouble:1.0],   // standard
                @"Days"     : [NSNumber numberWithDouble:24.0],
                @"Weeks"    : [NSNumber numberWithDouble:(24.0*7)],
                @"Months"   : [NSNumber numberWithDouble:(24.0*30.5)],
                @"Years"    : [NSNumber numberWithDouble:(24.0*365.25)]};
}


- (NSArray *) timeOrder
{
    return    @[@"Seconds",
                @"Minutes",
                @"Hours",
                @"Days",
                @"Weeks",
                @"Months",
                @"Years"];
}

@end
