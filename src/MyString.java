class MyString extends Value {
    public String s;
    MyString(String s) {
        this.s = s;
    }
    Value eval() {
        return this;
    }
    String toStrng() {
        return s;
    }
    boolean hasZero() {
        return false;
    }

    Exp noNegConstants() {
        return this;
    }

   /* Value add_values(Value other) {
        return other.addString(this);
    }
    Value addInt(Int other) {
        return new MyString("" + other.i + s);
    }
    Value addString(MyString other) {
        return new MyString(other.s + s);
    }
    Value addRational(Rational other) {
        return new MyString("" + other.i + "/" + other.j + s);
    }*/
   Value add_value(Int other){
       return new MyString("" + other.i + s);
   }
   Value add_value(MyString other){
       return new MyString(other.s + s);
   }
   Value add_value(Rational other){
       return new MyString("" + other.i + "/" + other.j + s);
   }
}