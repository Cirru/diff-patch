
Cirru Diff/Patch
----

Diff/Patch for Cirru Syntax Tree.

### Usage

```
npm i --save cirru-diff-patch
```

```coffee
diff = require('cirru-diff-patch/lib/diff')
patch = require('cirru-diff-patch/lib/patch')

change = diff treeA, treeB
result = patch treeA, change
```

### Test

```
cirru-script test/simple.cirru
```

### License

MIT
