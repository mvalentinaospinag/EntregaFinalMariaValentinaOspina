class Carro { 

  PImage Sprite;
  String nomImagen;

  int x, y;
  Carro(int x, int y, String nombre) {

    this.x = x;
    this.y = y;
    
    nomImagen = nombre;
  }
  void draw(int dim1, int dim2, boolean mostrar) {
    Sprite = loadImage(nomImagen);
    if(mostrar) image(Sprite, x, y,dim1,dim2);
  }
}
