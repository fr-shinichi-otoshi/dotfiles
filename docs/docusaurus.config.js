import { themes as prismThemes } from 'prism-react-renderer';

const [owner, repository] = (
  process.env.GITHUB_REPOSITORY ?? 'fr-shinichi-otoshi/dotfiles'
).split('/');
const repositoryUrl = `https://github.com/${owner}/${repository}`;

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'dotfiles',
  tagline: 'Ubuntuから始めるローカル開発',
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
          sidebarPath: './sidebars.js',
          editUrl: ({ docPath }) =>
            `${repositoryUrl}/edit/main/docs/docs/${docPath}`,
          showLastUpdateTime: false,
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      },
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
  },
};

export default config;
