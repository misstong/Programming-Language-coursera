// Programming Languages, Dan Grossman
// Section 8: Binary Methods with OOP: Double Dispatch

abstract class Exp {
    abstract Value eval(); // no argument because no environment
    abstract String toStrng(); // renaming b/c toString in Object is public
    abstract boolean hasZero();
    abstract Exp noNegConstants();
}