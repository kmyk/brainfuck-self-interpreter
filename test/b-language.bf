[ http://golf.shinh.org/p.rb?The+B+Programming+Language ]

symbols:
    exit 0
    E 1
    X 2
    Y 3
    Z 4
    $ 5

+++++ push $
>+ push E
[
    switch
    >+<
    [-
        [-
            [-
                [-
                    [
                        >- case $
                            x 0 *0
                            < ++++ +++++ [> +++++ +++++ > + <<-]
                            x *0 100 10
                            +<[->- true 116 114 117 101
                                0 *0 100 10
                                >>--[<++<+>>-]
                                0 8 116 *0
                                <.--.+++. t r u
                                <[>-->+<<-]>.>++. e newline
                                [[-]<]
                                0 *0 0 0
                            <]>[- false 102 97 108 115 101
                                0 *0 100 10
                                >++.-----. f a
                                +++++++++++.+++++++. l s
                                --------------. e
                                >. newline
                                [[-]<]
                                0 *0 0 0
                            ]
                            <+++++ push $
                            >+> push E
                            $ E 0 *0
                    ]
                    >[- case Z
                        k x y z 0 *0
                        <<<<[->>[-]<[>+<-]<] if x then move y to z
                        k *0 0 z
                        <[>+<-]>>>[<<<+>>>-] swap
                        z k 0 *0
                    ]<
                ]
                >[ case Y
                    k 0 *0
                    ,,,,,[-] e l s e space
                    <++++ push Z
                    >+>> push E
                    k Z E 0 *0
                ]<
            ]
            >[ case X
                k 0 *0
                ,,,,,[-] t h e n space
                <+++ push Y
                >+>> push E
                k Y E 0 *0
            ]<
        ]
        >[- case E
            k 0 *0
            >,+[
                k 0 0 *c
                switch
                < +++++ +++++ [> ----- ----- <-] + >--- 103
                k 0 flg *c
                [---
                    [[-]<-< case t
                        k *0
                        <[>+<-]+ push 1 swap
                        *1 k
                        >>>>,,< r u
                        1 k 0 *0 dummy
                    ]
                    <[< case i
                        k *0
                        ++ push X
                        > push E
                        >
                        k X E *0 0
                    ]>
                ]
                <[-< case f
                    k *0
                    <[>+<-] swap
                    >>>>,,,<< a l s
                    0 k *0 0 dummy
                ]>
                k 0 *0 dummy
                >,,[-]< clear
                k 0 *0
            ]
        ]<
    ]
    <
]

!true
false
if true then false else true
if false then false else true
if if true then false else false then true else false
if if true then true else false then true else false
if if if true then true else true then true else true then true else true
