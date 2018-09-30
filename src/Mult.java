class Mult extends Exp {
    Exp e1;
    Exp e2;
    Mult(Exp e1, Exp e2) {
        this.e1 = e1;
        this.e2 = e2;
    }
    Value eval() {
        // we downcast from Exp to Int, which will raise a run-time error
        // if either subexpression does not evaluate to an Int
        return new Int(((Int)(e1.eval())).i * ((Int)(e2.eval())).i);
    }
    String toStrng() {
        return "(" + e1.toStrng() + " * " + e2.toStrng() + ")";
    }
    boolean hasZero() {
        return e1.hasZero() || e2.hasZero();
    }

    Exp noNegConstants() {
        return new Mult(e1.noNegConstants(), e2.noNegConstants());
    }
}   