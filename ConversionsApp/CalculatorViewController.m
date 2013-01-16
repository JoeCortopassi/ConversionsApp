//
//  CalculatorViewController.m
//  ConversionsApp
//
//  Created by Joe Cortopassi on 1/15/13.
//  Copyright (c) 2013 Joe Cortopassi. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize bounds, category;
@synthesize leftInputLabel, leftInputOverlay, rightInputLabel, rightInputOverlay;
@synthesize leftPickerView, rightPickerView;
@synthesize oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, periodButton, clearButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.sevenButton = [[UIButton alloc] init];
        self.eightButton = [[UIButton alloc] init];
        self.nineButton = [[UIButton alloc] init];
        self.fourButton = [[UIButton alloc] init];
        self.fiveButton = [[UIButton alloc] init];
        self.sixButton = [[UIButton alloc] init];
        self.oneButton = [[UIButton alloc] init];
        self.twoButton = [[UIButton alloc] init];
        self.threeButton = [[UIButton alloc] init];
        self.zeroButton = [[UIButton alloc] init];
        self.periodButton = [[UIButton alloc] init];
        self.clearButton = [[UIButton alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bounds = [[UIScreen mainScreen] bounds];
    
    [self setUpInputBoxes];
    [self setupMeasurementTypePickers];
    [self setupButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setUpInputBoxes
{
    CGSize labelDimensions      = CGSizeMake(self.bounds.size.width/2 - 6, 40);
    CGRect leftInputFrame       = CGRectMake(3, 0, labelDimensions.width, labelDimensions.height);
    CGRect rightInputFrame      = CGRectMake((self.bounds.size.width/2)+3, 0, labelDimensions.width, labelDimensions.height);
    UIColor *backgroundColor    = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    UIColor *textColor          = [UIColor whiteColor];
    UIFont *font                = [UIFont fontWithName:@"Verdana-Bold" size:20];
    
    
    // Left side
    self.leftInputLabel = [[UILabel alloc] init];
    self.leftInputLabel.frame = leftInputFrame;
    self.leftInputLabel.backgroundColor = backgroundColor;
    self.leftInputLabel.textColor = textColor;
    self.leftInputLabel.font = font;
    self.leftInputLabel.textAlignment = NSTextAlignmentCenter;
    
    self.leftInputOverlay = [[UIButton alloc] init];
    self.leftInputOverlay.frame = leftInputFrame;
    self.leftInputOverlay.backgroundColor = [UIColor clearColor];
    [self.leftInputOverlay addTarget:self action:@selector(inputTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Right side
    self.rightInputLabel = [[UILabel alloc] init];
    self.rightInputLabel.frame = rightInputFrame;
    self.rightInputLabel.backgroundColor = backgroundColor;
    self.rightInputLabel.textColor = textColor;
    self.rightInputLabel.font = font;
    self.rightInputLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightInputOverlay = [[UIButton alloc] init];
    self.rightInputOverlay.frame = rightInputFrame;
    self.rightInputOverlay.backgroundColor = [UIColor clearColor];
    [self.rightInputOverlay addTarget:self action:@selector(inputTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Add to view
    [self.view addSubview:self.leftInputLabel];
    [self.view addSubview:self.leftInputOverlay];
    [self.view addSubview:self.rightInputLabel];
    [self.view addSubview:self.rightInputOverlay];
}


- (void) setupMeasurementTypePickers
{
    CGRect pickerFrame = CGRectMake(0, self.leftInputLabel.frame.size.height + 4, self.bounds.size.width/2, 215.0);
    
    self.leftPickerView = [[UIPickerView alloc] init];
    self.leftPickerView.frame = CGRectMake(0, pickerFrame.origin.y, pickerFrame.size.width, pickerFrame.size.height);
    
    self.rightPickerView = [[UIPickerView alloc] init];
    self.rightPickerView.frame = CGRectMake(pickerFrame.size.width, pickerFrame.origin.y, pickerFrame.size.width, pickerFrame.size.height);
    
    
    [self.view addSubview:self.leftPickerView];
    [self.view addSubview:self.rightPickerView];
    
    [self setupPickerOverlay];
}


- (void) setupButtons
{
    CGPoint buttonOrigin = CGPointMake(0, 230.0);
    CGSize buttonSize = CGSizeMake(bounds.size.width/3, 40.0);
    UIColor *backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    CGFloat buttonPadding = 3;
    NSArray *buttons    = @[self.sevenButton,self.eightButton,self.nineButton,
                            self.fourButton,self.fiveButton,self.sixButton,
                            self.oneButton,self.twoButton,self.threeButton,
                            self.zeroButton,self.periodButton,self.clearButton];
    
//    NSDictionary *buttonText = @{
    
    int col = 0;
    int row = 0;
    
    for (int i=0; i<[buttons count]; i++)
    {
        CGFloat x = ((buttonSize.width + buttonPadding) * col) + buttonOrigin.x;
        CGFloat y = ((buttonSize.height + buttonPadding) * row) + buttonOrigin.y;
        
        UIButton *button = [buttons objectAtIndex:i];
        button.frame = CGRectMake(x, y, buttonSize.width, buttonSize.height);
        button.backgroundColor = backgroundColor;
        
        row = (col == 2)? ++row: row;
        col = (col == 2)? 0: ++col;
        
        [self.view addSubview:button];
    }
}


- (void) setupPickerOverlay
{
    UIColor *color  = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    CGFloat pickerTop = 44.0;
    CGFloat pickerBottom = 225.0;
    CGSize horizontalBar = CGSizeMake(self.bounds.size.width, 13.0);
    CGSize verticalBar = CGSizeMake(11.0, pickerBottom-pickerTop);
    
    UILabel *top    = [[UILabel alloc] init];
    top.frame = CGRectMake(0, pickerTop, horizontalBar.width, horizontalBar.height);
    top.backgroundColor = color;
    
    UILabel *bottom = [[UILabel alloc] init];
    bottom.frame = CGRectMake(0, pickerBottom-horizontalBar.height, horizontalBar.width, horizontalBar.height);
    bottom.backgroundColor = color;
    
    UILabel *left   = [[UILabel alloc] init];
    left.frame = CGRectMake(0, pickerTop, verticalBar.width, verticalBar.height);
    left.backgroundColor = color;
    
    UILabel *middle = [[UILabel alloc] init];
    middle.frame = CGRectMake((bounds.size.width/2) - verticalBar.width, pickerTop, verticalBar.width*2, verticalBar.height);
    middle.backgroundColor = color;
    
    UILabel *right  = [[UILabel alloc] init];
    right.frame = CGRectMake(bounds.size.width-verticalBar.width, pickerTop, verticalBar.width, verticalBar.height);
    right.backgroundColor = color;
    
    
    
    [self.view addSubview:top];
    [self.view addSubview:bottom];
    [self.view addSubview:left];
    [self.view addSubview:middle];
    [self.view addSubview:right];
    
}


/*********************
    Touch Events
 *********************/
- (void) inputTouched:(id)sender
{
    NSLog(@"%@", sender);
}
@end
