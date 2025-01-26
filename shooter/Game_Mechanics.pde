boolean die = false;

void loadNextMap(int i){
  if(next){
    world[i] = new FWorld(-2000, -2000, 2000, 2000);
    runners.clear();
    phantasms.clear();
    explodable.clear();
    player.setPosition(playerstart[i+1].x*32, playerstart[i+1].y*32);
    loadTextures(i+1);
    maps[i+1].addtoWorld(i+1);
    
    currmap = i + 1;
    createPlayer();
    next = false;
    
  }
}

void playerdeath() {
  if (die) {
    player.setPosition(playerstart[currmap].x*gridSize, playerstart[currmap].y*gridSize);
    die = false;
    respawnenemies();
  }
  
}

boolean istouching(FBody a, String n) {
  boolean ret = false;
  ArrayList<FBody> touching = a.getTouching();
  
    for (FBody k : touching) {

      if (k.getName().equals(n)) {
        ret = true;
      }
    }
    return ret;
  
}
