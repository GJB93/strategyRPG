class Unit
{
  final int uniqueId;
  ArrayList<String> maleNames;
  ArrayList<String> femaleNames;
  ArrayList<String> surnames;
  String fname;
  String sname;
  String type;
  char gender;
  int range;
  int moveRange;
  boolean alive;
  boolean goAgain;
  Stats stats;
  PVector currentPos;
  
  Unit()
  {
    uniqueId = int(random(Integer.MAX_VALUE));
    loadMaleNames();
    loadFemaleNames();
    loadSurnames();
    this.goAgain = false;
    
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
    
    this.stats = new Stats();
    this.currentPos = new PVector();
  }
  
  Unit(Stats stats)
  {
    uniqueId = int(random(Integer.MAX_VALUE));
    loadMaleNames();
    loadFemaleNames();
    loadSurnames();
    this.goAgain = false;
    
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
  }
  
  Unit(String fname, String sname, char gender, int str, int dex, int mag)
  {
    uniqueId = int(random(Integer.MAX_VALUE));
    this.fname = fname;
    this.sname = sname;
    this.gender = gender;
    this.goAgain = false;
    this.stats = new Stats(str, dex, mag);
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
  
  void move(int x, int y)
  {
    currentPos.set(x, y);
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
}