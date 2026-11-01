/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  guide: [
    'intro',
    'getting-started',
    'update',
    'troubleshooting',
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
