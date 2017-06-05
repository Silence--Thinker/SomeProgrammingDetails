### block的定义
#### 块字面量
--- 
块字面量的定义，没有名称，所以有时我们也叫*匿名函数*

	^(argument_list){};
	
	^(int n) {return  2 * n;};

#### 块指针定义
---
块指针的定义，跟函数指针的定义几乎相同，只是把函数的的指针`*`改成了块特有的`^`

	return_type (^name)(list of argument types);
	
	int (^doubler)(int a);
	
#### 块对外部参数的访问权限
* 对其封闭作用域中可见的`自动变量`的只读访问权限
* 对`函数`或者`方法`中声明的`静态变量`的读 / 写访问权限
* 对`外部变量`(即全局变量)的读 / 写访问权限
* 对声明为`块变量`的特殊变量的读 / 写访问权限

#### 块变量 
---
所谓块变量，即：使用__block修饰的变量。
快变量被其定义域中定义的任何共块享，在一个块变量的作用域中定义的任何块都可以读写那个变量。

	__block int j = 10;
	void (^blockPtr_1)(void) = ^(void){ j += 15; };
	void (^blockPtr_2)(void) = ^(void){ j += 25; };
	
	blockPtr_1();		// j 25
	blockPtr_2();		// j 50
跟其他自动变量一样，块变量一开始是在栈上分配的。但是如果复制一个引用块变量的块，就会把块变量与块一起从栈上移到堆上。

### block结构体信息
---
**main.m代码**

	int main(int argc, const char * argv[]) {
    	int i = 12;
	    void (^tempBlock)(void) = ^{
	    	printf("tempBlock string %zd\n", i);
   		 };
    	tempBlock();
    	return 0;
	}

想要了解block的结构组成，我们需要借助clang 工具重编译上面代码。我们可以粗浅的认为，block是怎么构建和实现的。实际上 clang 根本不会将 block 转换成人类可读的代码，它对 block 到底做了什么，谁也不知道。不要把C++编译的block当成是实际实现。

将main.m文件用clang工具翻译成main.cpp

	clang -rewrite-objc main.m

**main.cpp代码片段**

<pre><code>
// block 实现的结构体
struct __block_impl {
    void *isa;      // 实例对象
    int Flags;      // 按位承载block 的附加信息
    int Reserved;   // 保留变量
    void *FuncPtr;  // 函数指针，指向Block 要执行的函数
};

// block 实现的结构体，也是block 实现的入口
struct __main_block_impl_0 {
    
    struct __block_impl impl;           // block 实现的结构体变量
    struct __main_block_desc_0* Desc;   // 描述block 的结构体变量
    int i;
    // __main_block_impl_0              // 结构体的构造函数，初始化 impl 和 Desc
    // 每一个类型的Block 他们的构造函数是不同的,捕捉的外部变量不同
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _i, int flags=0) : i(_i) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

// bolck 实现函数 这个函数的返回值对应block的返回值，代码即:block的实现
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
    int i = __cself->i; // bound by copy
    
    printf("tempBlock string %zd\n", i);
}

// block 描述信息结构体
static struct __main_block_desc_0 {
    size_t reserved;               // 结构体信息保留字段
    size_t Block_size;             // 结构体大小
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};

int main(int argc, const char * argv[]) {
    int i = 12;
    void (*tempBlock)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, i));
    ((void (*)(__block_impl *))((__block_impl *)tempBlock)->FuncPtr)((__block_impl *)tempBlock);
    
    return 0;
}
</code></pre>

### block 实现的执行流程
![](./block调用过程/未命名.001.jpeg)

### block 总共有几种形式
---
从`__block_impl`里面有一个指向实例对象isa指针看出，block 本身也是一个 Objective-C 对象。block 的三种类型：`_NSConcreteStackBlock`、`_NSConcreteGlobalBlock`、`_NSConcreteMallocBlock`，即当代码执行时，isa 有三种值

	impl.isa = &_NSConcreteStackBlock; 
	impl.isa = &_NSConcreteMallocBlock; 
	impl.isa = &_NSConcreteGlobalBlock;

#### _NSConcreteStackBlock
#### _NSConcreteMallocBlock
#### _NSConcreteGlobalBlock

### block __block修饰符的实现
### block ARC下的内存管理
### block MRC下的内存管理

### block 应该注意的事项
##### 块变量在MRC下 
* 块变量修饰的是：自动变量
* 块变量修饰的是：局部静态变量、全局静态变量、全局变量

##### 块变量在ARC下
* 块变量修饰的是：自动变量
* 块变量修饰的是：局部静态变量、全局静态变量、全局变量