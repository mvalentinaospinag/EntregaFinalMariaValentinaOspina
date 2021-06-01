class Moneda { 
  
PImage moneda;
  
  int x, y;
  Moneda(int x, int y) {
    
    this.x = x;
    this.y = y;
  }
  void display() {
    moneda = loadImage("moneda.png");
    moneda.resize(50,50);
   image(moneda, x,y);
   
  }
}
