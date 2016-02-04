class Option
{
  float optionWidth;
  float optionHeight;
  float middleX;
  float middleY;
  String optionText;
  PVector position;
  boolean mouseHover;
  color staticColor;
  color hoverColor;
  float lightenValue;
  float middleColorValue;

  Option()
  {
    this(0, 0, 0, 0, "", color(0));
  }

  Option(String optionText, color c)
  {
    lightenValue = 50;
    mouseHover = false;
    middleColorValue = (256*0.5f)*3;
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
    this.middleX = optionWidth*0.5f;
    this.middleY = optionHeight*0.5f;
    this.optionText = optionText;
    mouseHover = false;
    middleColorValue = (256*0.5f)*3;
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
    this.middleX = optionWidth*0.5f;
  }

  void setOptionHeight(float h)
  {
    this.optionHeight = h;
    this.middleY = optionHeight*0.5f;
  }

  void setOptionPosition(float x, float y)
  {
    this.position = new PVector(x, y);
  }

  void render()
  {
    checkMouseHover();
    color currentColor;
    color textColor;
    if (mouseHover)
    {
      currentColor = hoverColor;
    } else
    {
      currentColor = staticColor;
    }

    if (red(currentColor)+green(currentColor)+blue(currentColor) > middleColorValue)
    {
      textColor = color(0);
    } else
    {
      textColor = color(255);
    }

    if (mouseHover)
    {
      noStroke();
    } else
    {
      stroke(textColor);
    }

    fill(currentColor);
    rect(position.x, position.y, optionWidth, optionHeight);
    fill(textColor);
    textAlign(CENTER, CENTER);

    if (optionWidth > 100)
    {
      textSize(20);
    } else
    {
      textSize(10);
    }
    text(optionText, position.x+middleX, position.y+middleY);
  }

  void checkMouseHover()
  {
    if (mouseX > position.x && mouseX < position.x+optionWidth && mouseY > position.y && mouseY < position.y+optionHeight)
    {
      mouseHover = true;
    } else
    {
      mouseHover = false;
    }
  }

  boolean checkMouseClick()
  {
    if (pmouseX > position.x && pmouseX < position.x+optionWidth && pmouseY > position.y && pmouseY < position.y+optionHeight)
    {
      return true;
    } else
    {
      return false;
    }
  }
}