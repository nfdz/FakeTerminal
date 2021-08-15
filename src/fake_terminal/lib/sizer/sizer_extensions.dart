import 'dart:math' as Math;

extension SizerX on double {
  double withMaxValue(double maxValue) {                                                     return Math.min(this, maxValue);



    
  }
}
