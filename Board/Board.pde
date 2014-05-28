//workaround for LL of colors
class myColor{
  private color c;
  public myColor(color c){
    this.c=c;
  }
  public color getColor(){
    return c;
  }
}

void setup(){
  
  size(550,550);
  
  //init LL of Squares
  LL<Square> squares=new LL<Square>();
  
  //also have to put text on each Square (the name of that Square/property)
  //and maybe we should find a better way to choose colors than randomizing it like I did...
  //after the other stuff works, at least
  myColor other = new myColor(#FFFFFF);
  myColor rr = new myColor(#000000);
  myColor brown = new myColor(#8B4513);
  myColor cyan = new myColor(#00FFFF);
  myColor magenta = new myColor(#FF00FF);
  myColor orange = new myColor(#FFA500);
  myColor red = new myColor(#FF0000);
  myColor gold = new myColor(#FFD700);
  myColor green = new myColor(#008000);
  myColor blue = new myColor(#0000FF);
  LL<myColor> colors = new LL<myColor>();
  colors.add(other);
  colors.add(brown);
  colors.add(other);
  colors.add(brown);
  colors.add(other);
  colors.add(rr);
  colors.add(cyan);
  colors.add(other);
  colors.add(cyan);
  colors.add(cyan);
  colors.add(other);
  colors.add(magenta);
  colors.add(other);
  colors.add(magenta);
  colors.add(magenta);
  colors.add(rr);
  colors.add(orange);
  colors.add(other);
  colors.add(orange);
  colors.add(orange);
  colors.add(other);
  colors.add(red);
  colors.add(other);
  colors.add(red);
  colors.add(red);
  colors.add(rr);
  colors.add(gold);
  colors.add(gold);
  colors.add(other);
  colors.add(gold);
  colors.add(other);
  colors.add(green);
  colors.add(green);
  colors.add(other);
  colors.add(green);
  colors.add(rr);
  colors.add(blue);
  colors.add(other);
  colors.add(blue);
  colors.forward();
  
  color c;
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     squares.add(new Square(i*50,500,50,50,c));
  }
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     squares.add(new Square(0,i*50,50,50,c));
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     squares.add(new Square(i*50,0,50,50,c));
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     squares.add(new Square(500,i*50,50,50,c)); 
  }
//  for(int i=10;i>0;i--){
//     c = colors.getCurrent().getColor();
//     colors.forward();
//     squares.add(new Square(i*50,500,50,50,c));
//  }
//  for(int i=10;i>0;i--){
//     c = colors.getCurrent().getColor();
//     colors.forward();
//     squares.add(new Square(0,i*50,50,50,c));
//  }
  //set current at starting point again
  squares.forward();
  
  // test
  //while(squares.getLength()>1)
  //  squares.removeAndMoveBack();
  // squares.add(new Square (200,200,60,57));
  // yay, it worked
  
  // draw border
  for(int i=0;i<squares.getLength();i++){
    squares.getCurrent().draw();
    squares.forward();
  }
  
  //init 2 LLs of Cards, print rectangles with access to top cards
  LL<Card> deck1=new LL<Card>();
  LL<Card> deck2=new LL<Card>();
  
  //init [LL of] Persons
  //still testing
  //if every Person shares the same instance of squares
  //(since they have to see what information is contained in each Square)
  //we have to set the squares.current to that Person's own position:
  //meaning, we have to have each person keep track of which Square he's on
  //we'd have to search through squares for that particular Square each turn
  //but it's not too much an issue, since we have a limited number of Squares in squares (the LL)
  //so Person can have an instance variable to keep track of which Square he's on at the end of each turn
  //does that work?
  //or did you have something else in mind?
  //(I didn't edit that in the Person class [yet, in case you do disagree])
  
  LL<Person> players=new LL<Person>();
  players.add(new Person("Bob",squares));
  
  //init&draw dice
  //P.S. can't put a draw() method in the Die class if it's static
  
}
