PImage spikeup, spikedown, spikeleft, spikeright;
PImage[] lava = new PImage[6];
PImage treei, treet, treec, treer, treel;
PImage bridge;
PImage tramp, brick;
PImage[] ice = new PImage[4];
PImage plj, prj;
PImage[] pi = new PImage[2];
PImage[] prr = new PImage[3];
PImage[] prl = new PImage[3];
PImage heart;
PImage[] goomba = new PImage[2];
PImage[] hammerbro = new PImage[2];
PImage hammerimage;
PImage[] thwompimg = new PImage[2];
void loadTextures(int currmap){
  switch(currmap){
    case 0:
      heart = loadImage("textures/heart.png");
      heart.resize(16,16);
      
      spikeup = loadImage("textures/spike/spikeup.png");
      spikeup.resize(gridSize,gridSize);
      spikeleft = loadImage("textures/spike/spikeleft.png");
      spikeleft.resize(gridSize,gridSize);
      spikeright = loadImage("textures/spike/spikeright.png");
      spikeright.resize(gridSize,gridSize);
      spikedown = loadImage("textures/spike/spikedown.png");
      spikedown.resize(gridSize,gridSize);
      treei = loadImage("textures/tree/tree_intersect.png");
      treet = loadImage("textures/tree/tree_trunk.png");
      treec = loadImage("textures/tree/treetop_center.png");
      treer = loadImage("textures/tree/treetop_e.png");
      treel = loadImage("textures/tree/treetop_w.png");
      bridge = loadImage("textures/bridge_center.png");
      tramp = loadImage("textures/blueBlock.png");
      tramp.resize(gridSize,gridSize);
      brick = loadImage("textures/brick.png");
      for(int i = 0; i < 6; i++){
        lava[i] = loadImage("textures/lava/lava" + i + ".png");
      }
      for(int i = 1; i < 5; i++){
        ice[i-1] = loadImage("textures/ice/water" + i + ".png");
      }
      //jump and idle
      plj = loadImage("textures/playersprites/jump1.png");
      plj.resize(playerSizeX, playerSizeY);
      prj = loadImage("textures/playersprites/jump0.png");
      prj.resize(playerSizeX, playerSizeY);
      pi[0] = loadImage("textures/playersprites/idle1.png");
      pi[0].resize(playerSizeX, playerSizeY);
      pi[1] = loadImage("textures/playersprites/idle0.png");
      pi[1].resize(playerSizeX, playerSizeY);
      //right run
      prr[0] = loadImage("textures/playersprites/runright0.png");
      prr[1] = loadImage("textures/playersprites/runright1.png");
      prr[2] = loadImage("textures/playersprites/runright2.png");
      prr[0].resize(playerSizeX, playerSizeY);
      prr[1].resize(playerSizeX, playerSizeY);
      prr[2].resize(playerSizeX, playerSizeY);
      //left run
      prl[0] = loadImage("textures/playersprites/runleft0.png");
      prl[1] = loadImage("textures/playersprites/runleft1.png");
      prl[2] = loadImage("textures/playersprites/runleft2.png");
      prl[0].resize(playerSizeX, playerSizeY);
      prl[1].resize(playerSizeX, playerSizeY);
      prl[2].resize(playerSizeX, playerSizeY);
      
      goomba[0] = loadImage("textures/enemies/goomba0.png");
      goomba[0].resize(gridSize,gridSize);
      goomba[1] = loadImage("textures/enemies/goomba1.png");
      goomba[1].resize(gridSize,gridSize);
      
      hammerbro[0] = loadImage("textures/enemies/hammerbro0.png");
      hammerbro[0].resize(gridSize,gridSize);
      hammerbro[1] = loadImage("textures/enemies/hammerbro1.png");
      hammerbro[1].resize(gridSize,gridSize);
      
      hammerimage = loadImage("textures/enemies/hammer.png");
      
      thwompimg[0] = loadImage("textures/enemies/thwomp0.png");
      thwompimg[1] = loadImage("textures/enemies/thwomp1.png");
      break;
    default:
      break;
  }
}
