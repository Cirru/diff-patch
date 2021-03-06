
var bind $ \ (v k)
  k v

var findMaxHelper $ \ (list memory method)
  if (and (is list.length 0) (not $ ? memory)) $ do
    throw ":Empty list to find max!"
  cond (> list.length 0)
    findMaxHelper (list.slice 1)
      bind (. list 0) $ \ (first)
        cond (? memory)
          cond (> (method memory) (method first)) memory first
          , first
      , method
    , memory

var manualConcat $ \ (a b)
  a.concat b

var flatMapHelper $ \ (list index method results)
  cond (is list.length 0) results
    flatMapHelper (list.slice 1) (+ index 1) method
      results.concat $ method (. list 0) index

var flatMap $ \ (list method)
  flatMapHelper list 0 method (array)

= exports.findMaxHelper findMaxHelper
= exports.manualConcat manualConcat
= exports.flatMap flatMap
