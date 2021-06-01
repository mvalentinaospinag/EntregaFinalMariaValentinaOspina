color color_nubes;
color color_cielo;
color arbol_lejos; 
color arbol_cerca;
color borde_hojas;
color color_carretera;

int estado;


//estados

PImage menu_facil;
PImage menu_dificil;
PImage intro;
PImage juego;
PImage game_over;
PImage vidas2;
PImage vidas1;


//sprites
PImage player;
PImage moneda;
PImage vida;

Carro car1;
Carro car2;
Carro car3;
Carro car4;
Carro car5;

boolean mostrar1 = true;


//variables juego
int vidasRestantes;
int contadorMonedas;
int numMonedas;
int numVidas;
ArrayList<Moneda> mon = new ArrayList();
ArrayList<Corazon> vid = new ArrayList();
ArrayList<Carro> carril1 = new ArrayList();
ArrayList<Carro> carril2 = new ArrayList();
ArrayList<Carro> carril3 = new ArrayList();
int puntaje;

int xplayer;
int yplayer;
int direccion;

int posMonedasX;
int posMonedasY;

int posVidasY;

int mod_pts;

int flag;

//otros autos



int posCarril1X=350;
int posCarril2X=360;
int posCarril3X=380;
int posCarril1Y=(int)random(340, 345);
int posCarril2Y= (int)random(340, 345);
int posCarril3Y= (int)random(320, 325);

int tamanoX = 40;
int tamanoY = 40;
int autoscarril1 = 0;
int autoscarril2 = 0;
int autoscarril3 = 0;

void setup()
{
  size(800, 600); //tamaño de la ventana
  frameRate(30);

  estado = 0;

  //imágenes estados
  intro = loadImage("image00001.png");
  menu_facil = loadImage("menu_facil.png");
  menu_dificil = loadImage("menu_dificil.png");
  juego = loadImage("juego.png");
  game_over = loadImage("game_over.png");
  vidas2 = loadImage("2vidas.png");
  vidas1 = loadImage("1vida.png");


  //cargar sprites

  player = loadImage("player.png");
  moneda = loadImage("moneda.png");
  vida = loadImage("vida.png");



  //juego

  numMonedas = 3;
  numVidas = 1;//vidas de salvamento
  vidasRestantes = 3;
  xplayer = 350;
  yplayer = 450;
  flag = 1;


  posMonedasY=(int)random(450, 480);

  for (int i=0; i<numMonedas; i++) { 
    Moneda M = new Moneda((int)random(150, 600), posMonedasY);
    mon.add(M);
  }

  posVidasY=(int)random(450, 480);

  for (int i=0; i<numVidas; i++) { 
    Corazon V = new Corazon((int)random(150, 600), posVidasY);
    vid.add(V);
  }
}



