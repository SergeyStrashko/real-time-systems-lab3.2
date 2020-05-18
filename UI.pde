class Cell {
  String value;
  boolean isActive = false;
  
  float x1;
  float y1;
  float x2;
  float y2;
  
  Cell(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  void show() {
    if (isActive) {
      noStroke();
      rectMode(CORNERS);
      fill(255, 255, 255, 150);
      rect(this.x1, this.y1, this.x2, this.y2);
    }
    
    textAlign(CENTER, CENTER);
    
    if (isActive) {
      fill(0, 0, 0);
    } else {
      fill(255, 255, 255);
    }
    
    int textSize = (height > width) ? (int)(width*0.04) : (int)(height*0.04);
    
    textSize(textSize);
    text(this.value, x1 + (x2 - x1)/2, y1 + (y2 - y1)/2);
  }
  
  void isActive(String currentValue) {
    this.isActive = this.value.equals(currentValue);
  }
  
  boolean isClicked(int x, int y) {
    if (x >= x1 && x <= x2 && y >= y1 && y <= y2) {
      this.isActive = true;
      return true;
    }
    return false;
  }
}

class DataSetSection {
  float x1;
  float y1;
  float x2;
  float y2;
  
  Cell[] datasetTypes = new Cell[2];
  Cell[] sizes = new Cell[3];
  
  String newDataSetType = "";
  String newSize = "";
  String currentSize = (randomize) ? String.valueOf(datasetSize) : "null";
  
  DataSetSection(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  void show() {
    float yMiddle = height/2 - (y2 - y1);
    
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    
    int textSize = (height > width) ? (int)(width*0.04) : (int)(height*0.04);
    
    textSize(textSize);
    text("Use test dataset:", x1 + (width/2 - x1)/2, y1 + (yMiddle - y1)/2);
    
    stroke(150);
    line(x1, height/2 - (y2 - y1), x2, height/2 - (y2 - y1));
    
    line(width/2, y1, width/2, yMiddle);
    
    float step = (x2 - width/2) / 2;
    for(int i = 1; i < 2; i++) {
      line(width/2 + step * i, y1, width/2 + step * i, yMiddle);
    }
    
    datasetTypes[0] = new Cell(width/2, y1, width/2 + step, yMiddle);
    datasetTypes[1] = new Cell(width/2 + step, y1, x2, yMiddle);
    
    datasetTypes[0].value = "Yes";
    datasetTypes[1].value = "No";
    
    String currentDataSetType = (!randomize) ? "No" : "Yes";
    
    if(!newDataSetType.equals("")) {
      currentDataSetType = newDataSetType;
    }
    
    for (Cell dt : datasetTypes) {
      if(mousePressed) {
        if(dt.isClicked(mouseX, mouseY)) {
          newDataSetType = dt.value;
        }
      }
      dt.isActive(currentDataSetType);
      dt.show();
    }
    
    step = (x2 - x1) / 3;
    
    sizes[0] = new Cell(x1, yMiddle, x1 + step, y2);
    sizes[1] = new Cell(x1 + step, yMiddle, x1 + step * 2, y2);
    sizes[2] = new Cell(x1 + step * 2, yMiddle, x2, y2);
    
    sizes[0].value = "10";
    sizes[1].value = "50";
    sizes[2].value = "100";
    
    currentSize = (!currentDataSetType.equals("No")) ? String.valueOf(datasetSize) : "null";
    
    if(!currentDataSetType.equals("No")) { 
      stroke(150);
      for(int i = 1; i < 3; i++) {
        line(x1 + step * i, yMiddle, x1 + step * i, y2);
      }
      if(!newSize.equals("") && !newSize.equals("null")) {
        currentSize = newSize;
      }
      for (Cell s : sizes) {
        if(mousePressed) {
          if(s.isClicked(mouseX, mouseY)) {
            newSize = s.value;
          }
        }
      s.isActive(currentSize);
      s.show();
      }
    }
  }
}

class LearningRateSection {
  float x1;
  float y1;
  float x2;
  float y2;
  
  String newLR = "";
  String currentLR = String.valueOf(lr);
    
  Cell[] learningRates = new Cell[6];
    
  LearningRateSection(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  void show() {
    float yMiddle = height/2;
    
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    
    int textSize = (height > width) ? (int)(width*0.04) : (int)(height*0.04);
    
    textSize(textSize);
    text("Learning rate:", x1 + (width/2 - x1)/2, yMiddle);
    
    stroke(150);
    
    line(width/2, y1, width/2, y2);
    
    line(width/2, yMiddle, x2, yMiddle);
    
    float step = (x2 - width/2) / 3;
    
    for(int i = 1; i < 3; i++) {
      line(width/2 + step * i, y1, width/2 + step * i, y2);
    }
    
    learningRates[0] = new Cell(width/2, y1, width/2 + step, yMiddle);
    learningRates[1] = new Cell(width/2 + step, y1, width/2 + step * 2, yMiddle);
    learningRates[2] = new Cell(width/2 + step * 2, y1, x2, yMiddle);
    learningRates[3] = new Cell(width/2, yMiddle, width/2 + step, y2);
    learningRates[4] = new Cell(width/2 + step, yMiddle, width/2 + step * 2, y2);
    learningRates[5] = new Cell(width/2 + step * 2, yMiddle, x2, y2);
    
    learningRates[0].value = "0.001";
    learningRates[1].value = "0.01";
    learningRates[2].value = "0.05";
    learningRates[3].value = "0.1";
    learningRates[4].value = "0.2";
    learningRates[5].value = "0.3";
    
    currentLR = String.valueOf(lr);
    
    if(!newLR.equals("")) {
      currentLR = newLR;
    }
    
    for (Cell lr : learningRates) {
      if(mousePressed) {
        if(lr.isClicked(mouseX, mouseY)) {
          newLR = lr.value;
        }
      }
      lr.isActive(currentLR);
      lr.show();
    }
  }
}

class DeadlineSection {
  float x1;
  float y1;
  float x2;
  float y2;
    
  Cell[] deadlineTypes = new Cell[2];
  Cell[] deadlines = new Cell[4];
  
  String newDT = "";
  String newDeadline = "";
  String currentDT = deadlineType;
  String currentDeadline = (currentDT.equals("Iterations")) ? String.valueOf(dL) : dL_s;
    
  DeadlineSection(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  void show() {
    float yMiddle = height/2 + (y2 - y1);
    
    textAlign(CENTER, CENTER);
    fill(255, 255, 255);
    
    int textSize = (height > width) ? (int)(width*0.04) : (int)(height*0.04);
    
    textSize(textSize);
    text("Deadline in:", x1 + (width/2 - x1)/2, y1 + (yMiddle - y1)/2);
    
    stroke(150);
    line(x1, height/2 + (y2 - y1), x2, height/2 + (y2 - y1));
    
    line(width/2, y1, width/2, yMiddle);
    
    float step = (x2 - width/2) / 2;
    for(int i = 1; i < 2; i++) {
      line(width/2 + step * i, y1, width/2 + step * i, yMiddle);
    }
    
    deadlineTypes[0] = new Cell(width/2, y1, width/2 + step, yMiddle);
    deadlineTypes[1] = new Cell(width/2 + step, y1, x2, yMiddle);
    
    deadlineTypes[0].value = "Iterations";
    deadlineTypes[1].value = "Seconds";
    
    currentDT = deadlineType;
    
    if(!newDT.equals("")) {
      currentDT = newDT;
    }
    
    for (Cell dT : deadlineTypes) {
      if(mousePressed) {
        if(dT.isClicked(mouseX, mouseY)) {
          newDT = dT.value;
        }
      }
      dT.isActive(currentDT);
      dT.show();
    }
    
    stroke(150);
    step = (x2 - x1) / 4;
    for(int i = 1; i < 4; i++) {
      line(x1 + step * i, yMiddle, x1 + step * i, y2);
    }
    
    deadlines[0] = new Cell(x1, yMiddle, x1 + step, y2);
    deadlines[1] = new Cell(x1 + step, yMiddle, x1 + step * 2, y2);
    deadlines[2] = new Cell(x1 + step * 2, yMiddle, x1 + step * 3, y2);
    deadlines[3] = new Cell(x1 + step * 3, yMiddle, x2, y2);
    
    if (currentDT.equals("Iterations")) {
      deadlines[0].value = "100";
      deadlines[1].value = "200";
      deadlines[2].value = "500";
      deadlines[3].value = "1000";
    } else {
      deadlines[0].value = "0.5 s";
      deadlines[1].value = "1 s";
      deadlines[2].value = "2 s";
      deadlines[3].value = "5 s";
    }
    
    currentDeadline = (currentDT.equals("Iterations")) ? String.valueOf(dL) : dL_s;
    
    if(!newDeadline.equals("")) {
      currentDeadline = newDeadline;
    }
    
    for (Cell d : deadlines) {
      if(mousePressed) {
        if(d.isClicked(mouseX, mouseY)) {
          newDeadline = d.value;
        }
      }
      d.isActive(currentDeadline);
      d.show();
    }
  }
}

class UI {
  float menuButtonX1;
  float menuButtonY1;
  float menuButtonX2;
  float menuButtonY2;
  boolean menuClosed = true;
  
  float closeButtonX1;
  float closeButtonY1;
  float closeButtonX2;
  float closeButtonY2;
  
  float applyButtonX1;
  float applyButtonY1;
  float applyButtonX2;
  float applyButtonY2;
  
  void showRestartHint() {
    noStroke();
    fill(7, 11, 18, 100);
    rectMode(CENTER);
    rect(width/2, height/2, width*0.75, height*0.20);
    
    textAlign(CENTER);
    fill(255, 255, 255, 200);
    
    int textSize = (height > width) ? (int)(width*0.10) : (int)(height*0.10);
    
    textSize(textSize);
    text("Tap to restart", width/2, height/2 + textSize/4);
  }
  
  boolean clickedOnMenu(int x, int y) {
   if (x >= menuButtonX1 && x <= menuButtonX2 && y >= menuButtonY1 && y <= menuButtonY2) {
     menuClosed = (menuClosed) ? !menuClosed : menuClosed;
     return true;
   }
   return false;
  }
  
  boolean clickedOnClose(int x, int y) {
   if (x >= closeButtonX1 && x <= closeButtonX2 && y >= closeButtonY1 && y <= closeButtonY2) {
     menuClosed = true;
     return true;
   }
   return false;
  }
  
  boolean clickedOnApply(int x, int y) {
   if (x >= applyButtonX1 && x <= applyButtonX2 && y >= applyButtonY1 && y <= applyButtonY2) {
     menuClosed = true;
     
     if (dataset.newDataSetType.equals("No")) {
       randomize = false;
     } else {
       randomize = true;
       datasetSize = Integer.valueOf(dataset.currentSize);
     }
     
     lr = Float.valueOf(learningRate.currentLR);
     
     deadlineType = deadline.currentDT;
     
     if (deadlineType.equals("Iterations")) {
       dL = Integer.valueOf(deadline.currentDeadline); 
     } else {
       dL_s = deadline.currentDeadline;
     }
     
     initializePoints();
     return true;
   }
   return false;
  }
  
  void showMenuButton() {
    noStroke();
    fill(7, 11, 18, 100);
    rectMode(CORNERS);
    
    float rW = height*0.10;
    float rH = height*0.10;
    rect(width - rW, 0, width, rH);
    
    this.menuButtonX1 = width - rW;
    this.menuButtonY1 = 0;
    this.menuButtonX2 = width;
    this.menuButtonY2 = rH;
    
    fill(255, 255, 255, 150);
    float step = rH/7;
  
    rect(width - rW + rW*0.10, step, width - rW*0.10, step*2);
    rect(width - rW + rW*0.10, step*3, width - rW*0.10, step*4);
    rect(width - rW + rW*0.10, step*5, width - rW*0.10, step*6);
  }
  
  void showMenu() {
    if (!menuClosed) {
      noStroke();
      fill(70, 73, 79);
      rectMode(CENTER);
      rect(width/2, height/2, width*0.75, height*0.60);
      
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      
      int textSize = (height > width) ? (int)(width*0.10) : (int)(height*0.10);
      
      textSize(textSize);
      text("Menu", width/2, height/2 - height*0.6/2 + textSize/2);
      
      stroke(150);
      line(width/2 - width*0.75/2, height/2 - height*0.6/2 + textSize, width/2 + width*0.75/2, height/2 - height*0.6/2 + textSize);
      line(width/2 - width*0.75/2, height/2 + height*0.6/2 - textSize, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize);
      line(width/2, height/2 + height*0.6/2 - textSize, width/2, height/2 + height*0.6/2); 
    
      float step = ((height/2 - height*0.6/2 + textSize) - (height/2 + height*0.6/2 - textSize)) / 3;
      
      line(width/2 - width*0.75/2, height/2 + height*0.6/2 - textSize + step, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize  + step);
      line(width/2 - width*0.75/2, height/2 + height*0.6/2 - textSize  + step * 2, width/2 + width*0.75/2, height/2 + height*0.6/2 - textSize  + step * 2);
    
      textSize(textSize - textSize/4);
      text("Apply", width/2 - width*0.75/4, height/2 + height*0.6/2 - textSize/2);
      text("Close", width/2 + width*0.75/4, height/2 + height*0.6/2 - textSize/2);
      
      this.applyButtonX1 = width/2 - width*0.75/2;
      this.applyButtonY1 = height/2 + height*0.6/2 - textSize;
      this.applyButtonX2 = width/2;
      this.applyButtonY2 = height/2 + height*0.6/2;
  
      this.closeButtonX1 = width/2;
      this.closeButtonY1 = height/2 + height*0.6/2 - textSize;
      this.closeButtonX2 = width/2 + width*0.75/2;
      this.closeButtonY2 = height/2 + height*0.6/2;
      
      dataset.show();
      learningRate.show();
      deadline.show();
    }
  }
  
  void showInfo() {
    float w0 = p.weights[0];
    float w1 = p.weights[1];
    
    noStroke();
    fill(7, 11, 18, 100);
    rectMode(CORNERS);
    rect(0, height*0.9, width, height);
    
    textAlign(CENTER);
    fill(255, 255, 255);
    
    int textSize = (height > width) ? (int)(width*0.04) : (int)(height*0.04);
    
    textSize(textSize);
    float step = (height - height*0.9)/5;
    
    text("w0 = " + w0 + ";", width*0.25, height*0.9 + step * 2);
    text("w1 = " + w1 + ";", width*0.25, height*0.9 + step * 3 + textSize/4);
    
    text("Learning rate = " + lr + ";", width*0.75, height*0.9 + step * 2);
    
    String text = (deadlineType.equals("Iterations")) ? counter + " -> " + dL + ";" : (float)(start - start_s)/1000 + "s  -> " + dL_s + ";";
    
    text(text , width*0.75, height*0.9 + step * 3 + textSize/4);
  }
}
