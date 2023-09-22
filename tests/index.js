import Schematron from "../src/Schematron.js";
import fs from "fs";
import { URL } from "url";
import { spawn } from "node:child_process";

const FILES_DIR = new URL("./tei", import.meta.url).pathname;
const RNG_FILE = new URL("./rng/tei_all.rng", import.meta.url).pathname;

const rng = fs.readFileSync(RNG_FILE, "utf-8");
const files = fs.readdirSync(FILES_DIR).map((file) => {
  return {
    file,
    content: fs.readFileSync(`${FILES_DIR}/${file}`, "utf-8"),
  };
});

(async function () {
  await testWithSchematron();
  await testWithExec();
})();

async function testWithSchematron() {
  console.log("**********Testing without the use of exec**********");
  const sch = new Schematron();
  // Now set the RelaxNG
  await sch.setRNG(rng);
  await validateWithSchematron(sch);
  // Just set up some tests
}

async function testWithExec() {
  console.log("**********Testing with exec**********");
  const sch = new Schematron({
    useExec: true,
  });
  await sch.setRNG(rng);
  await validateWithSchematron(sch);
  // Now get the schematron stuff out of
}

async function validateWithSchematron(sch) {
  for (const { file, content } of files) {
    const t1 = performance.now();
    console.log(`=== START: Validating ${file} ===`);
    const results = await sch.validate(content);
    console.log(results);
    const t2 = performance.now();
    console.log(`=== END: Validating ${file}: Took ${t2 - t1}ms`);
  }
}
