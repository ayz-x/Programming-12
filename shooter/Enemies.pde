


ArrayList<FRunner> runners = new ArrayList<>();
class FRunner extends FBox {
  int frame;
  int gsprite;
  int i, j;
  int deathframe;
  int xfacing;
  boolean death;
  boolean aggro;
  float prevVeloy;
  float prevx;
  float ray;
  float rdx;

  public FRunner(int i, int j) {
    super(gridSize, gridSize);
    this.i=i;
    this.j=j;
    death = false;
    aggro = false;
    setPosition(i*gridSize, j*gridSize);
    xfacing = 0;

    setName("enemy");
    runners.add(this);
    frame =(int) random(0, 9786);
    gsprite = (int) random(0, 2);
    prevVeloy = 0;
    prevx = 0;
    
    
  }

  void act() {
    if(istouching(this,"bullet")){
      death = true;
      setSensor(true);
    }
    
    
    setFriction(0);
    if (getX() < player.getX() - 10) {
      xfacing = 1;
    } else if (getX() > player.getX() + 10) {
      xfacing = -1;
    } else {
      xfacing = 0;
    }
    ray = (getVelocityY()-prevVeloy)/freq;
    rdx = (getX()-prevx)/freq;
    
    
    setRotation(0);
    if (player.getX() < getX() + 128 && player.getX() > getX() - 128 &&
      player.getY() < getY() + 128 && player.getY() > getY() - 128) {
      aggro = true;
    }

    if (!death && aggro) {
      if (abs(rdx) < 10 || player.getY() < getY()) {
        if (abs(ray) < 10) {
          setVelocity(getVelocityX(), -260);
        }
      }
      setVelocity(xfacing * 100, getVelocityY());
      
      frame++;
      if (frame%4 == 0) {
        gsprite++;
      }
      if (gsprite > 1) {
        gsprite = 0;
      }
      

      
    }
    attachImage(goomba[gsprite]);

    if (death) {
      setName("dead");
      aggro = false;
      deathframe++;
      setImageAlpha(map(deathframe, 0, 100, 255, 0));
    }
    if (deathframe == 100) {
      world[currmap].remove(this);
    }

    prevx = getX();
    prevVeloy = getVelocityY();
  }
  void respawn() {
    world[currmap].remove(this);
    death = false;
    aggro=false;
    setSensor(false);
    setImageAlpha(225);
    setVelocity(0,0);
    setPosition(i*gridSize, j*gridSize -10);
    world[currmap].add(this);
    setName("enemy");
    deathframe = 0;
    xfacing = 1;
  }
}
ArrayList<FPhantasm> phantasms = new ArrayList<>();
class FPhantasm extends FBox {
  int frame;
  int gsprite;
  int i, j;
  int deathframe;
  int xfacing;
  boolean death;
  boolean aggro;
  float prevVeloy;
  float prevx;
  float ray;
  float rdx;

  public FPhantasm(int i, int j) {
    super(gridSize/2, gridSize/2);
    this.i=i;
    this.j=j;
    death = false;
    aggro = false;
    setPosition(i*gridSize, j*gridSize);
    xfacing = 0;
    setFill(#AAAAAA, 50);
    setName("enemy");
    phantasms.add(this);
    frame =(int) random(0, 9786);
    gsprite = (int) random(0, 2);
    prevVeloy = 0;
    prevx = 0;
    setStatic(true);
    
  }

  void act() {
    if(istouching(this,"bullet")){
      death = true;
      
    }
    
    
    setRotation(0);
    if (player.getX() < getX() + 160 && player.getX() > getX() - 160 &&
      player.getY() < getY() + 160 && player.getY() > getY() - 160) {
      aggro = true;
      setSensor(true);
      setStatic(false);
    }
    float ptheta = atan2(player.getY() - getY(), player.getX() - getX());
    if (!death && aggro) {
      
      setVelocity(cos(ptheta) * 175, sin(ptheta) * 175);
      
      frame++;
      if (frame%4 == 0) {
        gsprite++;
      }
      if (gsprite > 1) {
        gsprite = 0;
      }
      

      
    }
    

    if (death) {
      setName("dead");
      setSensor(true);
      aggro = false;
      deathframe++;
      setFill(#AAAAAA, map(deathframe, 0, 100, 50, 0));
      setImageAlpha(map(deathframe, 0, 100, 255, 0));
    }
    if (deathframe == 100) {
      world[currmap].remove(this);
    }

    prevx = getX();
    prevVeloy = getVelocityY();
  }
  void respawn() {
    world[currmap].remove(this);
    setFill(#AAAAAA, 50);
    death = false;
    setStatic(true);
    aggro=false;
    setSensor(false);
    setImageAlpha(225);
    setVelocity(0,0);
    setPosition(i*gridSize, j*gridSize);
    world[currmap].add(this);
    setName("enemy");
    deathframe = 0;
    xfacing = 1;
  }
}

void enemiesact() {
  for (FRunner k : runners) {
    k.act();
  }
  for (FPhantasm k : phantasms) {
    k.act();
  }
  
  for(FExplodable k : explodable){
    k.act();
  }
}
void respawnenemies() {
  for (FRunner k : runners) {
    k.respawn();
  }
  for (FPhantasm k : phantasms) {
    k.respawn();
  }
  for(FExplodable k : explodable){
    world[currmap].remove(k);
    world[currmap].add(k);
  }
}
