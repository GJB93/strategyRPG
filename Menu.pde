class Menu
{
  float menuWidth;
  float menuHeight;
  float borderX;
  float borderY;
  float middleX;
  float yPos;
  PVector position;
  ArrayList<Option> options;
  color menuColor;
  color optionColor;
  float middleColorValue;
  int lightenValue;
  String gameTitle;
  
  Menu()
  {
    this(0, 0, 0, 0, color(0), "");
  }
  
  Menu(float w, float h, float x, float y, color c, String title)
  {
    lightenValue = 50;
    menuWidth = w;
    menuHeight = h;
    middleX = menuWidth*0.5f;
    yPos = menuHeight*0.05f;
    middleColorValue = (256*0.5f)*3;
    menuColor = c;
    gameTitle = title;
    float redValue = red(c)+lightenValue;
    float greenValue = green(c)+lightenValue;
    float blueValue = blue(c)+lightenValue;
    optionColor = color(redValue%256, greenValue%256, blueValue%256);
    borderX = menuWidth*0.1f;
    borderY = menuHeight*0.1f;
    position = new PVector(x, y);
    options = new ArrayList<Option>();
  }
  
  void render()
  {
    noStroke();
    fill(menuColor);
    rect(position.x, position.y, menuWidth, menuHeight);
    setOptionDimensions();
    for(Option option: options)
    {
      option.render();
    }
    
    color textColor;
    if(red(menuColor)+green(menuColor)+blue(menuColor) > middleColorValue)
    {
      textColor = color(0);
    }
    else
    {
      textColor = color(255);
    }
    textAlign(CENTER, CENTER);
    textSize(22);
    fill(textColor);
    text(gameTitle, position.x+middleX, position.y+yPos);
  }
  
  void addOption(String optionText)
  {
    options.add(new Option(optionText, optionColor));
  }
  
  void setOptionDimensions()
  {
    float optionWidth = menuWidth - (borderX*2);
    float optionHeight = (menuHeight - (borderY*2))/ (float) options.size();
    for(int i=0; i<options.size(); i++)
    {
      options.get(i).setOptionWidth(optionWidth);
      options.get(i).setOptionHeight(optionHeight);
      options.get(i).setOptionPosition(position.x+borderX, position.y+borderY+(optionHeight*i));
    }
  }
  
  int checkClick()
  {
    int returnValue = -1;
    for(int i=0; i<options.size(); i++)
    {
      if(options.get(i).checkMouseClick())
      {
        returnValue = i;
      }
    }
    
    return returnValue;
  }
}