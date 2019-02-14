public class Solver {
    public PVector gravity;
    public float springLength;
    public float stiffness;
    public float damping;
    public float timestep;
    
    public ArrayList<Particle> particles;
    
    public Solver() {}
    public Solver(PVector gravity, float springLength, float stiffness, float damping, float timestep) {
        this.gravity = gravity;
        this.springLength = springLength;
        this.stiffness = stiffness;
        this.damping = damping;
        this.timestep = timestep;
        
        this.particles = new ArrayList();
    }
    
    public void simulate() {
        int count = particles.size();
        
        if (count == 0)
            return;
        
        for (int i = 0; i < count - 1 && count > 1; i++) {
            Particle particle = particles.get(i);
            Particle nextParticle = particles.get(i + 1);
            
            PVector direction = PVector.sub(nextParticle.position, particle.position);
            float distance = direction.mag();
            
            direction.div(distance);
            
            float currentSpringLength = distance - springLength;
            float velocityLength = PVector.sub(nextParticle.velocity, particle.velocity).dot(direction);
            
            PVector springForce = PVector.mult(direction, stiffness * currentSpringLength);
            PVector dampingForce = PVector.mult(direction, damping * velocityLength);
            
            PVector force = PVector.add(springForce, dampingForce);
            
            if (!particle.passive)
                particle.force.add(force);
            
            if (!nextParticle.passive)
                nextParticle.force.sub(force);
        }
        
        for (int i = 0; i < count; i++) {
            Particle particle = particles.get(i);
            
            if (particle.passive)
                continue;
            
            PVector gravitationalForce = PVector.mult(gravity, particle.mass);
            
            particle.force.sub(gravitationalForce);
        }
        
        for (int i = 0; i < count; i++) {
            Particle particle = particles.get(i);
            PVector acceleration = PVector.div(particle.force, particle.mass);
            
            particle.velocity.add(PVector.mult(acceleration, timestep));
            particle.position.add(PVector.mult(particle.velocity, timestep));
            
            particle.force = new PVector(0, 0);
        }
    }
    
    public void draw() {
        int count = particles.size();
        
        if (count == 0)
            return;
            
        for (int i = 0; i < count - 1 && count > 1; i++) {
            Particle currentParticle = particles.get(i);
            Particle nextParticle = particles.get(i + 1);
            
            line(currentParticle.position.x, currentParticle.position.y,  nextParticle.position.x, nextParticle.position.y);
        }
        
        for (int i = 0; i < count; i++) {
            Particle particle = particles.get(i);
            ellipse(particle.position.x, particle.position.y, 10, 10);
        }
    }
}
