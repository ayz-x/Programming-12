class Mover {
  PVector r;
  PVector v;
  float s;
  Mover(PVector r, PVector v, float s) {
    this.r=r;
    this.v=v;
    this.s=s;
  }
  void show() {
    
    
    noStroke();
    fill(#555555,20);
    pushMatrix();
    translate(r.x,r.y,r.z);
    sphere(s);
    popMatrix();
  }

  void act() {
    r.add(v);
    if(r.x < 0){
      v.x = abs(v.x);
    }
    if(r.x > 800){
      v.x = -abs(v.x);
    }
    if(r.y < 0){
      v.y = abs(v.y);
    }
    if(r.y > 800){
      v.y = -abs(v.y);
    }
    if(r.z < -400){
      v.z = abs(v.z);
    }
    if(r.z > 400){
      v.z = -abs(v.z);
    }
  }
  
  void showConnections(Mover o){
    if(o.r != r){
      if(o.r.dist(r) < 500){
        float col = map(o.r.dist(r),0,500,0,200);
        float t = map(o.r.dist(r),0,500,100,10);
        stroke(col, t);
        float weight = map(o.r.dist(r),0,500,5,1);
        strokeWeight(weight);
        line(o.r.x, o.r.y, o.r.z,r.x, r.y, r.z);
      }
    }
  }
}
