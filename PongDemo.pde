int state = 0;
final int MENU = 0;
final int SP = 1;
final int MP = 2;
final int GAMEOVER = 3;
boolean UP1 = false;
boolean UP2 = false; 
boolean DOWN1 = false;
boolean DOWN2 = false;
Player p1;
Player p2;
Player s;
Computer ai;
Ball b;

void setup() {
  size(800, 600);
  p1 = new Player(15, 300);
  p2 = new Player(780, 300);
  b = new Ball();
}

void draw() {
  
  switch (state) {
    case MENU:
      mainMenu();
    break;
    case GAMEPLAY:
      multiPlayer(); 
        
      p1.paddle();
      p2.paddle();
                        
      if (UP1 == true) {
        p1.moveUP();
      }
      if (DOWN1 == true) {
        p1.moveDOWN();
      }
      if (UP2 == true) {
        p2.moveUP();
      }
      if (DOWN2 == true) {
        p2.moveDOWN();
      }
      
      b.ball();
                
  }
    
}

void mainMenu () {
  
  background(0, 255, 0);
  noFill();
  stroke(255);
  strokeWeight(10);
  rect(5, 5, 790, 590);
  stroke(255);
  strokeWeight(10);
  line(400, 10, 400, 595);  
  
  textSize(30);
  fill(1);
  textAlign(CENTER);
  text("Pong", 400, 250);
 
  
  fill(255, 0, 0);
  textSize(18);
  textAlign(CENTER);
  text("UP to play", 400, 325);
    
}

void keyPressed () {
  
  switch (this.state) {
    case MENU:
    if (key == CODED){
      if (keyCode == UP) {
        state = GAMEPLAY;
        multiPlayer();
      }
    }
    break;
    case GAMEPLAY:
      if (keyCode == UP && p1.posY >= 0) {
        UP1 = true;
      }
      if (keyCode == DOWN && p1.posY <= 560) {
        DOWN1 = true;
      }
      if (key == 'w' && p2.posY >= 0) {
        UP2 = true;
      }
      if (key == 's' && p2.posY <= 560) {
        DOWN2 = true;
      }
    break;
  
  }
}

void keyReleased () {
  if (keyCode == UP && p1.posY >= 0) {
        UP1 = false;
      }
      if (keyCode == DOWN && p1.posY <= 560) {
        DOWN1 = false;
      }
      if (key == 'w' && p2.posY >= 0) {
        UP2 = false;
      }
      if (key == 's' && p2.posY <= 560) {
        DOWN2 = false;
      }
}

void multiPlayer () {
  background(0, 255, 0);
  noFill();
  stroke(255);
  strokeWeight(10);
  rect(5, 5, 790, 590);
  stroke(255);
  strokeWeight(10);
  line(400, 10, 400, 595);  
       
}

void gameOver () {
  
}

class Paddle { //paddle class.
  float posX, posY;
  
  Paddle (float x, float y) {
    posX = x;
    posY = y;
  }
  
  void moveUP() {
    this.posY -= 3;
  }
  
  void moveDOWN() {
    this.posY += 3;
  }
  
  void paddle () {
    noStroke();
    fill(100);
    rect(this.posX, this.posY, 7, 40);
  }
    
}

class Ball { //ball class;
  float x, y, rad, speedx, speedy;
  
  
  Ball () {
    x = 400;
    y = 300;
    rad = 5;
    speedx = 0;
    speedy = 0;
  }
  
  void moveBall() { //movement of ball.
  }
  
  void bounceBall() {
  }
  
  void ball () {
    fill(100);
    ellipse(x, y, 2*rad, 2*rad);
    
  }
  
}

class Player extends Paddle { //inherits paddle
  
  Player(float x, float y) {
    super(x, y);
  }
}

class Computer extends Paddle { //inherits paddle);
  Computer(float x, float y) {
    super(x, y);
  }
}
