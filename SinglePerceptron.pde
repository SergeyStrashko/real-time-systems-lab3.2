float P = 4;
boolean randomize = true;
float lr = 0.1;
int datasetSize = 100;
String deadlineType = "Iterations";
int dL = 100;
String dL_s = "5 s";
int counter = 0;

long start = 0;
long end = 0;
long start_s = 0;

int[][] dataSet = {{1, 5}, {2, 4}, {0,3}, {3, 3}};

//---------------------------------------------//

Perceptron p;
UI ui;
Point[] points;
int trainingIndex = 0;

Function f;

DataSetSection dataset;
LearningRateSection learningRate;
DeadlineSection deadline;

void setup() {
  //size(800, 800);
  int textSize = (height > width) ? (int)(width*0.10) : (int)(height*0.10);
  float step = ((height/2 - height*0.6/2 + textSize) - (height/2 + height*0.6/2 - textSize)) / 3;
      
  dataset = new DataSetSection(width/2 - width*0.75/2, height/2 - height*0.6/2 + textSize, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize + step * 2);
  learningRate = new LearningRateSection(width/2 - width*0.75/2, height/2 + height*0.6/2 - textSize + step * 2, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize + step);
  deadline = new DeadlineSection(width/2 - width*0.75/2, height/2 + height*0.6/2 - textSize + step, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize);
      
  
  fullScreen(); 
  p = new Perceptron(3, lr);
  ui = new UI();
  
  initializePoints();
}

void initializePoints() {
  counter = 0;
  trainingIndex = 0;
  p = new Perceptron(3, lr);
  
  if (randomize) {
    f = new Function(random(-5, 5), random(-5, 5));
    points = new Point[datasetSize];
    
    for (int i = 0; i < points.length; i++) {
       points[i] = new Point();
    }
  } else {
    f = new Function(P);
    points = new Point[dataSet.length];
    
    for (int i = 0; i < points.length; i++) {
      float x = dataSet[i][0];
      float y = dataSet[i][1];
      
      points[i] = new Point(x, y);
    }
  }
  setTime();
}

void drawCoordinatesLines() {
  stroke(0);
  strokeWeight(2);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
}

void drawExpectedLine() {
  stroke(3, 32, 252);
  strokeWeight(4);
  Point p1 = new Point(-10, f.execute(-10));
  Point p2 = new Point(10, f.execute(10));
  
  line(p1.pixelX(), p1.pixelY(), p2.pixelX(), p2.pixelY());
}

void drawActualLine() {
  stroke(252, 3, 111);
  strokeWeight(4);
  Point p1 = new Point(-10, p.guessY(-10));
  Point p2 = new Point(10, p.guessY(10));
  line(p1.pixelX(), p1.pixelY(), p2.pixelX(), p2.pixelY());
}

void showPoints() {
  for (Point pt : points) {
    pt.show();
  }
}

boolean checkStatuses() {
  boolean result = true;
  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y, pt.bias};
    int target = pt.label;
    
    int guess = p.guess(inputs);
    
    if (guess != target) return false;
  }
  return result;
}

void checkPointsStatus() {
  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y, pt.bias};
    int target = pt.label;
    
    int guess = p.guess(inputs);
    
    if (guess == target) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    
     noStroke();
     ellipse(pt.pixelX(), pt.pixelY(), 16, 16);
  }
}

void trainPoint() {
  Point training = points[trainingIndex];
  float[] inputs = {training.x, training.y, training.bias};
  int target = training.label;
  
  p.train(inputs, target);
  
  trainingIndex++;
  if (trainingIndex >= points.length) {
    trainingIndex = 0;
  }
}

void setTime() {
  String[] temp = dL_s.split(" ");
  
  start = millis();
  end = start + (int)(Float.valueOf(temp[0]) * 1000);
  
  start_s = start;
}

void draw() {
  background(150);
  
  drawCoordinatesLines();
  drawExpectedLine();
  drawActualLine();
  
  showPoints();
  checkPointsStatus();
  
  ui.showMenuButton();
  
  if(!checkStatuses() && ((deadlineType.equals("Iterations")) ? counter < dL : start <= end)) {
    trainPoint(); 
    counter++;
    start = millis();
  } else {
    ui.showRestartHint();
    if(mousePressed) {
      if(!ui.clickedOnMenu(mouseX, mouseY) && ui.menuClosed) {
        initializePoints();
      }
    }
  }
  
  if(mousePressed) {
    ui.clickedOnMenu(mouseX, mouseY);
    ui.clickedOnClose(mouseX, mouseY);
    ui.clickedOnApply(mouseX, mouseY);
  }
  ui.showMenu();
  ui.showInfo();
}
