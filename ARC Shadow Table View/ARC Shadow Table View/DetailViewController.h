//
//  DetailViewController.h
//  ARC Shadow Table View
//
//  Created by venj on 13-4-12.
//  Copyright (c) 2013年 venj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
