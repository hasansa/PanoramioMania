//
//  ViewController.m
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/8/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import "ViewController.h"
#import "panoramioObject.h"
#import "AsyncImageView.h"
#import "PanoramioDataModelController.h"

#define answersCount 4
#define kLevel1 10
#define kLevel2 20
#define kLevel3 30
#define kLevel4 40

#define kStartLevel 1
#define klives 3
#define kscore 10

// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 1.0 * M_PI)

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *photoIdLabel;
@property (strong, nonatomic) IBOutlet UIButton *answerOne;
@property (strong, nonatomic) IBOutlet UIButton *answerTwo;
@property (strong, nonatomic) IBOutlet UIButton *answerThree;
@property (strong, nonatomic) IBOutlet UIButton *answerFour;
@property(strong ,nonatomic) NSArray* buttonArray;
//
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;

@property (strong, nonatomic) IBOutlet UILabel *livesLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
//


@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong , nonatomic) GameController* gameController;

@property(strong , nonatomic) PanoramioController* panoramioController;
@property(strong ,nonatomic) PanoramioDataModelController* panoramioData;
@property(strong , nonatomic)  NSString* theCorrectAnswer;
@property (strong , nonatomic) NSMutableArray* photosArray;
@property (assign ,nonatomic) NSInteger index;// next photo

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _buttonArray = [NSArray arrayWithObjects:_answerOne,_answerTwo,_answerThree,_answerFour, nil];
    
    _theCorrectAnswer = @"";
    
    _photosArray = [NSMutableArray array];
    
    _gameController = [[GameController alloc]init];
    [_gameController setDelegate:self];
    [_gameController setMyLevel:kStartLevel];
    [_gameController setMyLives:klives];
    [_gameController setMyScore:kscore];
    [_gameController initLevels];
    
    //
    _imageView.frame = CGRectMake(10, 10, 20, 100);
    [self.view addSubview:_imageView];
    
    

    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // ActivityIndicator Start the Animation
    
    _imageView.image = nil;
    
}

#pragma mark - game managment

-(void) showPhotos{
    
    
    if (_photosArray.count < [_gameController levelQuizCnt]) {
        
        [_imageView setImageURL:[NSURL URLWithString:[[_photosArray lastObject] imageUrl]]];
        [self rotateImage:_imageView duration:3.0
                    curve:UIViewAnimationCurveEaseIn degrees:0];
        
    }
    else
    {
        _gameController.myLevel++;
        
        if (![self didGameEnds]) {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Level Ends....."
                                                                message:@"Next Level" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:1.5];
            
            [alertView show];
            [_photosArray removeAllObjects];

            
            
            
            
        }
    }
    [self updateSeen];
    [self randomAnswersWithRightAnswer];
    
    
    
}
- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS( degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

-(void)updateSeen{
    
    //
    _levelLabel.text = [NSString stringWithFormat:@"%ld",(long)_gameController.myLevel];
    _livesLabel.text = [NSString stringWithFormat:@"%ld",(long)_gameController.myLives];
    _scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)_gameController.myScore];
    //
    
    
}

-(void)randomAnswersWithRightAnswer
{
    //
    
    NSMutableArray* locArray= _gameController.panoramioData.allLocations;
    
    //    [locArray shuffle];
    
    NSMutableArray* questionsArray = [NSMutableArray array];
    
    // add the right answer to the first index of the temp array ( first index contain the )
    
    [questionsArray addObject:_theCorrectAnswer];
    
    
    NSUInteger randomIndex = 0;
    for (int  i = 0; i < answersCount -1; i++) {
        NSString* theCityName = @"";
        while (([theCityName isEqualToString:@""])||([self isString:theCityName ExistInArr:questionsArray])) {
            randomIndex = arc4random() % locArray.count;
            theCityName = [[[locArray objectAtIndex:randomIndex] city]cityName];
        }
        [questionsArray addObject:theCityName];
    }
    
    [self clearButtonTitle];
    randomIndex = arc4random() % answersCount;
    [self setButtonTitle:_theCorrectAnswer forBouttonAtIndex:randomIndex];
    
    for (int i = 1 ; i < [questionsArray count]; i++) {
        [self setEmptyButtonTitle:[questionsArray objectAtIndex:i]];
    }
}

