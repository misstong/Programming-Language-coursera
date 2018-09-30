class Add extends Exp {
    Exp e1;
    Exp e2;
    Add(Exp e1, Exp e2) {
        this.e1 = e1;
        this.e2 = e2;
    }
    Value eval() {
        return e1.eval().add_values(e2.eval());
    }
    String toStrng() {
        return "(" + e1.toStrng() + " + " + e2.toStrng() + ")";
    }
    boolean hasZero() {
        return e1.hasZero() || e2.hasZero();
    }
    Exp noNegConstants() {
        return new Add(e1.noNegConstants(), e2.noNegConstants());
    }
}