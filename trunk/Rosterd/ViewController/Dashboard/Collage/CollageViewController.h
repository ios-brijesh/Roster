//
//  ViewController.h
//  Collages
//
//  Created by Ekaterina Belinskaya on 12/03/15.
//  Copyright (c) 2015 Ekaterina Belinskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonsViewController.h"
#import "ChangingBordersViewController.h"
#import "ColorWheelView.h"

@protocol CollageStorySetDelegate <NSObject>
- (void)imagesData:(UIImage*)image;

@end

@interface CollageViewController : UIViewController< UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout,
     UIPopoverPresentationControllerDelegate, ButtonsDelegate, BordersDelegate,UIDocumentInteractionControllerDelegate, UIScrollViewDelegate, ColorDelegate>


@property(nonatomic, strong)id <CollageStorySetDelegate> delegate;
@end

