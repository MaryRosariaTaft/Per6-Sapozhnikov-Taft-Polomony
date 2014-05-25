void setup(){
  
  size(500,500);
  
  //init LL of Squares
  LL<Square> squares=new LL<Square>();
  
  //also have to put text on each Square (the name of that Square/property)
  //and maybe we should find a better way to choose colors than randomizing it like I did...
  //after the other stuff works, at least
  for(int i=0;i<9;i++){
     squares.add(new Square(i*50,0,50,50));
  }
  for(int i=0;i<9;i++){
     squares.add(new Square(450,i*50,50,50)); 
  }
  for(int i=9;i>0;i--){
     squares.add(new Square(i*50,450,50,50));
  }
  for(int i=9;i>0;i--){
     squares.add(new Square(0,i*50,50,50));
  }
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
