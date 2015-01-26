//
//  MovieCell.h
//  RottenTomato
//
//  Created by Ashok Kumar on 1/25/15.
//  Copyright (c) 2015 ashok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
