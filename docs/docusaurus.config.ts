import type * as Preset from '@docusaurus/preset-classic';
import type { Config } from '@docusaurus/types';
import { themes as prismThemes } from 'prism-react-renderer';

const [owner, repository] = (
  process.env.GITHUB_REPOSITORY ?? 'fr-shinichi-otoshi/dotfiles'
).split('/');
const repositoryUrl = `https://github.com/${owner}/${repository}`;

const config: Config = {
  title: 'dotfiles',
  tagline: 'Ubuntuから始めるローカル開発',
  favicon: 'img/favicon.svg',
  url: `https://${owner}.github.io`,
  baseUrl: repository === `${owner}.github.io` ? '/' : `/${repository}/`,
  organizationName: owner,
  projectName: repository,
  trailingSlash: true,
  onBrokenLinks: 'throw',
  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'throw',
      onBrokenMarkdownImages: 'throw',
    },
  },
  i18n: {
    defaultLocale: 'ja',
    locales: ['ja'],
  },
  presets: [
    [
      'classic',
      {
        docs: {
          path: './docs',
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          editUrl: ({ docPath }) =>
            `${repositoryUrl}/edit/main/docs/docs/${docPath}`,
          showLastUpdateTime: false,
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],
  themeConfig: {
    navbar: {
      title: 'dotfiles',
      items: [
        {
          type: 'doc',
          docId: 'getting-started',
          label: 'セットアップ',
          position: 'left',
        },
        {
          type: 'doc',
          docId: 'tools/index',
          label: 'ツール',
          position: 'left',
        },
        { href: repositoryUrl, label: 'GitHub', position: 'right' },
      ],
    },
    colorMode: {
      defaultMode: 'light',
      respectPrefersColorScheme: true,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bash', 'powershell', 'toml', 'git', 'yaml'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
