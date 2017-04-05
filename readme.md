# Brainfuck Self Interpreter

## usage

`[`

this file (`readme.md`) is the source code; and the `!` sign is the separator between code and input; so

```
    $ ( cat $TARGET_SOURCE ; echo '!' ; cat $TARGET_INPUT ) | $META_INTERPRETER readme.md
```

`]`

## architecture

emulate multitape machine

*   3 tapes
*   5 track

the 1st track is used for temporary buffer and the head mark of tapes:

```
    + head mark
    >>>>>
```

## code track

the 2nd track is used for code; the 3rd one is for the pointer:

```
    >
    >+< pointer
```

load code until terminater character `!` (ascii code: 33)

```
    , <++++++++[>----<-]>- [ 33
        <++++++++[>++++<-]>+ 33
        >>>>>
    , <++++++++[>----<-]>- ] 33
```

return

```
    <
    -[+<<<<<-]+ head
    >>>>>
```

## data track

the 4th and 5th are for data (of the target level interpreter)

```
    >>>
    >+
```

return to the head

```
    <<<<
```

## execute

loop on the code

```
    >
    [
```

load the command onto the temporary track

```
        [<+> >>>>+<<<<-]
        <[>+<-]
        >>>>>
```

branch for commands

*   increment (ascii code: 43)
*   read (ascii code: 44)
*   decrement (ascii code: 45)
*   write (ascii code: 46)
*   left (ascii code: 60)
*   right (ascii code: 62)
*   while (ascii code: 91)
*   done (ascii code: 93)

```
        ->>>>>++++++[<<<<<------->>>>>-]<<<<< 43
        >>>>>+<<<<<
        [ switch
            - [ 44
                - [ 45
                    - [ 46
                        ---------- ---- [ 60
                            -- [ 62
                                ---------- ---------- --------- [ 91
                                    -- [ 93
                                        >>>>> - nop
                                        ++++++++++[<<<<<++++++++++>>>>>-] add 100 to remove the char safely
                                        <<<<<[-]>>>>>
                                        <<<<<
                                    ]
                                    >>>>> [- done
```

### done command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    [<<<+>>>>>+<<-]>>[<<+>>-]<< copy
    <<<[[-] if
        -[+<<<<<-]+ head
        >>
        -[+>>>>>-]+ code
        - remove the code pointer
        + use for the nest level
        [
            <<<<<
            <[<+>>+<-]>[<+>-]<< copy
            ->>++++++++++[<<--------->>-]<< 91
            >>+<<
            [ switch
                -- [ 93
                    >> - otherwise
                    ++++++++++[<<++++++++++>>-]
                    <<[-]>>
                    <<
                ]
                >> [- done
                    >>>>> + <<<<< increment
                ] <<
            ]
            >> [- while
                >>>>> - <<<<< decrement
            ] <<
            >>
            >>>>>[<<<<<+>>>>>-]<<<<< move
        ]
        +
        <<
    ]
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                                    ] <<<<<
                                ]
                                >>>>> [- while
```

### while command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    <<<+>>>[>>+<<-]>>[<<+<<<[-]>>>>>-]<< copy
    <<<[- unless
        -[+<<<<<-]+ head
        >>
        -[+>>>>>-]+ code
        - remove the code pointer
        + use for the nest level
        [
            >>>>>
            <[<+>>+<-]>[<+>-]<< copy
            ->>++++++++++[<<--------->>-]<< 91
            >>+<<
            [ switch
                -- [ 93
                    >> - otherwise
                    ++++++++++[<<++++++++++>>-]
                    <<[-]>>
                    <<
                ]
                >> [- done
                    <<<<< - >>>>> increment
                ] <<
            ]
            >> [- while
                <<<<< + >>>>> decrement
            ] <<
            >>
            <<<<<[>>>>>+<<<<<-]>>>>> move
        ]
        +
        <<
    ]
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                                ] <<<<<
                            ]
                            >>>>> [- right
```

### right command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    ->>>>>+ right
    <<<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                            ] <<<<<
                        ]
                        >>>>> [- left
```

### left command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    -<<<<<+ left
    <<<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                        ] <<<<<
                    ]
                    >>>>> [- write
```

### write command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    . write
    <<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                    ] <<<<<
                ]
                >>>>> [- decrement
```

### decrement command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    - decrement
    <<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
                ] <<<<<
            ]
            >>>>> [- read
```

### read command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    , read
    <<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
            ] <<<<<
        ]
        >>>>> [- increment
```

### increment command

```
    -[+<<<<<-]+ head
    >>>>
    -[+>>>>>-]+ data
    <
    + increment
    <<<
    -[+<<<<<-]+ head
    >>
    -[+>>>>>-]+ code
    >>>>>>>>
```

```
        ] <<<<<
```

### post processing

return

```
        -[+<<<<<-]+ head
```

increment the code pointer

```
        >>
        -[+>>>>>-]+ code
        ->>>>>+
        <
```

exit if the code character is `\0` (assume that the original source doesn't contains it)

```
    ]
```
