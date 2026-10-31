import { spawnSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const require = createRequire(import.meta.url);
const projectDirectory = fileURLToPath(new URL('../', import.meta.url));

export function runTool(name, args) {
  const packagePath = require.resolve(`${name}/package.json`);
  const { bin } = JSON.parse(readFileSync(packagePath, 'utf8'));
  const executable = typeof bin === 'string' ? bin : bin[name];
  const result = spawnSync(
    process.execPath,
    [
      path.resolve(path.dirname(packagePath), executable),
      ...args,
      ...process.argv.slice(2),
    ],
    { cwd: projectDirectory, stdio: 'inherit' },
  );

  if (result.error) {
    console.error(result.error.message);
  }

  process.exit(result.status ?? 1);
}
