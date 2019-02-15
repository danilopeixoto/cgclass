int particleCount = 10;
int passiveParticle = 0;
float particleMass = 1.0;

PVector gravity = new PVector(0, -9.8);
Solver solver = new Solver(gravity, 10.0, 2.0, 1.0, 0.25);

void setup() {
    size(800, 600);
    
    for (int i = 0; i < particleCount; i++) {
        PVector position = new PVector(width / 2.0, i * solver.springLength);
        PVector velocity = new PVector(0, 0);
        PVector force = new PVector(0, 0);
        
        Particle particle = new Particle(position, velocity, force, particleMass, i == passiveParticle);
        solver.particles.add(particle);
    }
}

void draw() {
    background(255);
    fill(255);
    stroke(0);
    strokeWeight(1.0);
    
    if (solver.particles.size() != 0 && (mousePressed && mouseButton == LEFT)) {
        Particle particle = solver.particles.get(passiveParticle);
        
        particle.position.x = mouseX;
        particle.position.y = mouseY;
    }
    
    solver.simulate();
    solver.draw();
}
