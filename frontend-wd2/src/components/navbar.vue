<template>
  <nav class="bg-[#5B61B2] text-[#EEE2DF] shadow-md font-serif">
    <div class="container mx-auto px-4">
      <div class="flex justify-between items-center py-4">
        <router-link to="/" class="text-3xl font-bold">Building Bulletin Board</router-link>

        <div class="hidden md:flex space-x-6">
          <!-- Not logged in -->
          <template v-if="!authStore.isAuthenticated">
            <router-link to="/" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Home</router-link>
            <router-link to="/login" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Login</router-link>
            <router-link to="/register" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Register</router-link>
          </template>

          <!-- Logged in (bewoner/lid or admin) -->
          <template v-else>
            <router-link to="/dashboard" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Dashboard</router-link>

            <!-- Admin panel for bestuur -->
            <template v-if="authStore.isAdmin">
              <router-link to="/admin" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Admin Panel</router-link>
            </template>

            <router-link to="/eventmanagement" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Events</router-link>
            <router-link to="/parking" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Parking</router-link>
            <button @click="logout" class="px-3 py-2 rounded hover:bg-[#6DA0E1]">Logout</button>
          </template>
        </div>

        <!-- Mobile menu button -->
        <div class="md:hidden">
          <button @click="toggleMobileMenu" class="text-[#EEE2DF] focus:outline-none">
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path v-if="!mobileMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16" />
              <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Mobile Links -->
      <div v-if="mobileMenuOpen" class="md:hidden">
        <div class="px-2 pt-2 pb-3 space-y-1">
          <!-- Not logged in -->
          <template v-if="!authStore.isAuthenticated">
            <router-link to="/" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Home</router-link>
            <router-link to="/login" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Login</router-link>
            <router-link to="/register" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Register</router-link>
          </template>

          <!-- Logged in -->
          <template v-else>
            <router-link to="/dashboard" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Dashboard</router-link>

            <template v-if="authStore.isAdmin">
              <router-link to="/admin" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Admin Panel</router-link>
            </template>

            <router-link to="/eventmanagement" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Events</router-link>
            <router-link to="/parking" class="block px-3 py-2 rounded hover:bg-[#6DA0E1]">Parking</router-link>
            <button @click="logout" class="block w-full text-left px-3 py-2 rounded hover:bg-[#6DA0E1]">Logout</button>
          </template>
        </div>
      </div>
    </div>
  </nav>
</template>


<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const mobileMenuOpen = ref(false)
const router = useRouter()

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const logout = () => {
  authStore.logout()
  mobileMenuOpen.value = false
  router.push('/') // Redirect to home
}
</script>
