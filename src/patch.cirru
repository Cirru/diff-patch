
var
  listUtil $ require :./util/list

var insertHelper $ \ (list index value result)
  cond (is index 0)
    result.concat ([] value) (list.slice 1)
    insertHelper (list.slice 1) (- index 1) value
      result.concat $ [] $ . list 0

var removeHelper $ \ (list index result)
  cond (is index 0)
    result.concat $ list.slice 1
    removeHelper (list.slice 1) (- index 1)
      result.concat $ [] $ . list 0

var patchTree $ \ (original change)
  -- console.log :patchTree original change
  case true
    (> change.path.length 1)
      var pathHead $ . change.path 0
      var nestedChange $ {}
        :op change.op
        :path $ change.path.slice 1
        :value change.value
      listUtil.flatMap original $ \ (item index)
        cond (is index pathHead)
          [] $ patchTree item nestedChange
          [] item
    (is change.path.length 1)
      var pathHead $ . change.path 0
      case true
        (is change.op :-)
          removeHelper original pathHead (array)
        (is change.op :+)
          insertHelper original pathHead change.value (array)
        else
          throw ":unknow op"
          , undefined
    else
      throw ":empty path is invalid"
      , undefined

var updateTree $ \ (original records)
  cond (is records.length 0) original
    updateTree
      patchTree original $ . records 0
      records.slice 1

= module.exports $ \ (original diff)
  updateTree original diff.records
