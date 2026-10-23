<script setup>
import { onMounted, ref } from 'vue';

const isActive = ref(false);

onMounted(() => {
  isActive.value = Boolean(document.getElementById('mos-topbar-style'));
});
</script>

<template>
  <v-container fluid class="pa-4">
    <div class="d-flex align-center ga-3 mb-4">
      <v-icon size="28">mdi-page-layout-header</v-icon>
      <div>
        <h2 class="text-h6">Top Menu Bar</h2>
        <div class="text-body-2 text-medium-emphasis">MOS-Navigation als horizontale Menüleiste</div>
      </div>
    </div>

    <v-alert :type="isActive ? 'success' : 'warning'" variant="tonal" density="compact">
      {{ isActive ? 'Die obere Menüleiste ist aktiv.' : 'Die Menüleisten-Styles fehlen. Installiere das Plugin erneut über MOS Hub.' }}
    </v-alert>

    <p class="text-body-2 mt-4">
      Die ursprünglichen MOS-Menüeinträge bleiben erhalten und führen weiterhin zu ihren normalen Seiten.
    </p>
  </v-container>
</template>