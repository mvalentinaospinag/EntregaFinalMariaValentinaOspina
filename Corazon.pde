class Corazon { 
  
PImage corazon;
  
  int x, y;
  Corazon(int x, int y) {
    
    this.x = x;
    this.y = y;
  }
  void display() {
    corazon = loadImage("vida.png");
    corazon.resize(50,50);
   image(corazon, x,y);
   
  }
}
