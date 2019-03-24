int state = 0;
final int MENU = 0;
final int GAMEPLAY = 1;
final int GAMEOVER = 2;
boolean 
hit = false,
left = false,
right = false;
Paddle p;
Ball b;
ArrayList <Bricks> bricks; //10 columns x 10 rows
int lives, score;
boolean win;
PImage backChicken;

void setup () {
  size(800, 600);
  p = new Paddle();
  b = new Ball();
  
  bricks = new ArrayList <Bricks>();
  
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 8; x++) {
            
      float fy = float(y*20);
      float fx = float(x*100);
      float red = random(255);
      float green = random(255);
      float blue = random(255);
      
      bricks.add(new Bricks(fx, fy, red, green, blue));
    }  
  }
  lives = 3;
  score = 0;
  win = false;
  backChicken = loadImage("C:\\Users\\WarIsManHero\\Documents\\Processing\\BreakoutDemo\\deepfried_1553404824445.png");
}

void draw () {
  switch (state) {
    case MENU:
    mainMenu();
    break;
    case GAMEPLAY:
      gamePlay();
      p.paddle();
      b.ball();
      b.move();
      
      
      for (int i = 0; i < bricks.size(); i++) {
        bricks.get(i).brick();
      }
      
      b.bounce();
          
      if (left == true && p.x >= 25){
        p.moveLEFT();
      }
      else if (right == true && p.x <= 775){
        p.moveRIGHT();
      }
          
      stats();
    break;
    case GAMEOVER:
      gameOver();
    break;
  }
  
  
}

void keyPressed() {
  switch (this.state) {
    case MENU:
      if (key == 'w'){
        state = GAMEPLAY;
      }
    break;
    case GAMEPLAY:
      if (key == 'a') {
        left = true;
      }
      else if (key == 'd') {
        right = true;
      }
    break;
    case GAMEOVER:
     if (key == 's') {
       setup();
       state = GAMEPLAY;
     }
     else if (key == ESC) {
       exit();
     }
    break;
  }
}

void stats () {
  textSize(16);
  fill(255);
  text("Lives: " + lives, 50, 580);
  text("Score: " + score, 750, 580);
  
  if (lives == 0) {
    state = GAMEOVER;
  }
  
  if (score == 64) {
    win = true;
    state = GAMEOVER;
  }
}

void keyReleased() {
  if (key == 'a') {
      left = false;
    }
    else if (key == 'd') {
      right = false;
    }
}

void mainMenu() {
  background(0);
  
  textSize(36);
  textAlign(CENTER);
  text("Breakout", 400, 300);
  
  textSize(14);
  textAlign(CENTER);
  text("'w' to start", 400, 350);
}

void gamePlay() {
  background(0);
    
}

void gameOver() {
  
 if (win == true) {
    background(backChicken);
    textSize(40);
    textAlign(CENTER);
    text("WINNER WINNER CHICKEN DINNER", 400, 300);
    
    textSize(16);
    text("'s' to replay", 400, 350);
    text("'ESC' to exit", 400, 375);
    
  }
  else if (win == false) {
    background(0);
    
    textSize(40);
    textAlign(CENTER);
    text("GAME OVER", 400, 300);
    
    textSize(16);
    text("'s' to replay", 400, 350);
    text("'ESC' to exit", 400, 375);
 
 }
  
}

class Paddle {
  
  float x;
  final float   
  y = 550, 
  w = 45,
  h = 5;
  
  Paddle() {
    this.x = 400;
  }
  
  void moveLEFT() {
    this.x -= 5;
  }
  
  void moveRIGHT() {
    this.x += 5;
  }
  
  void paddle() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(this.x, this.y, this.w, this.h);
  }
  
}

class Ball {
  
  float x, y, speedX, speedY, angle, directionX, directionY;
  final float rad;
  
  Ball () {
    this.directionX = 1;
    this.directionY = 1;
    this.x = 400;
    this.y = 540;
    this.speedX = 4;
    this.speedY = -3.5;
    rad = 5;
  }
  
  void bounce () {
     
    if (this.x < rad || this.x > 800-rad) {
      this.directionX *= -1;
    }
    if (this.y < rad) {
      this.directionY *= -1;
    }
    if (this.x+rad > p.x-p.w/2 && this.x-rad < p.x+p.w/2 && this.y+rad > p.y-p.h/2 && this.y+rad < p.y+p.h/2) {
      this.directionY *= -1;
    }
    
    //change directions when collision with bricks.
    for (int i = 0; i < bricks.size(); i++) {
      if (this.x+rad > bricks.get(i).x && this.x+rad < bricks.get(i).x+bricks.get(i).w && this.y+rad < bricks.get(i).y+bricks.get(i).h) {
        this.directionY *= -1;
        this.speedX += 0.45;
        this.speedY -= 0.2;
        bricks.remove(i);
        score++;
      }
      
    }
    
    if (this.y > 800) {
      this.x = 400;
      this.y = 540;
      p.x = 400;
      lives--;
    }
        
  }
  
  void move () {
        
    x += (speedX*this.directionX);
    y += (speedY*this.directionY);
  }
    
  void ball () {
        
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(x, y, 2*rad, 2*rad);
  }
  
}

class Bricks {
  
  float 
  x, y;
  final float
  w, h;
  boolean hit;
  float red, green, blue;
  
  Bricks (float x, float y, float red, float green, float blue) {
    w = 100;
    h = 20; 
    this.x = x;
    this.y = y;
    hit = false;
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  
  void brick () {
    stroke(255);
    fill(this.red, this.green, this.blue);
    rectMode(CORNER);
    rect(this.x, this.y, this.w, this.h);
  }
  
}
