class Quadrado {
  float x;
  float y;
  float quadLarg;
  float quadAlt;
  color cor = color(255, 0, 0); //A cor precisa ser definida numa variavel para que quando você fizer a colisão salve a nova cor e no frame seguinte ela seja executada
  boolean collisioned = false;
  int r;

  Quadrado(int x, int y, float quadLarg, float quadAlt) {
    this.x = x;
    this.y = y;
    this.quadLarg = quadLarg;
    this.quadAlt = quadAlt;
  }

  void draw() {
    noFill();//O fill precisa ser definido na função de draw() do objeto, assim ele não altera a estrutura de outros pontos do código
    rectMode(CENTER);//Voce teve problemas pra desenhar os quadrados porque o rectMode não estava definido no centro, então ele tava desenhando pela ponta superior esquerda.
    //Com o rectMode(CENTER) você agora desenha e calcula tudo com base no centro do quadrado.

    rect(this.x, this.y, quadLarg, quadAlt);

    //println(this.x + " " +this.y + " " + quadLarg + " " + quadAlt);
  }

  //Aqui na função colisão você verifica se houve colisão e salva na variavel collisioned se houve ou não, para exibir a imagem guardada nesse objeto
  void collision(int trackerposX, int trackerposY) { //Aqui você faz a troca do valor da variavel cor, pra que quando a função draw() do objeto for executada ele fique vermelho.
    //A colisão precisa ser feita com base no "raio" do quadrado e não o "diametro", se a largura é 150, então o mouse vai estar entre x + 75 ou x - 75. O mesmo pra altura.
    if (trackerposX > (this.x - (quadLarg/2)) && trackerposX < (this.x + (quadLarg/2)) && 
      trackerposY > (this.y - (quadAlt/2)) && trackerposY < (this.y + (quadAlt/2))) {
      collisioned = true;
    } else {
      collisioned = false;
      r = int (random(0, imgstr.length-1));
    }
  }

  boolean getCollisioned() {
    return collisioned;
  }

  //Essa função verifica se a variavel que salva a informação da colisão esta verdadeira e cria a imagem na tela
  void showImage() {
    tint(255, 255);
    PImage img = loadImage(imgstr[r]);
    if (r == 1 || r == 11 || r == 18 || r == 29){
      lives--;
    }
    image(img, 0, 0, width, height);
    
    if (lives <= 0)
      image(videos[1], 0, 0);
      
    println(lives);
  }
}
