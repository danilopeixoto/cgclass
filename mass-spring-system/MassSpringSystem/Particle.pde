public class Particle {
    public PVector position;
    public PVector velocity;
    public PVector force;
    public float mass;
    public boolean passive;
    
    public Particle() {}
    public Particle(PVector position, PVector velocity, PVector force, float mass, boolean passive) {
        this.position = position;
        this.velocity = velocity;
        this.force = force;
        this.mass = mass;
        this.passive = passive;
    }
}
