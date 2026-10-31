import { runTool } from './run-tool.mjs';

runTool('stylelint', [
  'src/**/*.css',
  '--max-warnings',
  '0',
  '--cache',
  '--cache-location',
  '.cache/stylelint/.stylelintcache',
  '--cache-strategy',
  'content',
]);
