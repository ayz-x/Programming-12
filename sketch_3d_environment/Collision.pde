float nudge = 0.2;
int canGoForward(){
  //0: both, 1: Z only 2: X only, -1: neither
  boolean canZ = true;
  boolean canX = true;
  float newZ = eyeZ + sin(theta)*100;
  float newX = eyeX + cos(theta)*100;
  if(round(newX/100) > 41 || round(newX/100) < -1){
    canX = false;
  }
  if(round(newZ/100) > 41 || round(newZ/100) < -1){
    canZ = false;
  }
  
  if(terrain[round(newX/100)][round(tcoord.y)][round(tcoord.z)] 
  || terrain[round(newX/100)][round(tcoord.y) - 1][round(tcoord.z)]){
    canX = false;
  }
  if(terrain[round(tcoord.x)][round(tcoord.y)][round(newZ/100)] 
  || terrain[round(tcoord.x)][round(tcoord.y) - 1][round(newZ/100)]){
    canZ = false;
  }
  
  if(canX && canZ){
    return 0;
  }else if(canZ){
    return 1;
  }else if(canX){
    return 2;
  }else{
    return -1;
  }
}
int canGoBack(){
  //0: both, 1: Z only 2: X only, -1: neither
  boolean canZ = true;
  boolean canX = true;
  float newZ = eyeZ - sin(theta)*100;
  float newX = eyeX - cos(theta)*100;
  if(round(newX/100) > 41 || round(newX/100) < -1){
    canX = false;
  }
  if(round(newZ/100) > 41 || round(newZ/100) < -1){
    canZ = false;
  }
  
  if(terrain[round(newX/100)][round(tcoord.y)][round(tcoord.z)] 
  || terrain[round(newX/100)][round(tcoord.y) - 1][round(tcoord.z)]){
    canX = false;
  }
  if(terrain[round(tcoord.x)][round(tcoord.y)][round(newZ/100)] 
  || terrain[round(tcoord.x)][round(tcoord.y) - 1][round(newZ/100)]){
    canZ = false;
  }
  
  if(canX && canZ){
    return 0;
  }else if(canZ){
    return 1;
  }else if(canX){
    return 2;
  }else{
    return -1;
  }
}
int canGoLeft(){
  //0: both, 1: Z only 2: X only, -1: neither
  boolean canZ = true;
  boolean canX = true;
  float newZ = eyeZ + cos(theta)*100;
  float newX = eyeX - sin(theta)*100;
  if(round(newX/100) > 41 || round(newX/100) < -1){
    canX = false;
  }
  if(round(newZ/100) > 41 || round(newZ/100) < -1){
    canZ = false;
  }
  
  if(terrain[round(newX/100)][round(tcoord.y)][round(tcoord.z)] 
  || terrain[round(newX/100)][round(tcoord.y) - 1][round(tcoord.z)]){
    canX = false;
  }
  if(terrain[round(tcoord.x)][round(tcoord.y)][round(newZ/100)] 
  || terrain[round(tcoord.x)][round(tcoord.y) - 1][round(newZ/100)]){
    canZ = false;
  }
  
  if(canX && canZ){
    return 0;
  }else if(canZ){
    return 1;
  }else if(canX){
    return 2;
  }else{
    return -1;
  }
}
int canGoRight(){
  //0: both, 1: Z only 2: X only, -1: neither
  boolean canZ = true;
  boolean canX = true;
  float newZ = eyeZ - cos(theta)*100;
  float newX = eyeX + sin(theta)*100;
  if(round(newX/100) > 41 || round(newX/100) < -1){
    canX = false;
  }
  if(round(newZ/100) > 41 || round(newZ/100) < -1){
    canZ = false;
  }
  
  if(terrain[round(newX/100)][round(tcoord.y)][round(tcoord.z)] 
  || terrain[round(newX/100)][round(tcoord.y) - 1][round(tcoord.z)]){
    canX = false;
  }
  if(terrain[round(tcoord.x)][round(tcoord.y)][round(newZ/100)] 
  || terrain[round(tcoord.x)][round(tcoord.y) - 1][round(newZ/100)]){
    canZ = false;
  }
  
  if(canX && canZ){
    return 0;
  }else if(canZ){
    return 1;
  }else if(canX){
    return 2;
  }else{
    return -1;
  }
}

boolean canGoDown(){
  float newY = eyeY - 200;
  if(round(newY/100) < 0){
    return false;
  }
  if(terrain[round(tcoord.x - nudge)][round(newY/100)][round(tcoord.z - nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x - nudge)][round(newY/100)][round(tcoord.z + nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x + nudge)][round(newY/100)][round(tcoord.z - nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x + nudge)][round(newY/100)][round(tcoord.z + nudge)]){
    return false;
  }
  return true;
}
boolean canGoUp(){
  float newY = eyeY + 100;
  if(round(newY/100) > 20){
    return false;
  }
  if(terrain[round(tcoord.x - nudge)][round(newY/100)][round(tcoord.z - nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x - nudge)][round(newY/100)][round(tcoord.z + nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x + nudge)][round(newY/100)][round(tcoord.z - nudge)]){
    return false;
  }
  if(terrain[round(tcoord.x + nudge)][round(newY/100)][round(tcoord.z + nudge)]){
    return false;
  }
  return true;
}
