<template>
  <div class="flex flex-col min-h-screen">
    <Navbar />
    <main class="flex-grow w-full max-w-[1600px] mx-auto px-0 py-6">
      <router-view />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import Navbar from './components/navbar.vue'
import Footer from './components/footer.vue'
</script>