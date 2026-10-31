import { runTool } from './run-tool.mjs';

runTool('eslint', [
  '.',
  '--max-warnings',
  '0',
  '--cache',
  '--cache-location',
  '.cache/eslint/.eslintcache',
  '--cache-strategy',
  'content',
]);
