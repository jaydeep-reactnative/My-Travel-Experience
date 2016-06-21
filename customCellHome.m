//
//  customCellHome.m
//  Tourist
//
//  Created by indianic on 14/03/16.
//  Copyright © 2016 Jd's Mac. All rights reserved.
//

#import "customCellHome.h"

@implementation customCellHome

@synthesize starRating=_starRating;

#pragma mark - Rating button
- (void)awakeFromNib {
    // Setup control using iOS7 tint Color
    _starRating.backgroundColor  = [UIColor clearColor];
    _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    
//    [self starsSelectionChanged:_starRating rating:2.5];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
