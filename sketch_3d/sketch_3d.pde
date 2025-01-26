import java.util.*;
import java.io.*;

float rotx, roty;
void setup(){
  size(800,800,P3D);
  
  
}

void draw(){
  background(255);
  
  //123456 is no fill
  cube(width/2, height/2, 0, #123456, 100);
  sphere(700, 300, -50, #FF0000, 100);
  cube(100, 100, 50, #FFFFFF, 50);
}

void cube(float x, float y, float z, color col, float size){
  pushMatrix();
  translate(x,y,z);
  fill(col);
  rotateX(rotx);
  rotateY(roty);
  box(size,size,size); // w h d
  popMatrix();
}
void sphere(float x, float y, float z, color col, float size){
  pushMatrix();
  translate(x,y,z);
  fill(col);
  rotateX(rotx);
  rotateY(roty);
  sphere(size); // w h d
  popMatrix();
}

void mouseDragged(){
  rotx = rotx + (pmouseY - mouseY)*0.05;
  roty = roty + (pmouseX - mouseX)*0.05;
}
