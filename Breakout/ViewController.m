//
//  ViewController.m
//  Breakout
//
//  Created by Anthony  Severino on 1/16/14.
//  Copyright (c) 2014 Simple Management Solutions, Inc. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"
#import "BlockView.h"

@interface ViewController () <UICollisionBehaviorDelegate>
{
    
    UIDynamicAnimator *dynamicAnimator;
    UIPushBehavior *pushBehavior;
    UICollisionBehavior *collisionBehavior;
    UIDynamicItemBehavior *paddleDynamicBehavior;
    UIDynamicItemBehavior *ballDynamicBehavior;
    
    IBOutlet BlockView *blockView;
    
    IBOutlet PaddleView *paddleView;
    IBOutlet BallView *ballView;

}

@end

@implementation ViewController

- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x,paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect  viewRect = CGRectMake(10, 10, 20, 70);
    BlockView *blockView = [[BlockView alloc] initWithFrame:viewRect];
    
    
    //UIView* view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 70, 30)];
    
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active = YES;
    pushBehavior.magnitude = 0.1;
    
    [dynamicAnimator addBehavior:pushBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView,paddleView, blockView]];
    collisionBehavior.collisionDelegate = self;
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [dynamicAnimator addBehavior:collisionBehavior];

    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 1000000000000;
    
    ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ballView]];
    ballDynamicBehavior.allowsRotation = NO;
    ballDynamicBehavior.elasticity = 1.0;
    ballDynamicBehavior.friction = 0.0;
    ballDynamicBehavior.resistance = 0.0;
    
    
    [dynamicAnimator addBehavior:ballDynamicBehavior];
    [dynamicAnimator addBehavior:paddleDynamicBehavior];
    


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma UIcollisonBehaviorDelegate

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    if ([item2 isKindOfClass:[BlockView class]]) {
        blockView.alpha = 0;}
    
        if ([item1 isKindOfClass:[BlockView class]]) {
            blockView.alpha = 0;}

}

//    for (DieLabel *dieLabel in self.view.subviews)
//        if ([dieLabel isKindOfClass:[DieLabel class]]) {
//            [dieLabel roll];
//            dieLabel.delegate = self;





- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    //NSLog(@"before %f",ballView.center.y);
    if (ballView.center.y >=  545.0)
        {
            ballView.center = CGPointMake(ballView.center.x, 18.0);
            //NSLog(@"hit bottom");

        }
    //NSLog(@"after %f",ballView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:ballView];

}



@end
