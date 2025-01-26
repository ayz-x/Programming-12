ArrayList<FBullet> bullets = new ArrayList<>();
class FBullet extends FCircle {
  int bounces;
  public FBullet() {
    super(5);
    setName("bullet");
    setFill(#FF0000);
    bounces = 4;
  }
}

ArrayList<FRocket> rockets = new ArrayList<>();
class FRocket extends FBox {
  int bounces;
  int explosionframe;
  FCircle explosion;
  boolean explode;
  float ex, ey;
  public FRocket() {
    super(5, 10);
    setName("rocket");
    setFill(#FF0000);
    bounces = 1;
    explode = false;
    rockets.add(this);
    world[currmap].add(this);
    explosion = new FCircle(5);
    explosion.setName("Explosion");
    explosionframe = 1;
    explosion.setSensor(true);
    explosion.setStatic(true);
    explosion.setFill(#FF0000);
  }
  void initiatecontact() {
    if (!explode) {
      explode = true;
      ex = this.getX();
      ey = this.getY();
      explosion.setPosition(ex,ey);
      world[currmap].remove(this);
      world[currmap].add(explosion);
      explosion.setPosition(ex,ey);
    }
  }
  void act() {
    ex = this.getX();
    ey = this.getY();
    if (explode) {
      
      if (explosionframe < 32) {
        explosion.setSize(explosionframe*5);
      } else if (explosionframe < 288) {
        explosion.setName("inactive");
        explosion.setFill(#FF0000, map(explosionframe, 32, 288, 255, 0));
      } else {
        world[currmap].remove(explosion);
        
      }
      explosionframe++;
    }
  }
}
