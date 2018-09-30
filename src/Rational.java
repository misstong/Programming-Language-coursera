class Rational extends Value {
    int i;
    int j;
    Rational(int i, int j) {
        this.i = i;
        this.j = j;
    }
    Value eval() {
        return this;
    }
    String toStrng() {
        return "" + i + "/" + j;
    }
    boolean hasZero() {
        return i==0;
    }
    Exp noNegConstants() {
        if(i < 0 && j < 0)
            return new Rational(-i,-j);
        else if(j < 0)
            return new Negate(new Rational(i,-j));
        else if(i < 0)
            return new Negate(new Rational(-i,j));
        else
            return this;
    }
   /* Value add_values(Value other) {
        return other.addRational(this);
    }
    Value addInt(Int other) {
        return other.addRational(this);	// reuse computation of commutative operation

    }
    Value addString(MyString other) {
        return new MyString(other.s + i + "/" + j);
    }
    Value addRational(Rational other) {
        int a = i;
        int b = j;
        int c = other.i;
        int d = other.j;
        return new Rational(a*d+b*c,b*d);
    }*/
   Value add_value(Int other){
       return new Rational(other.i+i,j);
   }
   Value add_value(MyString other){
       return new MyString(other.s + i + "/" + j);
   }
   Value add_value(Rational other){
       int a = i;
       int b = j;
       int c = other.i;
       int d = other.j;
       return new Rational(a*d+b*c,b*d);
   }
}