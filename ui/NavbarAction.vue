<template>
  <!-- Platzierung erfolgt über den Navbar-Slot oben rechts -->
  <v-btn
    icon
    variant="text"
    color="primary"
    @click="navigateToProfile"
    title="Zum Profil wechseln"
    class="mr-2"
  >
    <!-- Ein unaufdringliches, aber klares Profil-Icon (Unraid-Style) -->
    <v-icon size="large">mdi-account-circle-outline</v-icon>
  </v-btn>
</template>

<script setup>
import { useRouter } from 'vue-router';

// Zugriff auf den globalen MOS-Router
const router = useRouter();

const navigateToProfile = () => {
  // Führt den internen Wechsel auf die /profile Route aus
  router.push('/profile');
};
</script>

<style scoped>
/* Optional: Unraid-Orange-Azentuierung beim Drüberfahren (Hover) */
.v-btn:hover {
  color: #ff4500 !important;
  transform: scale(1.05);
  transition: all 0.2s ease-in-out;
}
</style>
