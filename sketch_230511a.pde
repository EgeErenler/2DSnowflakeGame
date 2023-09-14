import java.util.ArrayList;

ArrayList<SnowFlake> s = new ArrayList<SnowFlake>();
int score = 0;
boolean gameOver = false;

void setup() {
  fullScreen();
  strokeWeight(0.5);
  for (int i = 0; i < 20; i++) {
    s.add(new SnowFlake());
  }
}

void draw() {
  background(0);
  for (int i = 0; i < s.size(); i++) {
    s.get(i).drawSnowFlake();
  }
  
  fill(255, 0, 0, 50);
  ellipse(mouseX, mouseY, 30, 30);
  
  if (!gameOver && mousePressed) {
    for (int i = s.size() - 1; i >= 0; i--) {
      SnowFlake snowflake = s.get(i);
   if (snowflake.c != color(0) && snowflake.c != color(255) && dist(mouseX, mouseY, snowflake.x, snowflake.y) < 10) {
     s.remove(i);
       score++;
         break;
      }
    }
  }
  
  boolean allWhite = true;
  for (int i = 0; i < s.size(); i++) {
    if (s.get(i).c != color(255)) {
      allWhite = false;
      break;
    }
  }
  
  if (allWhite) {
    gameOver = true;
    textAlign(CENTER);
    textSize(32);
    fill(255);
    text("NO MORE FLAKES TO SHOOT", width / 2, height / 2);
    textSize(24);
    text("Press ENTER to play again", width / 2, height / 2 + 40);
  }
  
  textAlign(LEFT);
  textSize(24);
  fill(255);
  text("Score: " + score, 10, 30);
}

void keyPressed() {
  if (gameOver && keyCode == ENTER) {
    resetGame();
  }
}

void resetGame() {
  score = 0;
  s.clear();
  for (int i = 0; i < 20; i++) {
    s.add(new SnowFlake());
  }
  gameOver = false;
}

class SnowFlake {
  float x, y, s, speed;
  color c;
  int round = 0;
  int rotationDir;
  int boundaryCount;

  SnowFlake() {
    randomize();
    rotationDir = (int) random(-1, 2);
  }

  void randomize() {
    y = random(0, height);
    x = random(0, width);
    s = random(3, 10);
    c = color(random(255), random(255), random(255));
    speed = random(1, 5);
    boundaryCount = 0;
  }

  void drawSnowFlake() {
    stroke(c, 100);
    pushMatrix();
    translate(x, y);
    rotate(radians(frameCount * rotationDir));
    for (int i = 0; i < 6; i++) {
      rotate(radians(60));
      pushMatrix();
      scale(s);
      drawVertices();
      scale(1, -1);
      drawVertices();
      popMatrix();
    }
    popMatrix();

    y += speed;
    if (y > height + 50 || y < -50 || x > width + 50 || x < -50) {
      randomize();
      y = -50;
      round++;
      if (round > 3) {
        c = color(255);
      }
    }
    
    if (y > height || y < 0 || x > width || x < 0) {
      boundaryCount++;
      if (boundaryCount > 2) {
        c = color(255);
      }
    }
  }

  void drawVertices() {
    beginShape();
    vertex(0, 0.2);
    vertex(2, 0.2);
    vertex(3, 1.7);
    vertex(3.5, 1.7);
    vertex(2.5, 0.2);
    vertex(4,0, 0.2);
    
    vertex(4.8, 1.2);
    vertex(5.3, 1.2);
    vertex(4.3, 0.2);
  
    vertex(6.0, 0.2);
    vertex(6.0, 0);
    endShape(CLOSE);
  }
}
