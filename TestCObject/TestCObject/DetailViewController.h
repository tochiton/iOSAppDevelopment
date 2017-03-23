//
//  DetailViewController.h
//  TestCObject
//
//  Created by Developer on 1/5/17.
//  Copyright © 2017 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestCObject+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Images *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