-(BOOL) isString: (NSString*) string ExistInArr:(NSArray*) arr
{
    for (NSString* str in arr) {
        if ([str compare:string options:NSCaseInsensitiveSearch] == 0) {
            return YES;
        }
    }
    return NO;
}

-(void) clearButtonTitle{
    
    for (UIButton* button in _buttonArray ) {
        [button setTitle:@""  forState:UIControlStateNormal];
        button.tag =0;
        
    }
    
}

-(void) setButtonTitle:(NSString*) title forBouttonAtIndex:(NSInteger) index{
    
    UIButton* button = [_buttonArray objectAtIndex:index];
    [button setTitle:title  forState:UIControlStateNormal];
    button.tag = 1;
    
}

-(void) setEmptyButtonTitle:(NSString*) title{
    
    for (UIButton* button in _buttonArray ) {
        if (button.tag == 0) {
            [button setTitle:title  forState:UIControlStateNormal];
            button.tag = 1;
            return;
        }
        
    }
}

-(Boolean) didGameEnds{
    
    if ([_gameController levelQuizCnt] == -1)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Game Ends....."
                                                            message:@"Thanks For Downlaodings...@HasanSawaed" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:5.0];
        
        [alertView show];
        self.view.hidden = YES;
        return YES;
        
    }
    return NO;
}

-(void)dismissAlertView:(UIAlertView *)alertView{
    
    [alertView dismissWithClickedButtonIndex:0 animated:TRUE];
    
}

#pragma mark - UI

-(Boolean) checkAnswer:(NSInteger) index
{
    NSString * answerGuess = [[(UIButton*)[_buttonArray objectAtIndex:index] titleLabel] text];
    if ([answerGuess isEqualToString:_theCorrectAnswer]) {
        return  YES;
    }
    return NO;
}


-(void)updateScoreAndLives:(Boolean) is
{
    if (is) {
        _gameController.myScore += kLevel1;

    }else if(_gameController.myLives > 0){
            _gameController.myLives-- ;
        }
    
    [self updateSeen];
    
}

-(void)loadQuiz
{
    
}

-(void)countDown
{
    
}

#pragma mark - UIButton Actions

- (IBAction)answer1:(id)sender {
    
    if ([self checkAnswer:0]) {
        
        [self updateScoreAndLives:YES];
    }
    else
        [self updateScoreAndLives:NO];
    [_gameController addObjectsToTheGameArray];
    
    
}
- (IBAction)answer2:(id)sender {
    
    if ([self checkAnswer:1]) {

        [self updateScoreAndLives:YES];
    }
    else
        [self updateScoreAndLives:NO];
    
    [_gameController addObjectsToTheGameArray];
    
}
- (IBAction)answer3:(id)sender {
    
    if ([self checkAnswer:2]) {
        
        [self updateScoreAndLives:YES];
    }
    else
        [self updateScoreAndLives:NO];
    
    [_gameController addObjectsToTheGameArray];

}
- (IBAction)answer4:(id)sender {
    
    if ([self checkAnswer:3]) {
        
        [self updateScoreAndLives:YES];
    }
    else
        [self updateScoreAndLives:NO];
    
    [_gameController addObjectsToTheGameArray];
}

#pragma mark - Panoramio Delegate

-(void)didFinishShuffling:(PanoramioObject*)object{
    
    [_photosArray addObject:object];
    
    _theCorrectAnswer = [[[[_photosArray lastObject] photoLocation]city]cityName];
    [self showPhotos];
    
}

@end
