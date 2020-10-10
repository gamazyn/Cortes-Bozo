//Libs
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import java.util.*;
import processing.video.*;    
import ddf.minim.*;
import ddf.minim.effects.*;

//objs Kinect e Audio
KinectTracker tracker;
Kinect kinect;
Minim minim;
AudioPlayer bgm;

//quadrado variaveis de controle
int lin = 4;
int col = 4;
int quadLarg = 135;
int quadAlt = 120;
int lives = 13;

//imgens
String[] imgstr = {"image.PNG", "bozo1.PNG", "image2.PNG", "image3.PNG", "image4.PNG", "image1.PNG", "image5.PNG", "image6.PNG", 
  "image7.PNG", "image8.PNG", "image9.PNG", "bozo1.PNG", "image10.PNG", "image11.PNG", "image12.PNG", "image13.PNG", 
  "image14.PNG", "image15.PNG", "bozo1.PNG", "image16.PNG", "image17.PNG", "image18.PNG", "image19.PNG", "image20.PNG", 
  "image21.PNG", "image22.PNG", "image23.PNG", "image24.PNG", "image25.PNG", "bozo1.PNG", "image26.PNG", "image27.PNG", 
  "image28.PNG", "bozo_gameover.PNG"};
Movie videos[];

//obj quadrado
List<Quadrado> quads;
void setup() {
  size(640, 520);

  //noCursor(); //Remove o cursor do mouse, mas mantém a funcionalidade
  minim = new Minim(this);
  bgm = minim.loadFile("bozoaudio2.mp3", 2048);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  videos = new Movie[2];

  videos[0] = (new Movie (this, "bozo_audio.mov"));
  videos[1] = (new Movie (this, "bozo_gameover.mov"));
  
  bgm.loop();
  videos[1].loop();
  quads = new ArrayList<Quadrado>();
  for (int y = 1; y <= lin; ++y) {
    for (int x = 1; x <= col; ++x) {

      int posX = (x * (quadLarg + 20)) - (quadLarg/2);//Aqui oq ta sendo feito é o mesmo processo do for anterior só que eu uso a subtração pra chegar o objeto pra mais perto da borda
      int posY = (y * (quadAlt + 10))- (quadAlt/2);//da tela e calculo a distancia da margem também. Agora independente do tamanho do objeto ele vai fazer uma matriz sempre proporcional

      quads.add(new Quadrado (posX, posY, quadLarg, quadAlt)); //Isso foi reajustado com base no centro também!!
    }
  }
}

void movieEvent (Movie videos) {
  videos.read();
}

void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();

  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(0, 0, 0, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);

  //quadrados
  for (Quadrado q : quads) {
    q.draw();
    //q.collision(int(v1.x), int(v1.y));//Converte os valores float do kinect em int e utiliza eles como posição de cursor
    q.collision(mouseX, mouseY); //Utiliza o mouse para checar posição de colisão também! Bom pra debug
  }
  for (Quadrado q : quads) {
    if (q.getCollisioned()) {
      q.showImage();
    }
  }    

  // Show the image
  tracker.display();
  
  textSize(22);
  text ("Vidas: " + lives, 20, 20);
}


// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}
