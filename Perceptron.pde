//The activation function
int sign(float n) {
  return (n >= 0) ? 1 : -1;
}

class Perceptron {
  float[] weights;
  float lr;
  
  Perceptron(int n, float lr) {
    weights = new float[n];
    this.lr = lr;
    
    for (int i = 0; i < weights.length; i++){
      weights[i] = random(-2, 2);
    }
  }
  
  int guess(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }
    
    int output = sign(sum);
    return output;
  }
  
  void train(float[] inputs, int target) {
    int guess = guess(inputs);
    
    float error = target - guess;
    
    for (int i = 0; i < weights.length; i++) {
      weights[i] += error * inputs[i] * lr;
    }
  }
   
  float guessY(float x) {
    float w0 = weights[0];
    float w1 = weights[1];
    float w2 = weights[2];
    
    return -(w2/w1) - (w0/w1) * x;
  }
}
