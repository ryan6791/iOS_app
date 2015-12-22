//
//  DraggableViewBackground.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

/*
 
 Copyright (c) 2014 Choong-Won Richard Kim <cwrichardkim@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards


@property (strong, nonatomic) IBOutlet UILabel *label123;
@property (strong, nonatomic) IBOutlet UILabel *a;
@property (strong, nonatomic) IBOutlet UILabel *b;
@property (strong, nonatomic) IBOutlet UILabel *c;
@property (strong, nonatomic) IBOutlet UILabel *d;
@property (strong, nonatomic) IBOutlet UILabel *e;
@property (strong, nonatomic) IBOutlet UILabel *f;
@property (strong, nonatomic) IBOutlet UILabel *g;
@property (strong, nonatomic) IBOutlet UILabel *h;
@property (strong, nonatomic) IBOutlet UILabel *i;
@property (strong, nonatomic) IBOutlet UILabel *j;
@property (strong, nonatomic) IBOutlet UILabel *k;
@property (strong, nonatomic) IBOutlet UILabel *l;
@property (strong, nonatomic) IBOutlet UILabel *m;
@property (strong, nonatomic) IBOutlet UILabel *n;
@property (strong, nonatomic) IBOutlet UILabel *o;
@property (strong, nonatomic) IBOutlet UILabel *p;
@property (strong, nonatomic) IBOutlet UILabel *q;
@property (strong, nonatomic) IBOutlet UILabel *r;
@property (strong, nonatomic) IBOutlet UILabel *s;
@property (strong, nonatomic) IBOutlet UILabel *t;
@property (strong, nonatomic) IBOutlet UILabel *u;
@property (strong, nonatomic) IBOutlet UILabel *v;
@property (strong, nonatomic) IBOutlet UILabel *w;
@property (strong, nonatomic) IBOutlet UILabel *x;
@property (strong, nonatomic) IBOutlet UILabel *y;
@property (strong, nonatomic) IBOutlet UILabel *z;



@end
