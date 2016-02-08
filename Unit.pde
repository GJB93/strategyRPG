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

  /*
    Main constructor for the Unit class. Sets the name according to the
   gender chosen and sets the stats according to the stats passed to
   the constructor
   */
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
    statcardHeight = height*0.15f;
    statcardYinc = 12;
    statcardXinc = 12;
  }

  /*
    Constructor used for creating a specified unit
   */
  Unit(String fname, String sname, char gender, int str, int dex, int mag)
  {
    this.fname = fname;
    this.sname = sname;
    this.gender = gender;
    this.goAgain = false;
    this.hasMoved = true;
    this.stats = new Stats(str, dex, mag);
  }

  /*
    Draw unit method to be implemented by subclasses
   */
  void drawUnit(float x, float y, float w, float h, boolean side)
  {
  }

  /*
    Draw unit method that the subclasses will call in order to
   draw themselves
   */
  void drawUnit(float x, float y, float w, float h, boolean side, color c)
  {
    fill(c);
    noStroke();
    if (side)
    {
      rectMode(CENTER);
      rect(x, y, w, h);
    } else
    {
      ellipseMode(CENTER);
      ellipse(x, y, w, h);
    }
  }

  /*
    Attack method calculates the amount of HP to be taken
   from a targeted unit, given a defense value. There is
   also a chance for the attack to 'critically strike'
   which increases damage dealt. To be implemented by
   each subclass according to the unit's affinity
   */
  void attack(Unit unit)
  {
  }

  /*
    Defend method rolls a dice to check if the unit will
   dodge the attack. If not, a ratio is calculated based
   on the unit's defense value
   */
  float defend()
  {
    int dice = int(random(1, 100));
    println(this.stats.eva);
    println(this.stats.def);
    if (dice <= this.stats.eva)
    {
      return 1.0f;
    } else
    {
      float ratio = map(this.stats.def, 0, 100, 0, 1);
      return ratio;
    }
  }

  /*
    Each unit type has an ability unique to
   that unit type
   */
  void ability(Unit unit)
  {
  }

  /*
    Method to set that the unit has moved
   */
  void unitMoved()
  {
    hasMoved = true;
  }

  /*
    Method to reset the unit's move state
   */
  void resetMoveState()
  {
    hasMoved = false;
  }

  /*
    Loads a list of 100 male names and loads the names
   into an ArrayList. Used to name units
   */
  void loadMaleNames()
  {
    String filename = "malenames.txt";
    String[] lines = loadStrings(filename);
    maleNames = new ArrayList<String>();
    for (String s : lines)
    {
      this.maleNames.add(s);
    }
  }

  /*
    Loads a list of 100 female names and loads the names
   into an ArrayList. Used to name units
   */
  void loadFemaleNames()
  {
    String filename = "femalenames.txt";
    String[] lines = loadStrings(filename);

    femaleNames = new ArrayList<String>();
    for (String s : lines)
    {
      this.femaleNames.add(s);
    }
  }

  /*
    Loads a list of 100 male names and loads the names
   into an ArrayList. Used to name units
   */
  void loadSurnames()
  {
    String filename = "surnames.txt";
    String[] lines = loadStrings(filename);

    surnames = new ArrayList<String>();
    for (String s : lines)
    {
      this.surnames.add(s);
    }
  }

  /*
    Draws a statcard for the unit, showing the unit's
   name, gender, stats and type
   */
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