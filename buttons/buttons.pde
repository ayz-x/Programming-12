void setup(){
  size(600,600);
  button1 = new Button(150,100,200,100,#00FF00,#00AA00,0,0,"green",50, "","");
  button2 = new Button(450,100,200,100,#0000FF,#0000AA,0,0,"blue");
  button3 = new Button(150,300,200,200,#FF0000,#AA0000,0,0,"red",2 ,"","");
  button4 = new Button(450,400,200,300,0,50,255,255,"black",2, "amogus.png","");
  amogus = loadImage("amogus.png");
  amogus.resize(600,600);
}
//ellipse(float x, float y, float w, float h, color hl, color nm, color strhl, color strnm, String txt)
//rect(float x, float y, float w, float h, color hl, color nm, color strhl, color strnm, String txt, float rounded, String img1, String img2) {
Button button1;
Button button2;
Button button3;
Button button4;
PImage amogus;
void draw(){
  click();
  
  
  
  button1.show();
  if(button1.pressed()){
    background(#00FF00);
  }
  
 
 
  button2.show();
  if(button2.pressed()){
    background(#0000FF);
  }

 
  button3.show();
  if(button3.pressed()){
    background(#FF0000);
  }
  
 
 
  button4.show();
  if(button4.pressed()){
    background(0);
    imageMode(CENTER);
    image(amogus,300,300);
  }
  
}
