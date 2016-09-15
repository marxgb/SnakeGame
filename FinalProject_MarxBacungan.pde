
//variables
import processing.sound.*;
SoundFile backgroundMusic;
//SoundFile eatSound;
Snake snake;
Food food;
int q=0;
int g=14;
int ripple=0;
int l;
int a=25;
int highScore;

//Creates the window size and creates a snake and food
void setup(){
  size(1250,750);
//backgroundMusic= new SoundFile(this, "sound2.WAV");
//eatSound= new SoundFile(this, "eatSound.mp3");
//backgroundMusic.loop();
  snake = new Snake();
  food = new Food();
}
// displays the snake and food as well as adding the changing background
void draw(){
  background(0);
  //backgroundMusic.play();
  food.addFood();
  drawScoreboard();
  drawLine();
  
  frameRate(g);
  snake.move();
  snake.display();
  
  
  //adds to the length of the tail and increases backhground intesity once  a food is eaten/
   if( dist(food.x, food.y, snake.x.get(0), snake.y.get(0)) < snake.bodyLength ){
    //eatSound.play;
    food.newFood();
    snake.addLink();  
    q=+2;
    g=g+1;
    a+=25;
  }
   if(snake.length > highScore){
    highScore= snake.length-1;
  }
  
}
//moethod that changes the background
void drawLine(){
  int r=int(random(0,255));
  int size=int(random(0,a));
  float weight=int(random(2,10));
  float weight1=int(random(5,10));
  int w=int(random(0,1250));
  int w1=int(random(0,1250));
  int h=int(random(0,750));
  for(int s=q; s >0;s--){
  noFill();
  stroke(r);
  strokeWeight(weight1);
  //line(w,h,w,1000);
  ///line(w1,0,w1,h);
  //strokeWeight(weight);
  ellipse(width/2,height/2,size,size);
  }
}
//option 2 for background thats not use.
void drawSquares(){
  
  int[] colors = { 0, 255 };
  int p=int(random(0,2));
  
  float weight=int(random(2,10));
  
  for(int s=q; s >0;s--){
  fill(colors[p]);
  rect(random(width),random(height),250,250);
  }
}
//gets the direction of the key pressed.
void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT || keyCode == 'A'  ){
      snake.direction = "left";
    }
    if(keyCode == RIGHT || keyCode == 'D'){
      snake.direction = "right";
    }
    if(keyCode == UP || keyCode == 'W'){
      snake.direction = "up";
    }
    if(keyCode == DOWN ||keyCode == 'S' ){
      snake.direction = "down";
    }
  }
}


void drawScoreboard(){
   
  // draw scoreboard
  fill(255);
  textSize(17);
  int score=snake.length -1;
  text( "Score: " + score, 70, 50);
   
  fill(255);
  textSize(17);
  text( "High Score: " + highScore, 70, 70);
}
//creates the snake class that has length, bodylength, direction and coordinates.
class Snake{
  int length;
  float bodyLength=17;
  String direction;
  ArrayList <Float> x,y;
  
  Snake(){
    length=1;
    direction="right";
    x= new ArrayList();
    y= new ArrayList();
    x.add(random(width));
    y.add(random(height));
  }
//method that moves the snake at the right direction as well as go from one end of the window out the other end
   void move(){
   for(int n = length - 1; n > 0; n = n -1 ){
    x.set(n, x.get(n - 1));
    y.set(n, y.get(n - 1)); 
   }
   if(direction == "left"){
     x.set(0, x.get(0) - bodyLength);
   }
   if(direction == "right"){
     x.set(0, x.get(0) + bodyLength);
   }
    
   if(direction == "up"){
     y.set(0, y.get(0) - bodyLength);
   
   }
  if(direction == "down"){
     y.set(0, y.get(0) + bodyLength);
   }
   x.set(0, (x.get(0) + width) % width);
   y.set(0, (y.get(0) + height) % height);
   
   
     if( checkHit() == true){
      length = 1;
      float xtemp = x.get(0);
      float ytemp = y.get(0);
      x.clear();
      y.clear();
      x.add(xtemp);
      y.add(ytemp);
                            } 
    
   }
   
//method that displays the snake.
    void display(){
    for(int n = 0; n <length; n++){
      
      stroke(179, 140, 198);
      strokeWeight(1);
      fill(155, 0, 0, map(n-1, 0, length-1, 250, 50));
      ellipse(x.get(n), y.get(n), bodyLength, bodyLength);
    } 
   }
   
//method that extends the snake whenever he gets food.
  void addLink(){
    x.add( x.get(length-1) + bodyLength);
    y.add( y.get(length-1) + bodyLength);
    length++;
  }


//method that checks if the snake ate himself.
  boolean checkHit(){
    for(int i = 1; i < length; i++){
     if( dist(x.get(0), y.get(0), x.get(i), y.get(i)) < bodyLength){
       g=14;
       q=0;
       a=25;
       return true;
     }
    }
    return false;
   }
}



 
 
class Food{
  float x,y;
  
  Food(){
    x=random(100, width-100);
    y=random(100, height-100);
  }
    
  void addFood(){
    int b=int(random(0,255));
    int n=int(random(0,255));
    int m=int(random(0,255));
    fill(b,n,m);
    ellipse(x,y,15,15);
}

  void newFood(){
    x=random(100, width-100);
    y=random(100, height-100);
  }
}