//
//  XRLayout.m
//  XMelo
//
//  Created by melo on 2017/12/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XRLayout.h"

@implementation XRLayout

-(instancetype)init{
	
	if (self = [super init]) {
		
		//设置item的大小
		CGFloat theWith 		= kScreenWidth - 40;
		self.itemSize 			= CGSizeMake(theWith, 140);
		self.scrollDirection  	= UICollectionViewScrollDirectionHorizontal;
		self.sectionInset 		= UIEdgeInsetsMake(-5, 20, -5, 20);
		self.minimumLineSpacing = (kScreenWidth - theWith)/4;
	}
	return self;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
	NSArray *arr = [self copyAttributes: [super layoutAttributesForElementsInRect:rect]];
	//屏幕中间线
	CGFloat centerX = self.collectionView.contentOffset.x  + self.collectionView.bounds.size.width /2.0f;
	//刷新cell缩放
	for (UICollectionViewLayoutAttributes *attribute in arr) {
		
		CGFloat distance = fabs(attribute.center.x - centerX);
		//移动的距离和屏幕宽的比例
		CGFloat screenScale = distance /self.collectionView.bounds.size.width;
		//卡片移动到固定范围内 -π/4 到 π/4
		CGFloat scale = fabs(cos(screenScale * M_PI/4));
		//设置cell的缩放 按照余弦函数曲线  越居中越接近于1
		attribute.transform = CGAffineTransformMakeScale(1.0, scale);
		//透明度
		attribute.alpha = scale;
	}
	
	
	return arr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
	return YES;
}
-(NSArray *)copyAttributes:(NSArray  *)arr{
	NSMutableArray *copyArr = [NSMutableArray new];
	for (UICollectionViewLayoutAttributes *attribute in arr) {
		[copyArr addObject:[attribute copy]];
	}
	
	
	return copyArr;
}

//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//	NSArray *attrs = [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
//	CGFloat contentOffsetX = self.collectionView.contentOffset.x;
//	CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
//	for (UICollectionViewLayoutAttributes *attr in attrs) {
//		CGFloat scale = 1 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.bounds.size.width;
//		attr.transform = CGAffineTransformMakeScale(scale, scale);
//	}
//	return attrs;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//	return YES;
//}
//
////  每次都有图片居中
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//	CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
//	NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
//	CGFloat contentOffsetX = self.collectionView.contentOffset.x;
//	CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
//	CGFloat minDistance = MAXFLOAT;
//	for (UICollectionViewLayoutAttributes *attr in attrs) {
//		CGFloat distance = attr.center.x - contentOffsetX - collectionViewCenterX;
//		if (fabs(distance) < fabs(minDistance)) {
//			minDistance = distance;
//		}
//	}
//	proposedContentOffset.x += minDistance;
//	return proposedContentOffset;
//}
//
////  UICollectionViewFlowLayout has cached frame mismatch for index path这个警告来源主要是在使用layoutAttributesForElementsInRect：方法返回的数组时，没有使用该数组的拷贝对象，而是直接使用了该数组。解决办法对该数组进行拷贝，并且是深拷贝。
//
//- (NSArray *)deepCopyWithArray:(NSArray *)arr {
//	NSMutableArray *arrM = [NSMutableArray array];
//	for (UICollectionViewLayoutAttributes *attr in arr) {
//		[arrM addObject:[attr copy]];
//	}
//	return arrM;
//}
@end
