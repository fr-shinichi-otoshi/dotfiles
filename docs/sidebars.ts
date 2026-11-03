import type { SidebarsConfig } from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  guide: [
    'intro',
    'getting-started',
    'update',
    'troubleshooting',
    {
      type: 'category',
      label: 'ツール',
      collapsed: false,
      link: {
        type: 'doc',
        id: 'tools/index',
      },
      items: [
        {
          type: 'category',
          label: '基盤',
          collapsed: true,
          items: [
            'tools/chezmoi',
            'tools/mitamae',
            'tools/mise',
            'tools/git',
            'tools/zsh',
            'tools/vim',
            'tools/docker',
            'tools/support-packages',
          ],
        },
        {
          type: 'category',
          label: 'シェル',
          collapsed: true,
          items: [
            'tools/fzf',
            'tools/ripgrep',
            'tools/fd',
            'tools/eza',
            'tools/sheldon',
            'tools/starship',
            'tools/atuin',
            'tools/broot',
            'tools/gping',
          ],
        },
        {
          type: 'category',
          label: 'Git',
          collapsed: true,
          items: ['tools/delta', 'tools/lazygit', 'tools/lefthook', 'tools/gh'],
        },
        {
          type: 'category',
          label: 'ランタイムと IaC',
          collapsed: true,
          items: [
            'tools/node',
            'tools/uv',
            'tools/terraform',
            'tools/tflint',
            'tools/terraform-docs',
          ],
        },
        {
          type: 'category',
          label: '検索とコンテナ',
          collapsed: true,
          items: ['tools/ripgrep-all', 'tools/lazydocker'],
        },
        {
          type: 'category',
          label: '秘密情報',
          collapsed: true,
          items: ['tools/age', 'tools/sops'],
        },
        {
          type: 'category',
          label: 'エージェントとレビュー',
          collapsed: true,
          items: ['tools/herdr', 'tools/hunk'],
        },
      ],
    },
    {
      type: 'category',
      label: '整備者向け',
      collapsed: false,
      items: [
        'architecture',
        'maintenance',
        'docker-validation',
        'site-development',
      ],
    },
  ],
};

export default sidebars;
