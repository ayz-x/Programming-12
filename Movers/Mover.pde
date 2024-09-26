class Mover {
  float x, y;
  Mover(float x, float y) {
    this.x=x;
    this.y=y;
  }
  void show(float s) {
    
    stroke(0);
    
    strokeWeight(5);
    circle(x, y, s);
  }

  void act() {
    if(x <= 300){
      x += random(-5, 5*(1 + (300-x)/1200));
    }else if(x >= 300){
      x += random(-5*(1 + (x-300)/1200), 5);
    }
    if(y <= 300){
      y += random(-5, 5*(1 + (300-y)/1200));
    }else if(y >= 300){
      y += random(-5*(1 + (y-300)/1200), 5);
    }
    
  }
}
