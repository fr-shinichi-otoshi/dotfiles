import { runTool } from './run-tool.mjs';

runTool('textlint', [
  '--config',
  '.textlintrc.json',
  '--cache',
  '--cache-location',
  '.cache/textlint/.textlintcache',
  'docs/**/*.md',
  '../README.md',
]);
