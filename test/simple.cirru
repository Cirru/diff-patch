
var
  diff $ require :../src/diff
  patch $ require :../src/patch

var a $ [] :a :b :c
  [] :d :e :f
    [] :g :h :1
  , :i

var b $ [] :a :b :c
  [] :d :e :f
    [] :g :h
  , :i
  [] :2

var change $ diff a b
console.log :a $ JSON.stringify a
console.log :b $ JSON.stringify b
console.log :change $ JSON.stringify change
console.log :b $ JSON.stringify $ patch a change
