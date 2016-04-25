
/*
Copyright (C) 2014  Thomas Sanchez Lengeling + Tammy Le + Ali Tayyebi
 KinectPV2, Kinect for Windows v2 library for processing
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

FaceData [] faces;
Skeleton [] skeleton;

void setup() {
  size(1920, 1080, P3D);

  kinect = new KinectPV2(this);

  kinect.enableSkeleton(true);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableFaceDetection(true);

  kinect.init();
}

void draw() {
  background(0);
  image(kinect.getColorImage(), 0, 0, width, height);

  PImage screenBefore1 = kinect.getColorImage();
  PImage screenBefore2 = kinect.getColorImage();

  int f1 = -1;
  int f2 = -1;

  faces =  kinect.getFaceData();

  for (int i = 0; i < faces.length; i++) {
    if (faces[i].isFaceTracked()) {
      if (f1 == -1) {
        f1 = i;
      } else {
        f2 = i;
      }
    }
  }

  //individual JOINTS
  if (f1 != -1 && f2 != -1) {
    image(screenBefore2, 0, 0, 1920, 1080);
    copy(screenBefore1, Math.round(faces[f1].getBoundingRect().getX()-50), Math.round(faces[f1].getBoundingRect().getY()-50), Math.round(faces[f1].getBoundingRect().getWidth()+100), Math.round(faces[f1].getBoundingRect().getHeight()+100), Math.round(faces[f2].getBoundingRect().getX()-50), Math.round(faces[f2].getBoundingRect().getY()-50), Math.round(faces[f2].getBoundingRect().getWidth()+100), Math.round(faces[f2].getBoundingRect().getHeight()+100));
    copy(screenBefore1, Math.round(faces[f2].getBoundingRect().getX()-50), Math.round(faces[f2].getBoundingRect().getY()-50), Math.round(faces[f2].getBoundingRect().getWidth()+100), Math.round(faces[f2].getBoundingRect().getHeight()+100), Math.round(faces[f1].getBoundingRect().getX()-50), Math.round(faces[f1].getBoundingRect().getY()-50), Math.round(faces[f1].getBoundingRect().getWidth()+100), Math.round(faces[f1].getBoundingRect().getHeight()+100));
    //image(screenBefore2, 0, 0, 1920, 1080);
  }

  int s1 = -1;
  int s2 = -1;

  skeleton =  kinect.getSkeletonColorMap();

  for (int i = 0; i < skeleton.length; i++) {
    if (skeleton[i].isTracked()) {
      if (s1 == -1) {
        s1 = i;
      } else {
        s2 = i;
      }
    }
  }

  //individual JOINTS
  if (s1 != -1 && s2 != -1) {

    // elbow to hand

    KJoint[] joints1 = skeleton[s1].getJoints();
    KJoint[] joints2 = skeleton[s2].getJoints();

    // left
    int s1elX = Math.round(joints1[KinectPV2.JointType_ElbowLeft].getX());
    int s1elY = Math.round(joints1[KinectPV2.JointType_ElbowLeft].getY());

    int s1hlX = Math.round(joints1[KinectPV2.JointType_HandTipLeft].getX());
    int s1hlY = Math.round(joints1[KinectPV2.JointType_HandTipLeft].getY());

    int s2elX = Math.round(joints2[KinectPV2.JointType_ElbowLeft].getX());
    int s2elY = Math.round(joints2[KinectPV2.JointType_ElbowLeft].getY());

    int s2hlX = Math.round(joints2[KinectPV2.JointType_HandTipLeft].getX());
    int s2hlY = Math.round(joints2[KinectPV2.JointType_HandTipLeft].getY());

    copy(screenBefore1, s1elX, s1elY, s1hlX-s1elX, s1hlY-s1elY, s2elX, s2elY, s2hlX-s2elX, s2hlY-s2elY);
    copy(screenBefore1, s2elX, s2elY, s2hlX-s2elX, s2hlY-s2elY, s1elX, s1elY, s1hlX-s1elX, s1hlY-s1elY);

    // right


    int s1erX = Math.round(joints1[KinectPV2.JointType_ElbowRight].getX());
    int s1erY = Math.round(joints1[KinectPV2.JointType_ElbowRight].getY());

    int s1hrX = Math.round(joints1[KinectPV2.JointType_HandTipRight].getX());
    int s1hrY = Math.round(joints1[KinectPV2.JointType_HandTipRight].getY());

    int s2erX = Math.round(joints2[KinectPV2.JointType_ElbowRight].getX());
    int s2erY = Math.round(joints2[KinectPV2.JointType_ElbowRight].getY());

    int s2hrX = Math.round(joints2[KinectPV2.JointType_HandTipRight].getX());
    int s2hrY = Math.round(joints2[KinectPV2.JointType_HandTipRight].getY());

    copy(screenBefore1, s1erX, s1erY, s1hrX-s1erX, s1hrY-s1erY, s2erX, s2erY, s2hrX-s2erX, s2hrY-s2erY);
    copy(screenBefore1, s2erX, s2erY, s2hrX-s2erX, s2hrY-s2erY, s1erX, s1erY, s1hrX-s1erX, s1hrY-s1erY);

    // shoulder to elbow
    // left
          int s1shoulderLX = Math.round(joints1[KinectPV2.JointType_ShoulderLeft].getX());
          int s1shoulderLY = Math.round(joints1[KinectPV2.JointType_ShoulderLeft].getY());
      
          int s2shoulderLX = Math.round(joints2[KinectPV2.JointType_ShoulderLeft].getX());
          int s2shoulderLY = Math.round(joints2[KinectPV2.JointType_ShoulderLeft].getY());
      
          copy(screenBefore1, s1shoulderLX, s1shoulderLY, s1elX-s1shoulderLX, s1elY-s1shoulderLY, s2shoulderLX, s2shoulderLY, s2elX-s2shoulderLX, s2elY-s2shoulderLY);
          copy(screenBefore1, s2shoulderLX, s2shoulderLY, s2elX-s2shoulderLX, s2elY-s2shoulderLY, s1shoulderLX, s1shoulderLY, s1elX-s1shoulderLX, s1elY-s1shoulderLY);
      
          // right
      
          int s1shoulderRX = Math.round(joints1[KinectPV2.JointType_ShoulderRight].getX());
          int s1shoulderRY = Math.round(joints1[KinectPV2.JointType_ShoulderRight].getY());
      
          int s2shoulderRX = Math.round(joints2[KinectPV2.JointType_ShoulderRight].getX());
          int s2shoulderRY = Math.round(joints2[KinectPV2.JointType_ShoulderRight].getY());
     
          copy(screenBefore1, s1shoulderRX, s1shoulderRY, s1erX-s1shoulderRX, s1erY-s1shoulderRY, s2shoulderRX, s2shoulderRY, s2erX-s2shoulderRX, s2erY-s2shoulderRY);
          copy(screenBefore1, s2shoulderRX, s2shoulderRY, s2erX-s2shoulderRX, s2erY-s2shoulderRY, s1shoulderRX, s1shoulderRY, s1erX-s1shoulderRX, s1erY-s1shoulderRY);



    // hip to knee
    // left
    int s1hipLX = Math.round(joints1[KinectPV2.JointType_HipLeft].getX());
    int s1hipLY = Math.round(joints1[KinectPV2.JointType_HipLeft].getY());

    int s1kneeLX = Math.round(joints1[KinectPV2.JointType_KneeLeft].getX());
    int s1kneeLY = Math.round(joints1[KinectPV2.JointType_KneeLeft].getY());

    int s2hipLX = Math.round(joints2[KinectPV2.JointType_HipLeft].getX());
    int s2hipLY = Math.round(joints2[KinectPV2.JointType_HipLeft].getY());

    int s2kneeLX = Math.round(joints2[KinectPV2.JointType_KneeLeft].getX());
    int s2kneeLY = Math.round(joints2[KinectPV2.JointType_KneeLeft].getY());

    copy(screenBefore1, s1hipLX, s1hipLY, s1kneeLX-s1hipLX, s1kneeLY-s1hipLY, s2hipLX, s2hipLY, s2kneeLX-s2hipLX, s2kneeLY-s2hipLY);
    copy(screenBefore1, s2hipLX, s2hipLY, s2kneeLX-s2hipLX, s2kneeLY-s2hipLY, s1hipLX, s1hipLY, s1kneeLX-s1hipLX, s1kneeLY-s1hipLY);

    // right
    int s1hipRX = Math.round(joints1[KinectPV2.JointType_HipRight].getX());
    int s1hipRY = Math.round(joints1[KinectPV2.JointType_HipRight].getY());

    int s1kneeRX = Math.round(joints1[KinectPV2.JointType_KneeRight].getX());
    int s1kneeRY = Math.round(joints1[KinectPV2.JointType_KneeRight].getY());

    int s2hipRX = Math.round(joints2[KinectPV2.JointType_HipRight].getX());
    int s2hipRY = Math.round(joints2[KinectPV2.JointType_HipRight].getY());

    int s2kneeRX = Math.round(joints2[KinectPV2.JointType_KneeRight].getX());
    int s2kneeRY = Math.round(joints2[KinectPV2.JointType_KneeRight].getY());

    copy(screenBefore1, s1hipRX, s1hipRY, s1kneeRX-s1hipRX, s1kneeRY-s1hipRY, s2hipRX, s2hipRY, s2kneeRX-s2hipRX, s2kneeRY-s2hipRY);
    copy(screenBefore1, s2hipRX, s2hipRY, s2kneeRX-s2hipRX, s2kneeRY-s2hipRY, s1hipRX, s1hipRY, s1kneeRX-s1hipRX, s1kneeRY-s1hipRY);

    // knee to ankle
    // left
    int s1AnkleLX = Math.round(joints1[KinectPV2.JointType_AnkleLeft].getX());
    int s1AnkleLY = Math.round(joints1[KinectPV2.JointType_AnkleLeft].getY());

    int s2AnkleLX = Math.round(joints2[KinectPV2.JointType_AnkleLeft].getX());
    int s2AnkleLY = Math.round(joints2[KinectPV2.JointType_AnkleLeft].getY());

    copy(screenBefore1, s1kneeLX, s1kneeLY, s1AnkleLX-s1kneeLX, s1AnkleLY-s1kneeLY, s2kneeLX, s2kneeLY, s2AnkleLX-s2kneeLX, s2AnkleLY-s2kneeLY);
    copy(screenBefore1, s2kneeLX, s2kneeLY, s2AnkleLX-s2kneeLX, s2AnkleLY-s2kneeLY, s1kneeLX, s1kneeLY, s1AnkleLX-s1kneeLX, s1AnkleLY-s1kneeLY);

    // right
    int s1AnkleRX = Math.round(joints1[KinectPV2.JointType_AnkleRight].getX());
    int s1AnkleRY = Math.round(joints1[KinectPV2.JointType_AnkleRight].getY());

    int s2AnkleRX = Math.round(joints2[KinectPV2.JointType_AnkleRight].getX());
    int s2AnkleRY = Math.round(joints2[KinectPV2.JointType_AnkleRight].getY());


    copy(screenBefore1, s1kneeRX, s1kneeRY, s1AnkleRX-s1kneeRX, s1AnkleRY-s1kneeRY, s2kneeRX, s2kneeRY, s2AnkleRX-s2kneeRX, s2AnkleRY-s2kneeRY);
    copy(screenBefore1, s2kneeRX, s2kneeRY, s2AnkleRX-s2kneeRX, s2AnkleRY-s2kneeRY, s1kneeRX, s1kneeRY, s1AnkleRX-s1kneeRX, s1AnkleRY-s1kneeRY);

  }

}


void keyPressed() {
  if (key == 's') {
    saveFrame("dada-########.jpg");
  }
}

