import { runTool } from './run-tool.mjs';

runTool('prettier', [
  '--config',
  '.prettierrc.json',
  '--cache',
  '--cache-location',
  '.cache/prettier/.prettier-cache',
  '--cache-strategy',
  'content',
  '.',
  '../README.md',
  '../.github/workflows/docs.yml',
]);
