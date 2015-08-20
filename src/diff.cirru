
var
  type $ require :type-of
  listUtil $ require :./util/list

var search $ \ (path a b ia ib match delta records)
  -- console.log :search path a b ia ib match delta records
  var
    isAEnd $ is a.length 0
    isBEnd $ is b.length 0
    bothEnd $ and isAEnd isBEnd
  case true
    bothEnd $ [] $ record match delta records
    isAEnd
      var bFirst $ . b 0
      search path (array) (b.slice 1) ia (+ ib 1) match (+ delta 1)
        records.concat $ op :+ path ib bFirst
    isBEnd
      var aFirst $ . a 0
      search path (a.slice 1) (array) (+ ia 1) ib match (+ delta 1)
        records.concat $ op :- path ib aFirst
    else
      var
        aFirst $ . a 0
        bFirst $ . b 0
        isMatch $ is aFirst bFirst
        bothList $ and
          is (type aFirst) :array
          is (type bFirst) :array
      case true
        isMatch $ search path (a.slice 1) (b.slice 1)
          + ia 1
          + ib 1
          , (+ match 1) delta records
        bothList
          var bestResult
            searchOne (path.concat ib) aFirst bFirst records
          cond
            > bestResult.match bestResult.delta
            search path (a.slice 1) (b.slice 1)
              + ia 1
              + ib 1
              + match bestResult.match 1
              + delta bestResult.delta
              , bestResult.records
            searchBranch path a b ia ib match delta records
        else $ searchBranch path a b ia ib match delta records

var searchBranch $ \ (path a b ia ib match delta records)
  var
    aFirst $ . a 0
    bFirst $ . b 0
  listUtil.manualConcat
    search path (a.slice 1) b (+ ia 1) ib match (+ delta 1)
      records.concat $ op :- path ib aFirst
    search path a (b.slice 1) ia (+ ib 1) match (+ delta 1)
      records.concat $ op :+ path ib bFirst

var op $ \ (name path index value)
  {} (:op name) (:path $ path.concat index) (:value value)

var record $ \ (match delta records)
  {} (:match match) (:delta delta) (:records records)

var searchOne $ \ (path a b records)
  var allResults $ search path a b 0 0 0 0 records
  listUtil.findMaxHelper allResults null $ \ (x) (- x.match x.delta)

= module.exports $ \ (a b)
  searchOne (array) a b (array)
