//
//  ViewControllerModel.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerModel : NSObject

-(void)retrievePrimes:(NSInteger)limit complete:(void(^)(NSArray<NSNumber *>*))complete;

@end
