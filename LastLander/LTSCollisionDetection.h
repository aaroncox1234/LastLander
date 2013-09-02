//
//  CollisionDetection.h
//  LastLander
//
//  Created by Aaron Cox on 2013-08-23.
//  Copyright (c) 2013 Aaron Cox. All rights reserved.
//

#ifndef LastLander_CollisionDetection_h
#define LastLander_CollisionDetection_h

// Public domain algorithm from http://alienryderflex.com/intersect/
static bool lineSegmentIntersection(double Ax, double Ay,
									double Bx, double By,
									double Cx, double Cy,
									double Dx, double Dy,
									double *X, double *Y) {
	
	double  distAB, theCos, theSin, newX, ABpos ;
	
	//  Fail if either line segment is zero-length.
	if ((Ax==Bx && Ay==By) || (Cx==Dx && Cy==Dy)) return NO;
	
	//  Fail if the segments share an end-point.
	if ((Ax==Cx && Ay==Cy) || (Bx==Cx && By==Cy)
		||  (Ax==Dx && Ay==Dy) || (Bx==Dx && By==Dy)) {
		return NO; }
	
	//  (1) Translate the system so that point A is on the origin.
	Bx-=Ax; By-=Ay;
	Cx-=Ax; Cy-=Ay;
	Dx-=Ax; Dy-=Ay;
	
	//  Discover the length of segment A-B.
	distAB=sqrt(Bx*Bx+By*By);
	
	//  (2) Rotate the system so that point B is on the positive X axis.
	theCos=Bx/distAB;
	theSin=By/distAB;
	newX=Cx*theCos+Cy*theSin;
	Cy  =Cy*theCos-Cx*theSin; Cx=newX;
	newX=Dx*theCos+Dy*theSin;
	Dy  =Dy*theCos-Dx*theSin; Dx=newX;
	
	//  Fail if segment C-D doesn't cross line A-B.
	if ((Cy<0. && Dy<0.) || (Cy>=0. && Dy>=0.)) return NO;
	
	//  (3) Discover the position of the intersection point along line A-B.
	ABpos=Dx+(Cx-Dx)*Dy/(Dy-Cy);
	
	//  Fail if segment C-D crosses line A-B outside of segment A-B.
	if (ABpos<0. || ABpos>distAB) return NO;
	
	//  (4) Apply the discovered position to line A-B in the original coordinate system.
	*X=Ax+ABpos*theCos;
	*Y=Ay+ABpos*theSin;
	
	//  Success.
	return YES;
}

static bool testSegmentIntersection(CGPoint start1, CGPoint end1, CGPoint start2, CGPoint end2) {
	
	double dummyX;
	double dummyY;
	
	return lineSegmentIntersection( start1.x, start1.y,
								    end1.x, end1.y,
								    start2.x, start2.y,
								    end2.x, end2.y,
								    &dummyX, &dummyY);
}

#endif
