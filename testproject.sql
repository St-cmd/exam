/*
 Navicat Premium Data Transfer

 Source Server         : mongo
 Source Server Type    : MongoDB
 Source Server Version : 40003
 Source Host           : localhost:27017
 Source Schema         : testproject

 Target Server Type    : MongoDB
 Target Server Version : 40003
 File Encoding         : 65001

 Date: 08/06/2021 22:47:38
*/


// ----------------------------
// Collection structure for admininfos
// ----------------------------
db.getCollection("admininfos").drop();
db.createCollection("admininfos");

// ----------------------------
// Documents of admininfos
// ----------------------------
db.getCollection("admininfos").insert([ {
    _id: ObjectId("603663c6c46a12376cf39fdb"),
    username: "admin",
    password: "$2a$10$Z2SMT6ABWJU3EZkMWAtup.HFCYx0DgfC5HK6WIXCfbLmfCM4Qg.s2",
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for categories
// ----------------------------
db.getCollection("categories").drop();
db.createCollection("categories");

// ----------------------------
// Documents of categories
// ----------------------------
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35a6729caab36a034cc7c"),
    name: "必修课",
    __v: NumberInt("0")
} ]);
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35a7429caab36a034cc7d"),
    name: "选修课",
    __v: NumberInt("0")
} ]);
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35a8329caab36a034cc7e"),
    pre: ObjectId("60a35a6729caab36a034cc7c"),
    name: "计算机网络原理",
    __v: NumberInt("0")
} ]);
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35a9929caab36a034cc7f"),
    pre: ObjectId("60a35a6729caab36a034cc7c"),
    name: "操作系统",
    __v: NumberInt("0")
} ]);
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35aba29caab36a034cc80"),
    pre: ObjectId("60a35a7429caab36a034cc7d"),
    name: "计算机图形学",
    __v: NumberInt("0")
} ]);
db.getCollection("categories").insert([ {
    _id: ObjectId("60a35ad929caab36a034cc81"),
    name: "数据结构",
    pre: ObjectId("60a35a6729caab36a034cc7c"),
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for choicequestions
// ----------------------------
db.getCollection("choicequestions").drop();
db.createCollection("choicequestions");
db.getCollection("choicequestions").createIndex({
    id: NumberInt("1")
}, {
    name: "id_1",
    background: true
});

// ----------------------------
// Documents of choicequestions
// ----------------------------
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60782a9eef0a4f1ee83985a4"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "从器件角度看，计算机经历了五代变化。但从系统结构看，至今绝大多数计算机仍属于（  ）计算机。",
        answerA: " 并行",
        answerB: "冯·诺依曼",
        answerC: " 智能",
        answerD: "串行",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60782aeeef0a4f1ee83985a5"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("4"),
        title: "以下有关运算器的描述，（   ）是正确的。",
        answerA: " 只做加法运算",
        answerB: "只做算术运算",
        answerC: "算术运算与逻辑运算",
        answerD: "只做逻辑运算",
        rightAnswer: "C"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60782b2cef0a4f1ee83985a6"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("5"),
        title: "常用的虚拟存储系统由（   ）两级存储器组成，其中辅存是大容量的磁表面存储器。",
        answerA: " cache-主存 ",
        answerB: "主存-辅存 ",
        answerC: "  cache-辅存  ",
        answerD: "通用寄存器-cache",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60842f43726e674670be67d0"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "下列关于虚设备技术的叙述中，哪一个是错误的？",
        answerA: "虚设备技术是指在一类设备上模拟另一类设备的技术",
        answerB: "引入虚设备技术是为了提高设备利用率",
        answerC: "通常采用虚设备技术是用低速设备来模拟高速设备",
        answerD: "SPOOLing技术是一类典型的虚设备技术",
        rightAnswer: "C"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a46f7b29caab36a034cc98"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "计算机系统中的存储器系统是指 ",
        answerA: "RAM存储器 ",
        answerB: "ROM存储器",
        answerC: "主存储器",
        answerD: "主存储器和外存储器",
        rightAnswer: "D"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a46fe029caab36a034cc99"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("4"),
        title: "冯·诺依曼机工作方式的基本特点是 ",
        answerA: "多指令流单数据流",
        answerB: "按地址访问并顺序执行指令",
        answerC: "堆栈操作 ",
        answerD: "存储器按内部选择地址",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a4921829caab36a034cc9d"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "周期挪用方式常用于________方式的输入/输出",
        answerA: "DMA",
        answerB: "中断",
        answerC: "程序传送",
        answerD: "通道",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f8385761e71250723c75"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("2"),
        title: "操作员接口是操作系统为用户提供的使用计算机系统的手段之一，该接口是指",
        answerA: "一组操作控制命令",
        answerB: "一组系统调用程序",
        rightAnswer: "A",
        answerC: "一条访管指令",
        answerD: "一条I／O指令"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f85c5761e71250723c76"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "在一个能提供多个用户同时直接输入、调试和运行自己程序的计算机系统中应配置",
        answerA: "批处理操作系统",
        answerB: "分时操作系统",
        rightAnswer: "B",
        answerC: "实时操作系统 ",
        answerD: "嵌入式操作系统"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f8835761e71250723c77"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("2"),
        title: "多道程序系统指的是",
        answerA: "在实时系统中同时运行多个程序",
        answerB: "同一时刻在一个处理器上运行多个程序",
        answerC: "在网络系统中同时运行多个程序",
        answerD: "在一个处理器上并发运行多个程序",
        rightAnswer: "D"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f8d45761e71250723c78"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("4"),
        title: "进程有若干属性，它们是",
        answerA: "进程是静态的、有多种状态；多个进程可以对应于相同的程序",
        rightAnswer: "D",
        answerB: "进程是动态的、只有一种状态；多个进程可以对应于相同的程序",
        answerC: "进程是动态的、有多种状态；多个进程不可以对应于相同的程序",
        answerD: "进程是动态的、有多种状态；多个进程可以对应于相同的程序"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f9005761e71250723c79"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("4"),
        title: "控制进程的原语中，创建原语的功能是",
        answerA: "分配工作区、建立进程控制块、置进程为运行态",
        answerB: "分配工作区、建立进程控制块、置进程为就绪态",
        answerC: "分配工作区、建立进程控制块、置进程为等待态",
        answerD: "分配工作区、建立进程控制块、置进程为挂起态",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f9275761e71250723c7a"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("5"),
        title: "操作系统会按若干原因选择进程运行，不是立即进入操作系统进行进程选择的情况是",
        answerA: "运行进程的时间片用完",
        answerB: "运行进程出错",
        answerC: "运行进程要等待某一事件发生 ",
        answerD: "有新进程进入就绪状态",
        rightAnswer: "D"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f9675761e71250723c7b"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "基址寄存器和界限寄存器是属于",
        answerA: "指令寄存器",
        answerB: "通用寄存器",
        answerC: "控制寄存器 ",
        answerD: "时钟寄存器",
        rightAnswer: "C"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a5f98d5761e71250723c7c"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "存储管理实际管理的是",
        answerA: "辅助存储器",
        answerB: "全部主存储器",
        answerC: "主存储器中的用户区",
        answerD: "主存储器中的系统区",
        rightAnswer: "C"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a6161c5761e71250723c89"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("2"),
        title: "在下列有关CRT显示器的叙述中，正确的论述为",
        answerA: "CRT由五部分组成：电子枪、聚焦系统、加速系统、磁偏转系统和荧光屏；",
        answerB: "聚焦系统：将电子束引向荧光屏特定的位置。",
        rightAnswer: "A",
        answerC: "磁偏转系统：将电子流聚焦成很窄的电子。",
        answerD: "减速系统：使电子束减速到应有的速度；"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a6163e5761e71250723c8a"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("3"),
        title: "使用下列二维图形变换矩阵，将产生的变换结果为",
        rightAnswer: "D",
        answerA: "图形放大2倍；",
        answerB: "图形放大2倍，同时沿X、Y坐标轴方向各移动1个绘图单位；",
        answerC: "沿X坐标轴方向各移动2个绘图单位；",
        answerD: "沿X坐标轴方向放大2倍，同时沿X、Y坐标轴方向各平移1个绘图单位。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a616655761e71250723c8b"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("5"),
        title: "在多边形的逐边裁剪法中,对于某条多边形的边(方向为从端点S到端点P)与某条裁剪线(窗口的某一边)的比较结果共有以下四种情况,分别需输出一些顶点.请问哪种情况下输出的顶点是错误的",
        answerA: "S和P均在可见的一侧,则输出S和P；",
        answerB: "S和P均在不可见的一侧,则输出0个顶点；",
        answerC: "S在可见一侧,P在不可见一侧,则输出线段SP与裁剪线的交点；",
        answerD: "S在不可见的一侧,P在可见的一侧,则输出线段SP与裁剪线的交点；",
        rightAnswer: "D"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a61b6e5761e71250723c96"),
    question: {
        category: {
            categoryId: "60a35ad929caab36a034cc81",
            categoryName: "数据结构"
        },
        rate: NumberInt("3"),
        title: "如哦某线性表最常用的操作是存取任一指定序号的元素和在最后进行差如和删除运算，则利用什么存储当时最节省时间",
        answerA: "顺序表",
        rightAnswer: "A",
        answerB: "双链表",
        answerC: "带头节点的双循环链表",
        answerD: "单循环链表"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("choicequestions").insert([ {
    _id: ObjectId("60a61c275761e71250723c97"),
    question: {
        category: {
            categoryId: "60a35ad929caab36a034cc81",
            categoryName: "数据结构"
        },
        rate: NumberInt("2"),
        title: "有六个元素6，5，4，3，2，1的顺序进栈，问下列哪一个不是合法的出栈序列",
        rightAnswer: "B",
        answerA: "543612",
        answerB: "346521",
        answerC: "453126",
        answerD: "543612"
    },
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for discussquestions
// ----------------------------
db.getCollection("discussquestions").drop();
db.createCollection("discussquestions");
db.getCollection("discussquestions").createIndex({
    id: NumberInt("1")
}, {
    name: "id_1",
    background: true
});

// ----------------------------
// Documents of discussquestions
// ----------------------------
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60782e56ef0a4f1ee83985aa"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "冯.诺依曼主要三个思想是什么？",
        rightAnswer: "（1）计算机硬件是由5大基本部分组成:运算器,控制器,存储器,输入设备,输出设备\n\n（2）采用二进制\n\n（3）程序和数据一样存放在存储器中"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60782e91ef0a4f1ee83985ab"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("4"),
        title: "计算机硬件由哪5部分组成？",
        rightAnswer: "运算器、控制器、存储器、输入设备、输出设备组成。\n\n（1）运算器（执行部件）：对数据进行算术运算和逻辑运算。主要由算术逻辑运算单元（核心），累加器，和寄存器组成。\n\n（2）控制器（指挥中心）：控制计算机各部件或器件自动协调动作，主要由控制单元，程序计数器和指令寄存器组成。功能是解释程序，按照程序的指令序列依次从存储器中取出命令，产生控制信号，并发送给各个部件或器件，指挥整个运算过程\n\n（3）存储器（存储中心）：用于存放程序和数据，主要由存储体、逻辑控制电路、数据与地址寄存器等组成。由一定数量的存储单元组成。\n\n（4）输入输出设备：输入设备=>将人们熟悉的信息形式转变为计算机能识别的二进制存入到内存中（键盘、鼠标、扫描仪、光笔等）。输入设备=>用于将存入在内存中的由计算机处理的结果转变为人们能接受的形式输出（显示器、打印机、绘图仪等）。\n"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60782eb8ef0a4f1ee83985ac"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "计算机内部信息包括哪两大信息？",
        rightAnswer: "（1）控制信息，即操作命令，其发源地为控制器；\n\n（2）数据流，它受控制信息的控制，从一部件流向另一部件，边流动边加工处理。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a4704929caab36a034cc9a"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "什么是总线？以总线组成计算机有哪几种组成结构？",
        rightAnswer: "总线（Bus）就是计算机中用于传送信息的公用通道，是为多个部件服务的一组信息传送连接线。按照总线的连接方式，计算机组成结构可以分为单总线结构、双总线结构和多总线结构等\n"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a4708b29caab36a034cc9b"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("4"),
        title: "什么是硬件、软件和固件？什么是软件和硬件的逻辑等价？在什么意义上软件和硬件是不等价的？",
        rightAnswer: "计算机硬件（Hardware）是指构成计算机的所有实体部件的集合，通常这些部件由电路（电子元件）、机械等物理部件组成。计算机软件（Software）是指能使计算机工作的程序和程序运行时所需要的数据，以及与这些程序和数据有关的文字说明和图表资料，其中文字说明和图表资料又称为文档。固件（Firmware）是一种介于传统的软件和硬件之间的实体，功能上类似软件，但形态上又是硬件。微程序是计算机硬件和软件相结合的重要形式。\n\n软件和硬件的逻辑等价含义：\n\n（1）任何一个由软件所完成的操作也可以直接由硬件来实现\n\n（2）任何一条由硬件所执行的指令也能用软件来完成\n\n在物理意义上软件和硬件是不等价的。\n"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a470b429caab36a034cc9c"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "计算机系统按程序设计语言划分为哪几个层次？",
        rightAnswer: "计算机系统是一个由硬件、软件组成的多级层次结构，它通常由微程序级、一般机器级、操作系统级、汇编语言级、高级语言级组成，每一级上都能创造程序设计，且得到下级的支持。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a5fff75761e71250723c86"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("2"),
        title: "简单叙述引入进程的意义。",
        rightAnswer: "1提高资源的利用率\n\n2正确的描述程序的执行情况\n\n"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a6000d5761e71250723c87"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "试述页式存储管理中高速缓冲寄存器(或快表)的作用。",
        rightAnswer: "为了提高存取速度，通常设置一个告诉缓冲期。利用高速缓冲器来存放页表的一部分，把存放的地址告诉缓冲器中的快表。快表登记了一部分页号和主存块号的关系，根据程序执行的局部性的特点，在一段时间里经常要访问某些页表，若该页表以登记在快表中，可快速查找，并提高指令的执行速度。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a600325761e71250723c88"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("4"),
        title: "“建立”文件和“打开”文件时针对文件目录的操作有什么不同?",
        rightAnswer: "建立文件是用户把一个新文件存放到存储介质上。\n\n打开文件是用户使用一个已经存放在存储介质上的文件。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a617f85761e71250723c93"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("2"),
        title: "简述梁-barsky裁剪算法的核心思想。",
        rightAnswer: "把这条被裁剪的线段看成是有方向的线段，该有向线段把窗口的四条边分成两类：入边和出边。这样一分的话，就发现了这样的现象，裁减结果的线段起点是这条无限长直线和两条入边的交点以及始端点三个点里最前面的一个点，即参数最大的那个点；裁剪线段的终点是和两条出边的交点以及端点取参数最小的那个点。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a619505761e71250723c94"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("3"),
        title: "请列举常用的直线段裁剪算法",
        rightAnswer: "直接求交算法、编码算法、中点再分算法、Cyrus-Beck算法"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a619a65761e71250723c95"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("4"),
        title: "什么叫做走样？什么叫做反走样？反走样技术包括哪些？",
        rightAnswer: "走样指的是用离散量表示连续量引起的失真。\n走样指的是用离散量表示连续量引起的失真.\n\n为了提高图形的显示质量。需要减少或消除因走样带来的阶梯形或闪烁效果，用于减少或消除这种效果的方\n为了提高图形的显示质量.需要减少或消除因走样带来的阶梯形或闪烁效果，用于减少或消除这种效果的方\n\n法称为反走样。\n法称为反走样.\n\n其方法是①前滤波，以较高的分辨率显示对象;②后滤波，即加权区域取样，在高于显示分辨率的较高分辨\n其方法是1前滤波，以较高的分辨率显示对象；2后滤波，即加权区域取样，在高于显示分辨率的较高分辨\n\n率下用点取样方法计算，然后对几个像素的属性进行平均得到较低分辨率下的像素属性。\n率下用点取样方法计算，然后对几个像素的属性进行平均得到较低分辨率下的像素属性.\n\n"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("discussquestions").insert([ {
    _id: ObjectId("60a61cc85761e71250723c9a"),
    question: {
        category: {
            categoryId: "60a35ad929caab36a034cc81",
            categoryName: "数据结构"
        },
        rate: NumberInt("2"),
        title: "数据结构中属于先行数据结构的有哪些",
        rightAnswer: "栈、队列、树、图等"
    },
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for judgedquestions
// ----------------------------
db.getCollection("judgedquestions").drop();
db.createCollection("judgedquestions");
db.getCollection("judgedquestions").createIndex({
    id: NumberInt("1")
}, {
    name: "id_1",
    background: true
});

// ----------------------------
// Documents of judgedquestions
// ----------------------------
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60782ee3ef0a4f1ee83985ad"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "程序计数器的位数取决于存储器的容量，指令寄存器的位数取决于指令字长。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60782f24ef0a4f1ee83985ae"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "浮点数数的表示范围取决于尾数的位数，精度取决于阶码的位数。",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60782f4bef0a4f1ee83985af"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "基地址寻址方式中，操作数的有效地址等于基址寄存器内容加上形式地址",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60782fffef0a4f1ee83985b1"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("5"),
        title: "DMA控制器通过中断向CPU发DMA请求信号。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60783014ef0a4f1ee83985b2"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("2"),
        title: "CPU访问存储器的时间是由存储器的容量决定的，存储器容量越大，访问存储器所需的时间越长。",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60843920726e674670be67d1"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "以批处理方式和交互方式控制作业运行都需要注册(LOGON)。",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a492f629caab36a034cc9e"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("3"),
        title: "计算机的外部设备是指远程通信设备",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a4932929caab36a034cc9f"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rate: NumberInt("4"),
        title: "在微型机系统中外部设备通过设备控制器与主板的系统总线相连接。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a5ff725761e71250723c83"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("2"),
        title: "在对索引结构的文件进行读／写前，先要把该文件的索引表读到主存储器。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a5ff875761e71250723c84"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("3"),
        title: "如果把一首乐曲作为一个文件存放，通常应该选用顺序存放作为这个文件的逻辑  结构。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a5ffac5761e71250723c85"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rate: NumberInt("4"),
        title: "用户程序中调用的设备与该程序运行时实际占用的设备有关，设备的这种特性称为设备独立性。",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a617045761e71250723c8f"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("2"),
        title: "在图形文件系统中，点、线、圆等图形元素通常都用其几何特征参数来描述；",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a617115761e71250723c90"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("3"),
        title: "在图形系统中，图形处理运算的精度不取决于显示器的分辨率；",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a6171b5761e71250723c91"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("4"),
        title: "在光栅扫描图形显示器中，所有图形都按矢量直接描绘显示，不存在任何处理；",
        rightAnswer: "B"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a617285761e71250723c92"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rate: NumberInt("3"),
        title: "在彩色图形显示器中，使用RGB颜色模型。",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("judgedquestions").insert([ {
    _id: ObjectId("60a61ca15761e71250723c99"),
    question: {
        category: {
            categoryId: "60a35ad929caab36a034cc81",
            categoryName: "数据结构"
        },
        rate: NumberInt("4"),
        title: "依据所有数据成员之间的逻辑关系不同，数据结构分为非线性结构和线性结构",
        rightAnswer: "A"
    },
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for multiplechoicequestions
// ----------------------------
db.getCollection("multiplechoicequestions").drop();
db.createCollection("multiplechoicequestions");
db.getCollection("multiplechoicequestions").createIndex({
    id: NumberInt("1")
}, {
    name: "id_1",
    background: true
});

// ----------------------------
// Documents of multiplechoicequestions
// ----------------------------
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60782b84ef0a4f1ee83985a7"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "C",
            "D"
        ],
        rate: NumberInt("2"),
        title: "描述多媒体CPU基本概念中，不正确的是（   ）",
        answerA: "多媒体CPU是带有MMX技术的处理器",
        answerB: "MMX是一种多媒体扩展结构",
        answerC: "MMX指令集是一种多指令流多数据流的并行处理指令",
        answerD: "多媒体CPU是以超标量结构为基础的CISC机器"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60782bc3ef0a4f1ee83985a8"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "A",
            "C"
        ],
        rate: NumberInt("3"),
        title: "请从下面浮点运算器中的描述中选出两个描述正确的句子（   ）",
        answerA: "浮点运算器可用两个松散连接的定点运算部件一阶码和尾数部件来实现。",
        answerB: "阶码部件可实现加，减，乘，除四种运算。",
        answerC: "阶码部件只进行阶码相加，相减和比较操作。",
        answerD: " 尾数部件只进行乘法和除法运算。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60782dc4ef0a4f1ee83985a9"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "C",
            "D"
        ],
        rate: NumberInt("3"),
        title: "描述PCI总线中基本概念不正确的句子是（  ）",
        answerA: "PCI总线是一个与处理器无关的高速外围设备",
        answerB: " PCI总线的基本传输机制是猝发式传送",
        answerC: "PCI设备一定是主设备",
        answerD: "系统中只允许有一条PCI总线"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a4998029caab36a034cca0"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "A",
            "D"
        ],
        rate: NumberInt("5"),
        title: "以下叙述中正确描述的是",
        answerA: "同一个CPU周期中，可以并行执行的微操作叫相容性微操作",
        answerB: "同一个CPU周期中，不可以并行执行的微操作叫相容性微操作",
        answerC: "同一个CPU周期中，可以并行执行的微操作叫相斥性微操作",
        answerD: "同一个CPU周期中，不可以并行执行的微操作叫相斥性微操作"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a49b6929caab36a034cca1"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "C",
            "D"
        ],
        rate: NumberInt("2"),
        title: "描述PCI总线中基本概念不正确的句子是",
        answerA: "PCI总线是一个与处理器无关的高速外围总线",
        answerB: "PCI总线的基本传输机制是猝发式传送",
        answerC: "PCI设备一定是主设备",
        answerD: "系统中只允许有一条PCI总线"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a4a03c29caab36a034cca2"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "A",
            "C"
        ],
        rate: NumberInt("4"),
        title: "下面浮点运算器的的描述中正确的句子是",
        answerA: "浮点运算器都可用阶码部件和为数部件实现",
        answerB: "阶码部件可实现加、减、乘、除四种运算",
        answerC: "阶码部件只进行阶码相加、相减和比较操作",
        answerD: "尾数部件只进行乘法和减法运算"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a4a19129caab36a034cca3"),
    question: {
        category: {
            categoryId: "60a35a8329caab36a034cc7e",
            categoryName: "计算机网络原理"
        },
        rightAnswer: [
            "B",
            "D"
        ],
        rate: NumberInt("2"),
        title: "同步传输之所以比异步传输具有较高的传输频率是因为同步传输",
        answerA: "不需要应答信号",
        answerB: "总线长度较短",
        answerC: "用一个公共时钟信号进行同步",
        answerD: "各部件存取时间较为接近"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5f9d15761e71250723c7d"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [
            "B",
            "D"
        ],
        rate: NumberInt("2"),
        title: "当中央处理器处于管态时，则",
        answerA: "不允许执行特权指令 ",
        answerB: "可以执行一切指令",
        answerC: "只能执行访管指令",
        answerD: "可以执行系统调用程序"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5f9fa5761e71250723c7e"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [
            "A",
            "B",
            "D"
        ],
        rate: NumberInt("3"),
        title: "进程有许多属性，它们是",
        answerA: "动态性",
        answerB: "并发性",
        answerC: "运行结果的确定性",
        answerD: "异步性"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5fa225761e71250723c7f"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [
            "A",
            "B",
            "C",
            "D"
        ],
        rate: NumberInt("3"),
        title: "中断有若干类型，它们是",
        answerA: "硬件故障中断 ",
        answerB: "程序中断",
        answerC: "外部中断",
        answerD: "输入/输出中断"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5fa455761e71250723c80"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [
            "B",
            "D"
        ],
        rate: NumberInt("4"),
        title: "决定文件记录在磁盘上的物理位置的参数之一是",
        answerA: "文件号",
        answerB: "扇区号",
        answerC: "记录号",
        answerD: "柱面号"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5fa845761e71250723c81"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [
            "B",
            "C",
            "D"
        ],
        rate: NumberInt("4"),
        title: "关于通道程序的正确描述是",
        answerA: "通道程序存放在主存储器中 ",
        answerB: "通道程序存放在辅助存储器中",
        answerC: "通道程序的指令属于CPU指令系统",
        answerD: "通道程序由CPU指令启动"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a5fbdf5761e71250723c82"),
    question: {
        category: {
            categoryId: "60a35a9929caab36a034cc7f",
            categoryName: "操作系统"
        },
        rightAnswer: [ ],
        rate: NumberInt("2"),
        title: "按照文件受保护的级别分类，可将文件分成什么类别",
        answerA: "只读文件",
        answerB: "读写文件",
        answerC: "执行文件",
        answerD: "不保护文件"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a6168a5761e71250723c8c"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rightAnswer: [
            "D",
            "C"
        ],
        rate: NumberInt("2"),
        title: "在下列对投影的描述里，正确的论述为",
        answerA: "透视投影中灭点最多可以有3个",
        answerB: "透视投影与平行投影相比，视觉效果更有真实感，而且能真实地反映物体的精确的尺寸和形状",
        answerC: "太阳光线产生的投影为平行投影。",
        answerD: "物体经过透视投影后可产生缩放的效果。"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a616ab5761e71250723c8d"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rightAnswer: [
            "A",
            "B"
        ],
        rate: NumberInt("4"),
        title: "下列有关曲线和曲面概念的叙述语句中，正确的论述为",
        answerA: "多边形表示和参数表示是3D曲面曲面造型系统中的主要造型技术",
        answerB: "参数形式和隐含形式都是精确的解析表示法，但在计算机图形学中，参数形式更好用",
        answerC: "在计算机图形学中，参数曲线通常是有理多项式，且其阶次越高越好",
        answerD: "从描述复杂性和形状灵活性考虑，最常用的参数曲线是2次有理多项式的曲线"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a616ea5761e71250723c8e"),
    question: {
        category: {
            categoryId: "60a35aba29caab36a034cc80",
            categoryName: "计算机图形学"
        },
        rightAnswer: [
            "A",
            "B",
            "C"
        ],
        rate: NumberInt("3"),
        title: "下列有关B样条曲线性质的叙述语句中，错误的论述为",
        answerA: "B样条曲线具有局部可控性，K阶B样条曲线只受相邻的K个顶点控制；",
        answerB: "对Bezier曲线来说，阶数和次数是一样的；但对B样条，阶数是次数减1",
        answerC: "B样条曲线的几何形状与坐标系有关",
        answerD: "B样条曲线的几何形状与坐标系无关"
    },
    __v: NumberInt("0")
} ]);
db.getCollection("multiplechoicequestions").insert([ {
    _id: ObjectId("60a61c705761e71250723c98"),
    question: {
        category: {
            categoryId: "60a35ad929caab36a034cc81",
            categoryName: "数据结构"
        },
        rightAnswer: [
            "A",
            "B",
            "C"
        ],
        rate: NumberInt("3"),
        title: "算法的设计要求包括",
        answerA: "正确性",
        answerB: "可读性",
        answerC: "健壮性",
        answerD: "确定性"
    },
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for userinfos
// ----------------------------
db.getCollection("userinfos").drop();
db.createCollection("userinfos");

// ----------------------------
// Documents of userinfos
// ----------------------------
db.getCollection("userinfos").insert([ {
    _id: ObjectId("6011886e74161140148b99ce"),
    username: "无名氏",
    password: "123",
    __v: NumberInt("0")
} ]);
db.getCollection("userinfos").insert([ {
    _id: ObjectId("60366583c46a12376cf39fde"),
    username: "11",
    password: "$2a$10$bBGx0786B.ynyGRhSVs8Y.qp4/VQH93APfzakXdOOPXrCiPsnsJnK",
    __v: NumberInt("0")
} ]);
db.getCollection("userinfos").insert([ {
    _id: ObjectId("603665a2c46a12376cf39fdf"),
    username: "22",
    password: "$2a$10$CayHc2z8Un3SKmc6LG/ueuzKenneLxDDzR.LZnp6jiZcriAA4alqq",
    __v: NumberInt("0")
} ]);
db.getCollection("userinfos").insert([ {
    _id: ObjectId("60366677c46a12376cf39fe0"),
    username: "ww",
    password: "$2a$10$bNjaQ8HsFqg55tCvQucUL.tvIAjaKX9Mhz7ZjsC8oq38y1L3PGEau",
    __v: NumberInt("0")
} ]);
db.getCollection("userinfos").insert([ {
    _id: ObjectId("60a5b8bc8999d43b74c9ee96"),
    username: "aa",
    password: "$2a$10$A1vvV9T7w.rGj0ggQjy4v.tp/7u64OJRQCxdxdAiv2b/Eti0S9n0G",
    __v: NumberInt("0")
} ]);

// ----------------------------
// Collection structure for wrongquestions
// ----------------------------
db.getCollection("wrongquestions").drop();
db.createCollection("wrongquestions");

// ----------------------------
// Documents of wrongquestions
// ----------------------------
db.getCollection("wrongquestions").insert([ {
    _id: ObjectId("60a5ac2f8999d43b74c9ee95"),
    questionId: "60782a9eef0a4f1ee83985a4",
    categoryId: "60a35a8329caab36a034cc7e",
    username: "ww",
    __v: NumberInt("0")
} ]);