void draw()
{
  //colores
  color_nubes = color(237, 244, 255);//180, 191, 224);  
  color_cielo = color(99, 168, 230); 
  arbol_lejos = color(random(50, 70), 115, random(60, 90));  
  arbol_cerca = color(random(50, 70), 105, random(90, 100));  
  borde_hojas = color(0, 0, 0);
  color_carretera = color(66, 70, 71);

  background(color_cielo);

  //Arboles
  arboles(arbol_cerca, arbol_lejos);  

  //paisaje de fondo
  paisaje();

  //Carretera
  carretera();

  //nubes
  nubes(color_nubes);


  //Pantallas

  if (estado == 0) {
    intro.resize(750, 450);
    image(intro, 0, 125);
  }

  if (estado == 1) {
    //menu_facil.resize(1000,1000);
    image(menu_facil, 0, 0);
  }

  if (estado == 2) {
    image(menu_dificil, 0, 0);
  }

  if (estado == 3) {//juego

    fill(255, 255, 255);
    text(puntaje, 120, 40);
    textAlign(LEFT);
    textSize(20);


    text(contadorMonedas, 330, 45);
    textAlign(LEFT);
    textSize(20);
    tamanoX += 2;
    tamanoY +=2;

    //Otros Carros

    int posActualX = posCarril1X;
    int posActualY = posCarril1Y;
    posCarril1X = posActualX -6;
    posCarril1Y = posActualY +2;

    car1 = new Carro (posCarril1X, posCarril1Y, "car1.png");
    car1.draw(tamanoX, tamanoY, mostrar1);

    autoscarril1 ++;
    if (dist(xplayer, yplayer, car1.x, car1.y)<80) {
      chocar();
      pintarJugador();
    }

    int modc1 = autoscarril1 % 2;


    if (autoscarril1 > 20) {
      int posActualX2 = posCarril2X;
      int posActualY2 = posCarril2Y;
      posCarril2X = posActualX2-2;
      posCarril2Y = posActualY2+4;

      car2 = new Carro (posCarril2X, posCarril2Y, "car2.png");
      car2.draw(tamanoX-10, tamanoY-10, mostrar1);

      if (dist(xplayer, yplayer, car2.x, car2.y)<80) {
        chocar();
      }
    }

    if (autoscarril1 >70) {
      int posActualX3 = posCarril3X;
      int posActualY3 = posCarril3Y;
      posCarril3X = posActualX3+2;
      posCarril3Y = posActualY3+1;
      car3 = new Carro (posCarril3X, posCarril3Y, "car3.png");
      int tamanoX1= tamanoX-200;
      int tamanoY1= tamanoY-200;
      car3.draw(tamanoX1, tamanoY1, mostrar1);
      autoscarril2++;


      if (dist(xplayer, yplayer, car3.x, car3.y)<80) {
        chocar();
      }
    }

    if (posCarril2Y > height+350) {
      posCarril1Y=(int)random(340, 345);
      posCarril2Y= (int)random(340, 345);
      posCarril3Y= (int)random(320, 325);
      posCarril1X=350;
      posCarril2X=360;
      posCarril3X=380;
      tamanoX = 40;
      tamanoY = 40;
      autoscarril1 = 0;
    }



    for (int i=0; i<mon.size(); i++) {

      //Monedas

      Moneda Mn = (Moneda) mon.get(i);
      Mn.display();
      if (dist(xplayer, yplayer, Mn.x, Mn.y)<80) {
        TomarMoneda();
        mon.remove(i);
      }

      if (mon.size() == 0) {
        ReponerMonedas();
      }
    }

    //Vidas Extra

    mod_pts = puntaje%1000;

    if (puntaje != 0 && mod_pts == 0) {
      for (int i=0; i<vid.size(); i++) {
        Corazon Vd = (Corazon) vid.get(i);
        Vd.display();
        if (dist(xplayer, yplayer, Vd.x, Vd.y)<80 && vidasRestantes < 3) {
          RecuperarVidas();
          vid.remove(i);
        }

        if (vid.size() == 0) {
          ReponerCorazones();
        }
      }
    }

    if (vidasRestantes == 3) {
      image(juego, 0, 0);
    } else if (vidasRestantes == 2) {
      image(vidas2, 0, 0);
    } else if (vidasRestantes == 1) {
      image(vidas1, 0, 0);
    } else if (vidasRestantes == 0) {
      estado = 4;
    }

    //pintar jugador

    pintarJugador();
  }

  if (estado == 4) {
    image(game_over, 0, 0);
    Reiniciar();
  }
}


//Métodos

void paisaje()
{

  //Paisaje
  fill(color_cielo);
  beginShape();         //polígono con el color de fondo
  vertex(370, 350);
  vertex(360, 190);
  vertex(440, 190);
  vertex(430, 350);
  endShape();
  noStroke();

  //Sol 
  for (int i =0; i< 10; i++) {
    fill(241, 255, 41, 1+10*i);
    ellipse(width/2, 40, random(45, 55)-3*i, random(45, 55)-3*i);
  }
}

