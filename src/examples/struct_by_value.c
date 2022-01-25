typedef struct {
    int a, b;
} Test;

int receiver(int b, Test test, int a) {
    return a + test.a + test.b + b;
}

void caller() {
    Test a;
    receiver(2, a, 3);
}
