<script setup>
import { onMounted, reactive, ref } from 'vue';

const pluginName = 'top-menubar';
const themeOptions = [
  { title: 'Standard', value: 'standard' },
  { title: 'Kompakt', value: 'compact' },
  { title: 'Akzent', value: 'accent' },
];
const settings = reactive({ theme: 'standard' });
const isActive = ref(false);
const loading = ref(true);
const saving = ref(false);
const feedback = ref('');
const feedbackType = ref('success');

const authHeaders = () => ({
  Authorization: `Bearer ${localStorage.getItem('authToken') || ''}`,
});

async function loadSettings() {
  try {
    const response = await fetch(`/api/v1/mos/plugins/settings/${pluginName}`, {
      headers: authHeaders(),
    });
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }

    const savedSettings = await response.json();
    settings.theme = themeOptions.some((option) => option.value === savedSettings.theme)
      ? savedSettings.theme
      : 'standard';
  } catch (error) {
    feedbackType.value = 'error';
    feedback.value = `Einstellungen konnten nicht geladen werden: ${error.message}`;
  } finally {
    isActive.value = Boolean(document.getElementById('mos-topbar-style'));
    loading.value = false;
  }
}

async function saveSettings() {
  saving.value = true;
  feedback.value = '';

  try {
    const saveResponse = await fetch(`/api/v1/mos/plugins/settings/${pluginName}`, {
      method: 'POST',
      headers: {
        ...authHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(settings),
    });
    if (!saveResponse.ok) {
      throw new Error(`HTTP ${saveResponse.status}`);
    }

    const applyResponse = await fetch('/api/v1/mos/plugins/executefunction', {
      method: 'POST',
      headers: {
        ...authHeaders(),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ plugin: pluginName, function: 'apply_theme' }),
    });

    if (!applyResponse.ok) {
      feedbackType.value = 'warning';
      feedback.value = 'Theme wurde gespeichert und wird beim nächsten Start angewendet.';
      return;
    }

    feedbackType.value = 'success';
    feedback.value = 'Theme gespeichert; Anwendung gestartet. Bitte Seite neu laden, damit die Änderung sichtbar wird.';
  } catch (error) {
    feedbackType.value = 'error';
    feedback.value = `Theme konnte nicht gespeichert werden: ${error.message}`;
  } finally {
    saving.value = false;
    isActive.value = Boolean(document.getElementById('mos-topbar-style'));
  }
}

onMounted(() => {
  loadSettings();
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

    <v-alert :type="isActive ? 'success' : 'warning'" variant="tonal" density="compact" class="mb-4">
      {{ isActive ? 'Die obere Menüleiste ist aktiv.' : 'Die Menüleiste wird beim Speichern oder MOS-Start angewendet.' }}
    </v-alert>

    <v-alert v-if="feedback" :type="feedbackType" variant="tonal" density="compact" class="mb-4">
      {{ feedback }}
    </v-alert>

    <v-row align="center" class="mt-1">
      <v-col cols="12" sm="6" md="4">
        <v-select
          v-model="settings.theme"
          :items="themeOptions"
          item-title="title"
          item-value="value"
          label="Theme"
          variant="outlined"
          density="comfortable"
          :loading="loading"
          :disabled="loading || saving"
          hide-details
        />
      </v-col>
      <v-col cols="12" sm="auto">
        <v-btn
          color="primary"
          prepend-icon="mdi-content-save"
          :loading="saving"
          :disabled="loading || saving"
          @click="saveSettings"
        >
          Speichern
        </v-btn>
      </v-col>
    </v-row>

    <p class="text-body-2 mt-4">
      Die Auswahl bleibt bei Plugin-Updates erhalten und wird beim MOS-Start erneut angewendet.
    </p>
  </v-container>
</template>