void carretera() 
{

  //Carretera

  fill(color_carretera);
  beginShape(); //polígono de la carretera
  vertex(0, height);
  vertex(0, height-100);
  vertex(370, 350);
  vertex(430, 350);
  vertex(width, height-100);
  vertex(width, height);
  endShape(CLOSE);

  //lineas carretera

  fill(lerpColor(color(color_carretera), color(255, 255, 255), (((millis()/1000)%1==0)?millis()%1000:1000-millis()%1000)/1000.0)); //sincronización de tiempo 1
  beginShape();
  vertex(20, height-100);
  vertex(70, 480);
  vertex(730, 480);
  vertex(width-20, height-100);
  endShape(CLOSE);


  fill(lerpColor(color(color_carretera), color(255, 255, 255), (((millis()/1000)%100==0)?millis()%500:500-millis()%500)/500.0));  //sincronización de tiempo 2
  rect(0, height-50, width, 20);

  fill(lerpColor(color(color_carretera), color(255, 255, 255), (((millis()/1000)%100==0)?millis()%500:500-millis()%500)/500.0));  //sincronización de tiempo 2
  beginShape();
  vertex(140, height-150);
  vertex(265, 400);
  vertex(535, 400);
  vertex(width-140, height-150);
  endShape(CLOSE);

  fill(lerpColor(color(color_carretera), color(255, 255, 255), (((millis()/1000)%1==0)?millis()%1000:1000-millis()%1000)/1000.0)); //sincronización de tiempo 1
  beginShape();
  vertex(320, height-225);
  vertex(365, 355);
  vertex(435, 355);
  vertex(width-320, height-225);
  endShape(CLOSE);


  //Carriles

  //Carril Central
  fill(color_carretera);
  beginShape();
  vertex(200, height);
  vertex(390, 350);
  vertex(410, 350);
  vertex(width-200, height);
  endShape(CLOSE);

  //Carril Izquierdo
  fill(color_carretera);
  beginShape();
  vertex(0, height);
  vertex(0, height-75);
  vertex(377, 350);
  vertex(387, 350);
  vertex(260, height-100);
  vertex(180, height);
  endShape(CLOSE);

  //Carril Derecho
  fill(color_carretera);
  beginShape();
  vertex(width-180, height);
  vertex(413, 350);
  vertex(423, 350);
  vertex(width, height-75);
  vertex(width, height);
  endShape(CLOSE);
}

void nubes(color cNube)
{  
  float begin = random(100);                        //Cambia el tiempo de inicio de cada nueva nueve aleatoriamente.

  float i = 0; 

  for (int x = 0; x < width; x += 2)
  {    
    float j = 0; 

    for (int y = 0; y < height/3; y += 2)
    {     
      float opacMax = map(y, 0, height/3, 520, 0);  //Espacio en que se muestran las nubes
      float opac = noise(begin + i, begin + j);
      opac= map(opac, 0.4, 1, 0, opacMax);          //mapa de la opacidad de las nubes

      noStroke();    
      fill(cNube, opac); 
      ellipse(x, y, 2, 2);

      j += 0.06;                                    //el indice incrementa más rápido para hacer que se formen nubes horizontales
    }

    i += 0.01;
  }
}

