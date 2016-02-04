abstract class Unit
{
  PImage sprite;
  ArrayList<String> maleNames;
  ArrayList<String> femaleNames;
  ArrayList<String> surnames;
  color c;
  String fname;
  String sname;
  String type;
  char gender;
  int range;
  int moveRange;
  int lastDamageValue;
  float statcardWidth;
  float statcardHeight;
  float statcardYinc;
  float statcardXinc;
  boolean goAgain;
  boolean hasMoved;
  boolean criticallyHit;
  Stats stats;
  
  Unit()
  {
    this(new Stats());
  }
  
  Unit(Stats stats)
  {
    loadMaleNames();
    loadFemaleNames();
    loadSurnames();
    this.goAgain = false;
    this.hasMoved = true;
    
    int genderChoice = int(random(2));
    
    switch(genderChoice)
    {
      case 0:
      {
        this.fname = maleNames.get(int(random(maleNames.size())));
        this.sname = surnames.get(int(random(surnames.size())));
        this.gender = 'M';
        break;
      }
      
      case 1:
      {
        this.fname = femaleNames.get(int(random(femaleNames.size())));
        this.sname = surnames.get(int(random(surnames.size())));
        this.gender = 'F';
        break;
      }
      
      default:
      {
        println("Error in name creation");
        break;
      }
    }//end switch
    
    this.stats = stats;
    statcardWidth = width*0.25f;
    statcardHeight = width*0.15f;
    statcardYinc = 12;
    statcardXinc = 12;
  }
  
  Unit(String fname, String sname, char gender, int str, int dex, int mag)
  {
    this.fname = fname;
    this.sname = sname;
    this.gender = gender;
    this.goAgain = false;
    this.hasMoved = true;
    this.stats = new Stats(str, dex, mag);
  }
  
  void drawUnit(float x, float y, float w, float h, boolean side)
  {
    //this.drawUnit(x, y, w, h, side, color(0));
  }
  
  void drawUnit(float x, float y, float w, float h, boolean side, color c)
  {
    fill(c);
    noStroke();
    if(side)
    {
      rectMode(CENTER);
      rect(x, y, w, h);
    }
    else
    {
      ellipseMode(CENTER);
      ellipse(x, y, w, h);
    }
  }
  
  void loadMaleNames()
  {
    String filename = "malenames.txt";
    String[] lines = loadStrings(filename);
    maleNames = new ArrayList<String>();
    for(String s:lines)
    {
      this.maleNames.add(s);
    }
  }
  
  void attack(Unit unit)
  {
    
  }
  
  float defend()
  {
    return 0;
  }
  
  void ability(Unit unit)
  {
    
  }
  
  void unitMoved()
  {
    hasMoved = true;
  }
  
  void resetMoveState()
  {
    hasMoved = false;
  }
  
  void loadFemaleNames()
  {
    String filename = "femalenames.txt";
    String[] lines = loadStrings(filename);
    
    femaleNames = new ArrayList<String>();
    for(String s:lines)
    {
      this.femaleNames.add(s);
    }
  }
  
  void loadSurnames()
  {
    String filename = "surnames.txt";
    String[] lines = loadStrings(filename);
    
    surnames = new ArrayList<String>();
    for(String s:lines)
    {
      this.surnames.add(s);
    }
  }
  
  void statCard(float x, float y)
  {
    rectMode(CORNER);
    textAlign(LEFT, CENTER);
    textSize(11);
    noStroke();
    fill(255, 100);
    rect(x, y, statcardWidth, statcardHeight);
    fill(0);
    text(fname + " " + sname, x+statcardXinc, y+statcardYinc*1);
    text(gender, x+statcardXinc, y+statcardYinc*2);
    text("STR: " + stats.str, x+statcardXinc, y+statcardYinc*3);
    text("DEX: " + stats.dex, x+statcardXinc, y+statcardYinc*4);
    text("MAG: " + stats.mag, x+statcardXinc, y+statcardYinc*5);
  }
}