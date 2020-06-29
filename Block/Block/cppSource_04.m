
int main(int argc, const char * argv[]) {
    __block int i = 12;
    void (^tempBlock)(void) = ^{
        printf("tempBlock string %zd\n", i);
    };
    tempBlock();
    i = 10;
    return 0;
}

// block 实现的结构体
struct __block_impl {
    void *isa;      // 实例对象
    int Flags;      // 按位承载block 的附加信息
    void *FuncPtr;  // 函数指针，指向Block 要执行的函数
    int Reserved;   // 保留变量
};

// block 修饰的外部变量
struct __Block_byref_i_0 {
    void *__isa;                        // 对象指针
    __Block_byref_i_0 *__forwarding;    // 指向自己的指针
    int __flags;                        // 标志位变量
    int __size;                         // 结构体大小
    int i;                              // 外部变量
};

// 函数: 当block从 栈 拷贝到 堆 时，调用此函数
extern "C" __declspec(dllexport) void _Block_object_assign(void *, const void *, const int);
// 函数: 当block从 堆内存 释放时，调用此函数
extern "C" __declspec(dllexport) void _Block_object_dispose(const void *, const int);

extern "C" void _Block_object_assign(void *, const void *, const int)
__attribute__((availability(macosx,introduced=10.6)));
extern "C" void _Block_object_dispose(const void *, const int)
__attribute__((availability(macosx,introduced=10.6)));

// block 实现的结构体，也是block 实现的入口
struct __main_block_impl_0 {
    
    struct __block_impl impl;           // block 实现的结构体变量
    struct __main_block_desc_0* Desc;   // 描述block 的结构体变量
    __Block_byref_i_0 *i;               // by ref
    
    // __main_block_impl_0              // 结构体的构造函数，初始化 impl 和 Desc i
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_i_0 *_i, int flags=0) : i(_i->__forwarding) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// bolck 实现函数
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    __Block_byref_i_0 *i = __cself->i; // bound by ref
    
    printf("tempBlock string %zd\n", (i->__forwarding->i));
}

// block 复制参数
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->i, (void*)src->i, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->i, 8/*BLOCK_FIELD_IS_BYREF*/);}

// block 描述信息结构体
static struct __main_block_desc_0 {
    size_t reserved;               // 结构体信息保留字段
    size_t Block_size;             // 结构体大小
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};


int main(int argc, const char * argv[]) {
    __attribute__((__blocks__(byref))) __Block_byref_i_0 i = {(void*)0,(__Block_byref_i_0 *)&i, 0, sizeof(__Block_byref_i_0), 12};
    
    void (*tempBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_i_0 *)&i, 570425344));
    
    (i.__forwarding->i) = 10;
    
    ((void (*)(__block_impl *))((__block_impl *)tempBlock)->FuncPtr)((__block_impl *)tempBlock);
    
    return 0;
}
