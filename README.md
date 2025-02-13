# Schematron validation in node

Small proof-of-concept / experimental module for schematron validation in JS.

## Install

(See ./tests/index.js for an example)

1. If you're using NPM, then you should be able to install like so:

```
npm i node-xsl-schematron

```

2. Then include Schematron:

```
import Schematron from "node-xsl-schematron";

```

## How to use

1. Create a new Schematron object:

```js
import Schematron from "node-xsl-schematron";
const sch = new Schematron();
```
Note that you do not need to set any options; however, setting the `useExec` option to `true` provides significant speed up (at the cost of needing to use `xslt3`):

```js
import Schematron from "node-xsl-schematron";
const sch = new Schematron({
    useExec: true
})
```

2. Set the RNG contents (i.e. text) from which the schematron should be extracted or the schematron text itself (Note that these methods both return Promises):

```js
import Schematron from "node-xsl-schematron";
const sch = new Schematron();
await sch.setRNG(myRNGText);
// OR, if you have a schematron file
await sch.setSchematron(mySCHText);
```

3. The `validate()` method validates an XML file against the configured schematron and returns an array of validation result objects:

```js
import Schematron from "node-xsl-schematron";
const sch = new Schematron();
await sch.setRNG(myRNGText);
const results = await sch.validate(myXMLFile);
console.log(results);

/* Returns: 
[
  {
    location: '/Q{http://www.tei-c.org/ns/1.0}TEI[1]/Q{http://www.tei-c.org/ns/1.0}text[1]/Q{http://www.tei-c.org/ns/1.0}body[1]/Q{http://www.tei-c.org/ns/1.0}p[1]/Q{http://www.tei-c.org/ns/1.0}p[1]',
    test: '(ancestor::tei:ab or ancestor::tei:p) and not( ancestor::tei:floatingText |parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )',
    text: 'Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.'
  }
] 
* /

```

## Misc

* Regenerate the SEF files: `npm run sef` 
* Run tests: `npm run test`