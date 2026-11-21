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
          items: [
            'tools/delta',
            'tools/lazygit',
            'tools/lefthook',
            'tools/gh',
            'tools/gitui',
            'tools/difftastic',
            'tools/actionlint',
            'tools/gitleaks',
            'tools/commitlint',
          ],
        },
        {
          type: 'category',
          label: 'ランタイムと IaC',
          collapsed: true,
          items: [
            'tools/node',
            'tools/uv',
            'tools/rust',
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
          items: ['tools/herdr', 'tools/hunk', 'tools/repomix', 'tools/serena'],
        },
        {
          type: 'category',
          label: '構造化データと構文',
          collapsed: true,
          items: ['tools/jq', 'tools/yq', 'tools/ast-grep', 'tools/tokei'],
        },
        {
          type: 'category',
          label: '検査と計測',
          collapsed: true,
          items: [
            'tools/shellcheck',
            'tools/shfmt',
            'tools/ruff',
            'tools/knip',
            'tools/osv-scanner',
            'tools/hyperfine',
          ],
        },
        {
          type: 'category',
          label: 'ネットワーク',
          collapsed: true,
          items: ['tools/xh', 'tools/watchexec'],
        },
        {
          type: 'category',
          label: '画像',
          collapsed: true,
          items: ['tools/oxipng', 'tools/cwebp'],
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
