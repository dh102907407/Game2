class Circle{
int x,y,r;
boolean bg;
boolean enterFrame=false;
  public Circle(int x,int y,int r){
    this.x=x;
    this.y=y;
    this.r=r;
  }
 void display(){
   boolean temp=bg;
    operation();
    if(!temp&&(bg)){
      enterFrame=true;
    }else {
      enterFrame=false;
    }
    noStroke();
    //strokeWeight(1);
    noFill();
    ellipseMode(CENTER); 
    ellipse(x,y,r,r);
  }
 void operation(){
 if(dist(mouseX,mouseY,x,y)<=90){
    bg=true;
    }else{
    bg=false;
    }
 }
}