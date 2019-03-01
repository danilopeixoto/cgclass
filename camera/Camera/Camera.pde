void setup() {
    size(500, 500, P3D);
}

void draw() {
    background(100);
    
    // Setup perspective projection
    pushMatrix();
    resetMatrix(); // Reset to identity
    
    float fov = PI / 4.0;
    perspective(fov, float(width)/float(height), 0.1, 1000.0);
    
    PMatrix3D projection = (PMatrix3D)getMatrix();
    
    popMatrix();
    
    // Setup view matrix
    pushMatrix();
    resetMatrix(); // Reset to identity
    
    camera(28.0, -21.0, 28.0, 0, 0, 0, 0, 1.0, 0);
    
    PMatrix3D view = (PMatrix3D)getMatrix();
    
    popMatrix();
    
    // Setup model matrix
    pushMatrix();
    resetMatrix(); // Reset to identity
    
    translate(10, 0, 0);
    
    PMatrix3D model = (PMatrix3D)getMatrix();
    
    popMatrix();
    
    // Setup style
    pushStyle();
    
    // Setup transformations: projection, view and model
    pushMatrix();
    resetMatrix(); // Reset to identity
    
    applyMatrix(projection);
    applyMatrix(view);
    applyMatrix(model);
    
    noFill();
    
    stroke(50);
    strokeWeight(1.0);
    
    box(10.0);
    
    popMatrix();
    popStyle();
}
