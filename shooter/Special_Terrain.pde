class FPortal extends FBox{
  int i, j;
  public FPortal(int i, int j, int k){
    super(gridSize, gridSize);
    setPosition(i*gridSize, j*gridSize);
    setFillColor(#00FF00);
    setStrokeColor(#00FF00);
    setGrabbable(false);
    setStatic(true);
    setSensor(true);
    setFriction(2);
    setRestitution(0);
    setName("portal");
    world[k].add(this);
  }
}


class FGun extends FBox{
  int i, j;
  public FGun(int i, int j, int k, int n){
    super(gridSize, gridSize);
    setPosition(i*gridSize, j*gridSize);
    setFillColor(#000000);
    setStrokeColor(#000000);
    setGrabbable(false);
    setStatic(true);
    setSensor(true);
    setFriction(2);
    setRestitution(0);
    setName("g" + n);
    world[k].add(this);
  }
}

ArrayList<FExplodable> explodable = new ArrayList<>();
class FExplodable extends FBox{
  int i, j;
  public FExplodable(int i, int j, int k){
    super (gridSize, gridSize);
    setPosition(i*gridSize, j*gridSize);
    setFillColor(#555555);
    setStrokeColor(#555555);
    setGrabbable(false);
    setStatic(true);
    setFriction(2);
    setName("tile");
    world[k].add(this);
    explodable.add(this);
  }
  
  void act(){
    if(istouching(this, "bullet")){
      world[currmap].remove(this);
    }
  }
}
