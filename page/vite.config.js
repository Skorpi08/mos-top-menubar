import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import federation from '@originjs/vite-plugin-federation';
import { mkdirSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import pluginConfig from './plugin.config.js';

const pluginVersion = process.env.PLUGIN_VERSION || pluginConfig.version;

const generateManifest = {
  name: 'generate-plugin-manifest',
  closeBundle() {
    const outputDir = resolve('dist', pluginConfig.name);
    const manifest = {
      name: pluginConfig.name,
      displayName: pluginConfig.displayName,
      description: pluginConfig.description,
      version: pluginVersion,
      icon: pluginConfig.icon,
      author: pluginConfig.author,
      homepage: pluginConfig.homepage,
      widget: pluginConfig.widget,
    };

    mkdirSync(outputDir, { recursive: true });
    writeFileSync(resolve(outputDir, 'manifest.json'), `${JSON.stringify(manifest, null, 2)}\n`);
  },
};

export default defineConfig({
  define: {
    __PLUGIN_VERSION__: JSON.stringify(pluginVersion),
  },
  plugins: [
    vue(),
    federation({
      name: pluginConfig.name,
      filename: 'remoteEntry.js',
      exposes: {
        './Plugin': './src/Plugin.vue',
      },
      shared: ['vue'],
    }),
    generateManifest,
  ],
  build: {
    target: 'esnext',
    minify: false,
    cssCodeSplit: false,
    outDir: `dist/${pluginConfig.name}`,
    assetsDir: '',
    rollupOptions: {
      input: {},
    },
  },
});