class Plank{
int x;
int y;
int xdist=0;
int xdistPlus=1;
PImage picture;

int type;
AudioSnippet sound;

public Plank(int x,int type){
  
  this.type=type;
  switch(type) {
    case 0: 
      picture=loadImage("img/plank1.png");
      sound=m.loadSnippet("music/ground.mp3");
      break;
    case 1: 
      picture=loadImage("img/saw.png");
      break;
    case 2: 
      picture=loadImage("img/plank3.png");
      sound=m.loadSnippet("music/ground.mp3");
      break;
    case 3: 
      picture=loadImage("img/plank2.png");
      sound=m.loadSnippet("music/ground.mp3");
      break;
    case 4: 
      picture=loadImage("img/spring.png");
      sound=m.loadSnippet("music/spring.mp3");
      break;
    case 5: 
      picture=loadImage("img/ice.png");
      sound=m.loadSnippet("music/ice.mp3");
      break;
    case 6: 
      picture=loadImage("img/grass.png");
      sound=m.loadSnippet("music/grass.mp3");
      break;
  }


  picture.resize(200,30);
  this.x=x;
  y=800;
}

void move(){
  if(type==3){
     if(xdist==70){
       xdistPlus=-xdistPlus;
    }
    if(xdist==-70){
       xdistPlus=-xdistPlus;
    }
      xdist+=xdistPlus;
      image(picture, x+=xdistPlus, y-=speed);
  } else{
  image(picture, x, y-=speed);
  }
  if(type==4){
    if(!sound.isPlaying()){
        sound.rewind();
    }
 }
  
 
 
}
}