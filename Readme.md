# ZESpiral
Use this class to generate arithmetic ("Archimedes") spirals. It uses Bézier curve approximation to create a `UIBezierPath` of the form r = a + bθ.

ZESpiral requires iOS 5.1, and is designed to be used with ARC.

Includes a demo project with sliders to change the following parameters:

####Start Radius (UIKit points)
* How far from the center point to start the spiral. Use this parameter to make a hole in the center of your spiral.

####Space Per Loop
* A coefficient for how much the spiral grows over each rotation. 

####Start Theta (radians)
* The angle of the initial point in the center.

####End Theta (radians)
* How far around to go before stopping.

####Theta Step (radians)
* How often to add a bezier control point. Lower values result in a more accurate but more complex path.

### Released Under the MIT License:

Copyright © 2013 Zev Eisenberg

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
