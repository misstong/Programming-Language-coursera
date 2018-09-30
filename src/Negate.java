class Negate extends Exp {
    public Exp e;
    Negate(Exp e) {
        this.e = e;
    }
    Value eval() {
        // we downcast from Exp to Int, which will raise a run-time error
        // if the subexpression does not evaluate to an Int
        return new Int(- ((Int)(e.eval())).i);
    }
    String toStrng() {
        return "-(" + e.toStrng() + ")";
    }
    boolean hasZero() {
        return e.hasZero();
    }
    Exp noNegConstants() {
        return new Negate(e.noNegConstants());
    }
}