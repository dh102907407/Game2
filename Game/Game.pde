import ddf.minim.*;
//Using the key "a" and "d" to control the left and right.  The ball will stand ONLY on the plank.
//If you fall, you will die; if you stand on the saw, you will die. 
//There is a layer count in top of the screen. It will increase as you keep moving down.
//The more layer you move, the faster it will be.

//initiate values.
PImage background1,background2;
PImage plank;
PImage introduction;
PImage again;
PImage [] cp=new PImage[5];

float y1=0,y2=800;
float speed=1;
float layer=0;
float vibrateScale=1;
float vibrateScaleSpeed=0.01;

Minim m;
AudioPlayer background;
AudioSnippet burp;
AudioSnippet bubble;


int stage=0;
int character;
int r=0;
int count=0;

PFont myFont;

Plank [] p;
Circle [] c=new Circle[5];
Circle againButton;
Ball b=new Ball(20);

boolean ifOver=false;
boolean ifBall=false;




void setup(){
  
  size(1400,800);
  //load and resize the background picture
  background1=loadImage("img/backgroundTest.jpg");
  background2=background1;
  background1.resize(1400,800);
  background2.resize(1400,800);
  introduction=loadImage("img/Introduction.png");
  again=loadImage("img/AgainButton.png");
  for (int i=0;i<5;i++){
  c[i]=new Circle(220+i*200,625,180);
  }
  againButton=new Circle(1100,600,200);
  cp[0]=loadImage("img/character1.png");
  cp[1]=loadImage("img/character2.png");
  cp[2]=loadImage("img/character3.png");
  cp[3]=loadImage("img/character4.png");
  cp[4]=loadImage("img/character5.png");
  myFont= loadFont("Chiller-Regular-300.vlw");
  m = new Minim(this);
  background = m.loadFile("music/backGroundMusic.mp3");
  burp=m.loadSnippet("music/burp.mp3");
  bubble=m.loadSnippet("music/bubble.mp3");
  background.setGain(-10);
  burp.setGain(15.0);
  //initiate the plank arraylist and ball
  p=new Plank[0];
  //b=new Ball(20);
  frameRate(100);
       background.loop();
}
void draw(){
  background(255);
  //call the function to draw the background
  drawBackground();
  //the function to check if the game is over
  gameOver();
  //draw the first page
  mainPage(); 
  //draw the second page
  if (stage==1){
    //display the number of layers
    displayLayer();
    //control the moving up planks and obstacles
    plankMoving();
  
  }
  //the ball is created when the first planks show up
  if(ifBall){
  b.display();
  }
}



void drawBackground(){
  y1-=speed;
  y2-=speed;
  if (y1<=-800){
  y1+=1600;
  }
  if (y2<=-800){
  y2+=1600;
  }
  pushMatrix();
  translate(0,y1);
  image(background1, 0,0);
  popMatrix();
  pushMatrix();
  translate(0,y2);
  image(background1, 0,0);
  popMatrix();
  
  
}



void plankMoving(){
  //check if the game is over
  if(!ifOver){
  //the value "count" increases for each frame
    count++;
  //when the count reach a certain value(between 50-70),generate the plank
  if(count==60+r){
   int a=(int)random(650,1300);
   if(!ifBall){
   b.x=a+80;
   }
   ifBall=true;
     if(p.length!=0){
    p=(Plank[]) append(p, new Plank(a,(int)random(7))); 
    }else{
    p=(Plank[]) append(p,new Plank(a,2)); 
    
    }
  }  
  if(count==100){
    
    layer+=0.2;
    p=(Plank[]) append(p,new Plank((int)random(650),(int)random(7))); 
      if(p[0].y<0){
        p=(Plank[])reverse(p);
        p=(Plank[])shorten(p);
        p=(Plank[])shorten(p);
        p=(Plank[])reverse(p);
      }
    count=0;
    r=(int)random(-20,20);
  }
  for (int i=0;i<(p.length);i++){
       p[i].move(); 
  }
  }
}
void mainPage(){
  if (stage==0){
    image(introduction, 150,0);  
    for(int i=0;i<5;i++){  
    c[i].display();
    }
    //image(cp[0], 150,550);  
    //image(cp[1], 350,550);  
    //image(cp[2], 550,550);  
    //image(cp[3], 750,550);  
    //image(cp[4], 950,550);  
    for (int i=0;i<5;i++){
      
      if(c[i].enterFrame){
      vibrateScale=1;
      vibrateScaleSpeed=0.01;
       bubble.rewind();
        
      }
      
      
      if(c[i].bg==false){
        image(cp[i], 150+200*i,550);  
        
      }else{
       bubble.play();
        vibration(cp[i],150+200*i , 550);
      
      }
    
    }
  }
}

void gameOver(){
  if(ifOver){
    burp.play();
    stage=2;
    againButton.display();
    fill(#E30B0B);
    textFont(myFont);
    textSize(200);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2);
    ifOver=true;
    for (int i=0;i<p.length;i++){
    p=(Plank[])shorten(p);
    }
      if(againButton.enterFrame){
      vibrateScale=1;
      vibrateScaleSpeed=0.01;
       bubble.rewind();
      }
      if(againButton.bg==false){
        image(again,1000,550);
        
      }else{
       bubble.play();
       vibration(again,1000, 550);
      }
    layer=0;
  }
}

void displayLayer(){
    textFont(myFont);
    textSize(70);
    fill(#555555);
    text("Layer:"+(int)layer,100,100); 
    

}

void mouseClicked(){

  if(stage==0){
       character=5;
    for (int i=0;i<5;i++){
      if(dist(mouseX,mouseY,c[i].x,c[i].y)<90){
        character=i;
        stage++;
      }
    }
 
  if(character!=5){
    b.ball=cp[character];
    b.ball.resize(80,80);
  }
  }
  //judge if the mouse is clicking "again" button
  if(stage==2){
  if (mouseX>1000&mouseX<1200&&mouseY>550&&mouseY<700){
    ifOver=false;
    ifBall=false;
    b=new Ball(20);
    stage=0;
    cp[character]=loadImage("img/character"+(character+1)+".png");
    character=5;
  }
  }
}
  void vibration(PImage p, float x, float y){
    pushMatrix();
    if(vibrateScale<=0.6||vibrateScale>1){
    vibrateScaleSpeed=-vibrateScaleSpeed;
    }
    translate(x+77,y+77);
    scale(vibrateScale-=vibrateScaleSpeed);
    image(p,-77,-77);
    popMatrix();
  }