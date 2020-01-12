class button {
  int x, y, sx, sy;
  int r, g, b;
  color colour; 
  boolean clicked;
  String words;

  button(int xx, int yy, int rr, int gg, int bb, int w, String message) {
    this.x = xx;
    this.y = yy;
    this.sx = w;
    this.sy = 50;
    this.r = rr;
    this.g = gg;
    this.b = bb;
    this.colour = color(rr, gg, bb);
    this.clicked = false;
    this.words = message;
  }

  void appear() {
    stroke(50);
    fill(this.colour, 200);
    rect(this.x, this.y, this.sx, this.sy);
    fill(255);
    textFont(font, 20);
    text(this.words, this.x + 55, this.y+30);
  }

  void checkCLICKED(int mx, int my) {
    if (mx > this.x  &&  mx < this.x+this.sx  &&  my > this.y  &  my < this.y+this.sy) clicked = true;
  }
}

class startButton extends button {
  startButton(int xx, int yy, String message, int w, int r, int g, int b) {
    super(xx, yy, r, g, b, w, message);
  }
  void appearr(int mx, int my) {
    this.appear();
    if (mx > this.x  &&  mx < this.x+this.sx  &&  my > this.y  &  my < this.y+this.sy) this.colour = color(this.r - 50, this.g, this.b);
    else this.colour = color(this.r, this.g, this.b);
  }
}

class endButton extends button {
  endButton(int xx, int yy, String message, int w) {
    super(xx, yy, 0, 255, 0, w, message);
  }

  void appearr(int mx, int my) {
    this.appear();
    if (mx > this.x  &&  mx < this.x+this.sx  &&  my > this.y  &  my < this.y+this.sy) this.colour = color(this.r, this.g-50, this.b);
    else this.colour = color(this.r, this.g, this.b);
  }
}
