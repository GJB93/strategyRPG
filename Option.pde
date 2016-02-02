class Option
{
  float optionWidth;
  float optionHeight;
  String optionText;
  PVector position;
  boolean mouseHover;
  color staticColor;
  color hoverColor;
  float lightenValue;
  
  Option()
  {
    this(0, 0, 0, 0, "", color(0));
  }
  
  Option(String optionText, color c)
  {
    lightenValue = 50;
    mouseHover = false;
    this.optionText = optionText;
    staticColor = c;
    float redValue = red(c)+lightenValue;
    float greenValue = green(c)+lightenValue;
    float blueValue = blue(c)+lightenValue;
    hoverColor = color(redValue%256, greenValue%256, blueValue%256);
  }
  
  Option(float w, float h, float x, float y, String optionText, color c)
  {
    lightenValue = 50;
    this.optionWidth = w;
    this.optionHeight = h;
    this.optionText = optionText;
    mouseHover = false;
    position = new PVector(x, y);
    staticColor = c;
    float redValue = red(c)+lightenValue;
    float greenValue = green(c)+lightenValue;
    float blueValue = blue(c)+lightenValue;
    hoverColor = color(redValue%256, greenValue%256, blueValue%256);
  }
  
  void setOptionWidth(float w)
  {
    this.optionWidth = w;
  }
  
  void setOptionHeight(float h)
  {
    this.optionHeight = h;
  }
  
  void setOptionPosition(float x, float y)
  {
    this.position = new PVector(x,y);
  }
  
  void render()
  {
    checkMouseHover();
    color currentColor;
    color textColor;
    if(mouseHover)
    {
      currentColor = hoverColor;
    }
    else
    {
      currentColor = staticColor;
    }
    
    if(red(currentColor)+green(currentColor)+blue(currentColor) > (256*0.5f)*3)
    {
      textColor = color(0);
    }
    else
    {
      textColor = color(255);
    }
    
    if(mouseHover)
    {
      noStroke();
    }
    else
    {
      stroke(textColor);
    }
    
    fill(currentColor);
    rect(position.x, position.y, optionWidth, optionHeight);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(optionText, position.x+(optionWidth*0.5f), position.y+(optionHeight*0.5f));
  }
  
  void checkMouseHover()
  {
    if(mouseX > position.x && mouseX < position.x+optionWidth && mouseY > position.y && mouseY < position.y+optionHeight)
    {
      mouseHover = true;
    }
    else
    {
      mouseHover = false;
    }
  }
  
  boolean checkMouseClick()
  {
    if(pmouseX > position.x && pmouseX < position.x+optionWidth && pmouseY > position.y && pmouseY < position.y+optionHeight)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}