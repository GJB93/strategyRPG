class Menu
{
  float menuWidth;
  float menuHeight;
  float borderX;
  float borderY;
  PVector position;
  ArrayList<Option> options;
  color menuColor;
  color optionColor;
  int lightenValue;
  
  Menu()
  {
    this(0, 0, 0, 0, color(0));
  }
  
  Menu(float w, float h, float x, float y, color c)
  {
    lightenValue = 50;
    menuWidth = w;
    menuHeight = h;
    menuColor = c;
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
    rect(position.x, position.y, menuWidth, menuHeight);
    setOptionDimensions();
    for(Option option: options)
    {
      option.render();
    }
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
}