class Unit
{
  ArrayList<String> maleNames;
  ArrayList<String> femaleNames;
  ArrayList<String> surnames;
  String fname;
  String sname;
  char gender;
  int range;
  Stats stats;
  
  Unit()
  {
    loadMaleNames();
    loadFemaleNames();
    loadSurnames();
    
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
  }
  
  Unit(Stats stats)
  {
    loadMaleNames();
    loadFemaleNames();
    loadSurnames();
    
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
    this.fname = fname;
    this.sname = sname;
    this.gender = gender;
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