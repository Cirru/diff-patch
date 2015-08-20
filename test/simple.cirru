
var
  diff $ require :../src/diff

var a $ [] :a :b :c
  [] :d :e :f
    [] :g :h :1
  , :i

var b $ [] :a :b :c
  [] :d :e :f
    [] :g :h
  , :i
  [] :2

console.log $ JSON.stringify (diff a b)
