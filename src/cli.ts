#!/usr/bin/env node

import { Command } from "commander";
import { hello } from "./index";

const program = new Command();

program
  .name("nbcode")
  .description("一个现代 Node.js CLI 工具模板")
  .version("0.1.0")
  .option("-n, --name <name>", "用于问候的名字", "World")
  .action((options: { name: string }) => {
    console.log(hello(options.name));
  });

program.parse();
