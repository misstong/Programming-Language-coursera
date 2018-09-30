class Int extends Value {
    public int i;
    Int(int i) {
        this.i = i;
    }
    Value eval() {
        return this;
    }
    String toStrng() {
        return "" + i;
    }
    boolean hasZero() {
        return i==0;
    }
    Exp noNegConstants() {
        if(i < 0)
            return new Negate(new Int(-i));
        else
            return this;
    }
    /*Value add_values(Value other) {
        return other.addInt(this);
    }
    Value addInt(Int other) {
        return new Int(other.i + i);
    }
    Value addString(MyString other) {
        return new MyString(other.s + i);
    }
    Value addRational(Rational other) {
        return new Rational(other.i+other.j*i,other.j);
    }
    */
    Value add_values(Int other){
        return new Int(other.i + i);
    }
    Value add_value(MyString other){
        return new MyString(other.s + i);
    }
    Value add_value(Rational other){
        return new Rational(other.i+other.j*i,other.j);
    }
}
