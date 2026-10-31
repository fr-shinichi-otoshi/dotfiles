/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  guide: [
    'intro',
    'getting-started',
    {
      type: 'category',
      label: '整備者向け',
      collapsed: false,
      items: ['docker-validation', 'maintenance', 'site-development'],
    },
  ],
};

export default sidebars;