void arboles(color cCerca, color cLejos)
{
  float y0 = width - 450;       //altura en la pantalla de la primera línea de arboles
  int i0 = 30;                  //intervalo inicial

  float[] refy = new float[10]; // se inicializa el array de referencia de altura para las demás filas de arboles. 
  for (int j = 0; j < 10; j++)
  {
    refy[9-j] = y0;
    y0 -= i0 / pow(1.2, j);
  }


  //pintar los árboles
  float ref_t = 0; //referencia de tiempo (frame)

  for (int j = 1; j <  10; j++)
  {       
    
   //caracteristicas aleatorias de los arboles 

    float a = random(-width/4, width/4);  
    float b = random(-width/3, width/3);  
    float c = random(5, 7);               
    float d = random(20, 30);             
    float e = random(-width/2, width/2);  

    for (int x = 0; x < width; x ++)
    {          
      float y = refy[j]; 
      y += 10*j*sin(3*ref_t/j + a);   //Fila de árboles más cercana     
      y += c*j*sin(50*ref_t/j + b);   //Fila de árboles en medio 
      y += d*j*noise(5*ref_t/j +e);   //Simulacion hojas
      
    //variaciones hojas y arboles 

      strokeWeight(1.5);                     
      stroke(lerpColor(cCerca, cLejos, j));  
      line(x, y, x, height);                 
      ref_t += 0.02;                         
    }


    //sombras
    for (int i =  height; i > refy[j]; i -= 3)
    {
      float opac = map(i, refy[j], height, 0, 360/(j+1));  //la opacidad es mayor para los árboles en las filas más cercanas. 
      strokeWeight(3);                                     //interval of 3 for faster rendering
      stroke(borde_hojas, opac);                           //añade la sombra entre cada fila de arboles    
      line(0, i, width, i);                                //eje de referencia para la sombra entre líneas
    }
  }
}

void mousePressed() {

  //salir de la pantalla de inicio (se obliga al script a explorar todas estas condiciones para que no salte inmediatamente.)
  if (estado != 3 && estado != 2 && estado != 1 && estado != 4) { 
    estado = 1;
  }
  //coordenadas nueva partida

  int xn = 320;
  int yn = 245;
  int wn = 154;
  int hn = 51;

  //coordenadas boton facil

  int xf = 347;
  int yf = 318;
  int wf = 97;
  int hf = 45;

  //coordenadas boton dificil

  int xd = 347;
  int yd = 375;
  int wd = 97;
  int hd = 41;

  //coordenadas retorno menú

  int xm = 355;
  int ym = 437;
  int wm = 97;
  int hm = 33;

  //Elegir el modo facil
  if (estado != 3 && mouseX>xf && mouseX <xf+wf && mouseY>yf && mouseY <yf+hf) {
    estado = 1;
  }
  //Elegir el modo dificil
  if (estado != 3 && mouseX>xd && mouseX <xd+wd && mouseY>yd && mouseY <yd+hd) {
    estado = 2;
  }
  //Empezar nueva partida
  if (estado != 3 && mouseX>xn && mouseX <xn+wn && mouseY>yn && mouseY <yn+hn) {
    estado = 3;
  }

  //regresar al menú principal después de la pantalla de GameOver.
  if (estado != 3 && mouseX>xm && mouseX <xm+wm && mouseY>ym && mouseY <ym+hm) {
    estado = 1;
  }
}

void chocar() {
  vidasRestantes --;
  xplayer = 350;
  yplayer = 450;
}

void RecuperarVidas() {
  if (vidasRestantes < 3) {
    vidasRestantes ++;
  }
}

void TomarMoneda() {
  contadorMonedas+=10;
  puntaje+=100;
}
void Reiniciar() {

  vidasRestantes = 3;
  contadorMonedas = 0;
  puntaje = 0;
  xplayer = 350;
  yplayer = 450;
  posCarril1X=350;
  posCarril2X=360;
  posCarril3X=380;
  posCarril1Y=(int)random(340, 345);
  posCarril2Y= (int)random(340, 345);
  posCarril3Y= (int)random(320, 325);
  tamanoX = 40;
  tamanoY = 40;
}

void ReponerMonedas() {

  for (int i=0; i<numMonedas; i++) { 
    Moneda M = new Moneda((int)random(150, 600), posMonedasY);
    mon.add(M);
  }
}

void ReponerCorazones() {

  for (int i=0; i<numVidas; i++) { 
    Corazon C = new Corazon((int)random(150, 600), posVidasY);
    vid.add(C);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT && xplayer > 80) {
      xplayer = xplayer - 5;
    } else if (keyCode == RIGHT && xplayer < 580) {  
      xplayer = xplayer + 5;
    }
  }
}


void pintarJugador() {

  image(player, xplayer, random(yplayer-5, yplayer+2), 150, 80);
}
