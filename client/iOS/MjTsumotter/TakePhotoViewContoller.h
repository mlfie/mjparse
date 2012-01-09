//
//  TakePhotoViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TakePhotoViewContoller : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIBarButtonItem                 *cameraButton_;
    UIBarButtonItem                 *sendButton_;
    
    UILabel                         *photoLabel_;
    UIImageView                     *photoView_;
    UILabel                         *bakazeLabel_;
    UISegmentedControl              *bakazeSelect_;
    UILabel                         *jikazeLabel_;
    UISegmentedControl              *jikazeSelect_;
    
    UIImage                         *photo_;
}

- (void)takePhoto:(id)sender;
- (void)sendAgariPhoto:(id)sender;

@end
