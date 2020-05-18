class Function {
  float P;
  float a;
  float b;
  
  boolean test;
  
  Function(float P) {
    this.P = P;
    
    test = true;
  }
  
  Function(float a, float b) {
    this.a = a;
    this.b = b;
    
    test = false;
  }
  
  float execute(float x) {
    return (test) ? P * x : a * x + b;
  }
}

class Point {
  float x;
  float y;
  float bias = 1;
  
  int label;
  
  Point() {
    this.x = random(-10, 10);
    this.y = random(-10, 10);
   
    
    float lineY = f.execute(x);
    label = (y > lineY) ? 1 : -1;
  }
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;

    
    float lineY = f.execute(x);
    label = (y > lineY) ? 1 : -1;
  }
  
  float pixelX() {
    return map(x, -10, 10, 0, width);
  }
  
  float pixelY() {
    return map(y, -10, 10, height, 0);
  }
  
  void show() {
    stroke(0);
    if (label == 1) {
      fill(255);
    } else {
      fill(0);
    }
    
    float px = pixelX();
    float py = pixelY();
    noStroke();
    ellipse(px, py, 32, 32);
  }
}
