Triangle triangle;

void setup() {
    size(500, 500, P3D);
    
    PVector vertex0 = new PVector(0, 0, 0);
    PVector vertex1 = new PVector(0, 100.0, 0);
    PVector vertex2 = new PVector(100.0, 0, 0);
    
    PMatrix3D translation = new PMatrix3D(1.0, 0, 0, width / 2,
                                          0, 1.0, 0, height / 2,
                                          0, 0, 1.0, 0,
                                          0, 0, 0, 1.0);
    
    triangle = new Triangle(vertex0, vertex1, vertex2, translation);
}

void draw() {
    background(0);
    
    float angle = 0.1;
    PMatrix3D rotation = new PMatrix3D(cos(angle), -sin(angle), 0, 0,
                                       sin(angle), cos(angle), 0, 0,
                                       0, 0, 1.0, 0,
                                       0, 0, 0, 1.0);
    
    triangle.transform(rotation);
    triangle.draw();
}
