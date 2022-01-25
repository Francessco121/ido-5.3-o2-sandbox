[[← back]](README.md)

# Structs and Unions

## Passing a struct by value to a function

- **NOTE: If you see a function call being prepared with at least one of the first 4 arguments being redundantly stored in both an argument register and on the stack, it's likely that there is a struct being passed by value.**
- The caller will push each struct field onto the stack.
- The caller will ALSO store the first 4 fields in the a0-a3 registers (if not already taken).
- The receiver will never use argument registers that are taken up by a struct field and will instead always access them through the stack.
    - (not shown in this example) This is still true even if there are non-struct arguments alongside a struct argument in a position that would normally use an argument register. The non-struct arguments will use the argument registers but the struct fields won't.
- The receiver will still start by storing each argument register (used by a struct field) back onto the stack in the same place the caller would have placed it.
- Referring to a struct without a typedef makes no difference (i.e. `struct Test test`).
- (not shown in this example) Using a struct with an array field has the same effect (tho the receiver can access arguments in a different order).

```c
typedef struct {
    int a, b, c, d, e;
} Test;

int receiver(Test test) {
    return test.a + test.e;
}

void caller() {
    Test a;
    test(a);
}
```

```
00400090 <receiver>:
  400090:       sw      a0,0(sp)
  400094:       sw      a1,4(sp)
  400098:       sw      a2,8(sp)
  40009c:       sw      a3,12(sp)
  4000a0:       lw      t6,0(sp)
  4000a4:       lw      t7,16(sp)
  4000a8:       addu    v0,t6,t7
  4000ac:       jr      ra
  4000b0:       nop

004000b4 <caller>:
  4000b4:       addiu   sp,sp,-56
  4000b8:       sw      ra,28(sp)
  4000bc:       addiu   t6,sp,36
  4000c0:       lw      at,0(t6)
  4000c4:       sw      at,0(sp)
  4000c8:       lw      t8,4(t6)
  4000cc:       lw      a0,0(sp)
  4000d0:       sw      t8,4(sp)
  4000d4:       lw      at,8(t6)
  4000d8:       lw      a1,4(sp)
  4000dc:       sw      at,8(sp)
  4000e0:       lw      a3,12(t6)
  4000e4:       lw      a2,8(sp)
  4000e8:       sw      a3,12(sp)
  4000ec:       lw      at,16(t6)
  4000f0:       jal     400090 <receiver>
  4000f4:       sw      at,16(sp)
  4000f8:       lw      ra,28(sp)
  4000fc:       addiu   sp,sp,56
  400100:       jr      ra
  400104:       nop
```

## Struct/union by value copies

- Copying of a struct and union is identical.
- Each field is loaded and then stored one at a time.
- The first field may be loaded before a pointer is set up for the receiving struct.

```c
typedef struct {
    int a, b;
} Struct;

typedef union {
    int a;
    Struct b;
} Union;

void struct_copy() {
    Struct a, b;
    a = b;
}

void union_copy() {
    Union a, b;
    a = b;
}
```

```
00400090 <struct_copy>:
  400090:       addiu   sp,sp,-16
  400094:       addiu   t7,sp,0
  400098:       lw      at,0(t7)
  40009c:       addiu   t6,sp,8
  4000a0:       sw      at,0(t6)
  4000a4:       lw      t0,4(t7)
  4000a8:       sw      t0,4(t6)
  4000ac:       jr      ra
  4000b0:       addiu   sp,sp,16

004000b4 <union_copy>:
  4000b4:       addiu   sp,sp,-16
  4000b8:       addiu   t7,sp,0
  4000bc:       lw      at,0(t7)
  4000c0:       addiu   t6,sp,8
  4000c4:       sw      at,0(t6)
  4000c8:       lw      t0,4(t7)
  4000cc:       sw      t0,4(t6)
  4000d0:       jr      ra
  4000d4:       addiu   sp,sp,16
```
