class Button {
  float x, y, w, h;
  boolean clicked;
  boolean circular;
  color highlight, normal;
  color strhl, strnm;
  String text;
  float rounded;
  boolean hover;
  PImage img1;
  PImage img2;
  boolean hasImage = false;
  //elliptical
  Button(float x, float y, float w, float h, color hl, color nm, color strhl, color strnm, String txt) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    circular = true;
    highlight = hl;
    normal = nm;
    text = txt;
    this.strhl=strhl;
    this.strnm=strnm;
    hasImage = false;
  }
  //rectangular
  Button(float x, float y, float w, float h, color hl, color nm, color strhl, color strnm, String txt, float rounded, String img1, String img2) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    circular = false;
    highlight = hl;
    normal = nm;
    text = txt;
    this.strhl=strhl;
    this.strnm=strnm;
    this.rounded = rounded;
    if(!img1.isEmpty() && !img2.isEmpty()){
      this.img1 = loadImage(img1);
      this.img2 = loadImage(img2);
      hasImage = true;
    }else if(!img1.isEmpty() && img2.isEmpty()){
      this.img1 = loadImage(img1);
      this.img2 = loadImage(img1);
      hasImage = true;
    }else if(img1.isEmpty() && !img2.isEmpty()){
      this.img2 = loadImage(img2);
      this.img1 = loadImage(img2);
      hasImage = true;
    }else{
      hasImage = false;
    }
    if(hasImage){
      imageMode(CENTER);
      this.img1.resize((int)w,(int)h);
      this.img2.resize((int)w,(int)h);
    }
  }

  void show() {
    rectMode(CENTER);
    imageMode(CENTER);

    if (circular) {
      if (mouseX > x-w/2 && mouseX < x + w/2) {
        float yh = sqrt((sq(h/2)*(sq(w/2)-sq(x-mouseX))/sq(w/2)));
        float yl = y-yh;
        yh = y+yh;


        if (mouseY < yh && mouseY > yl) {
          hover = true;
        } else {
          hover = false;
        }
      } else {
        hover = false;
      }
    } else {
      if (mouseX > x-w/2 && mouseX < x + w/2 && mouseY > y-h/2 && mouseY < y + h/2) {
        hover = true;
      } else {
        hover = false;
      }
    }
    //button fill
    if (hover) {
      fill(highlight);
      stroke(strhl);
    } else {
      fill(normal);
      stroke(strnm);
    }
    if (circular) {
      ellipse(x, y, w, h);
    } else {
      rect(x, y, w, h, rounded);
    }
    
    //img
    if (hover && hasImage) {
      image(img2,x,y);
    } else if(hasImage){
      image(img1,x,y);
    }


    //textcolor
    if (hover) {
      fill(strhl);
      stroke(strhl);
    } else {
      fill(strnm);
      stroke(strnm);
    }
    textAlign(CENTER, CENTER);
    textSize(w/text.length());
    text(text, x, y);
  }
  boolean pressed = false;
  void checkRelease() {
    if (!mousePressed && pressed) {
      mouseReleased = true;
      pressed = false;
      println("released");
    }
    if (mousePressed && !pressed) {
      pressed = true;
      mouseReleased = false;
    }
  }
  boolean pressed() {
    if (hover && mouseReleased) {
      return true;
    }
    return false;
  }
}

boolean mouseReleased;
boolean wasPressed;
void click() {
  mouseReleased = false;
  if (mousePressed) {
    wasPressed = true;
  }
  if (wasPressed&& !mousePressed) {
    wasPressed = false;
    mouseReleased = true;
  }
}
