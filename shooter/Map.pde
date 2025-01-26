import java.io.BufferedReader;
import java.io.FileReader;
import java.util.StringTokenizer;




FPortal p;
FGun gun;
class Map {
  String[][] m;
  Map(String f, int k) {
    m = new String[128][128];
    BufferedReader input = createReader(f);
    String line = null;
    try {
      int j = 0;
      while((line = input.readLine()) != null){
        StringTokenizer st = new StringTokenizer(line);
        println(k + " " + j);
        for(int i = 0; i < floor(line.length()/3); i++){
          m[i][j] = st.nextToken();
        }
        j++;
      }    
    }
    
    catch(IOException e) {
      e.printStackTrace();
    }
    
  }



  String[][] getMap() {
    return m;
  }
  /*
  1 - norm
  2 - lava
  */
  void addtoWorld(int k) {
    for (int i = 0; i < ceil(mapdimensions[k].x); i++) {
      for (int j = 0; j < ceil(mapdimensions[k].y); j++) {
        if(m[i][j] == null){
          break;
        }
        
        println(i + " " + j + " " + ceil(mapdimensions[k].x) + " " +ceil(mapdimensions[k].y));
        //standard tile
        if (m[i][j].equals("01")) {
          
          FBox b = new FBox(gridSize,gridSize);
          boxes.add(b);
          b.setPosition(i*gridSize, j*gridSize);
          b.setFillColor(#000000);
          b.setStrokeColor(#000000);
          b.setGrabbable(false);
          b.setStatic(true);
          b.setFriction(2);
          b.attachImage(brick);
          b.setName("tile");
          world[k].add(b);
        }
        if(m[i][j].equals("02")){
          FExplodable b = new FExplodable(i,j,k);
        }
        //spike
        if (m[i][j].charAt(0) == 's') {
          
          FBox b = new FBox(gridSize,gridSize);
          boxes.add(b);
          b.setPosition(i*gridSize, j*gridSize);
          b.setFillColor(#ff0000);
          b.setNoStroke();
          b.setGrabbable(false);
          
          switch(m[i][j].charAt(1)){
            case 'r': 
              b.attachImage(spikeright);
              break;
            case 'd':
              b.attachImage(spikedown);
              break;
            case 'l':
              b.attachImage(spikeleft);
              break;
            default: // up
              b.attachImage(spikeup);
              break;
          }
          b.setStatic(true);
          b.setName("kill");
          
          world[k].add(b);
        }
        //ice
        if(m[i][j].equals("03")){
          FBox b = new FBox(gridSize, gridSize);
          boxes.add(b);
          b.setPosition(i*gridSize, j*gridSize);
          b.setFillColor(#BBEEFF);
          b.setStrokeColor(#BBEEFF);
          b.setStatic(true);
          b.setName("ice");
          b.setFriction(0);
          b.attachImage(ice[(int)random(0,4)]);
          world[k].add(b);
          
        }
        //trampoline
        if(m[i][j].equals("04")){
          FBox b = new FBox(gridSize,gridSize);
          boxes.add(b);
          b.setPosition(i*gridSize, j*gridSize);
          b.setFillColor(#00FF00);
          b.setStrokeColor(#00FF00);
          b.setGrabbable(false);
          b.setStatic(true);
          b.setFriction(2);
          b.setRestitution(0.9);
          b.attachImage(tramp);
          b.setName("trampoline");
          world[k].add(b);
          
        }
        
        
        if(m[i][j].equals("nl")){ //next level
          p = new FPortal(i,j,k);
        }
        if(m[i][j].equals("e1")){ //enemy 1: runner
          FRunner e = new FRunner(i,j);
          world[k].add(e);
        }
        if(m[i][j].equals("e2")){ //enemy 2: phantasm
          FPhantasm e = new FPhantasm(i,j);
          world[k].add(e);
        }
        if(m[i][j].equals("g1")){ //gun 1
          gun = new FGun(i,j,k,1);
          
        }
        
      }
      
    }
  }
}
