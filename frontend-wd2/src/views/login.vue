<template>
    <div class="flex flex-col items-center justify-center py-12">
      <div v-if="registrationSuccess" class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6 max-w-md w-full" role="alert">
        <p>Registration successful! Please login with your credentials.</p>
      </div>
      
      <AuthForm :isRegister="false" />
    </div>
  </template>
  
  <script setup>
  import { computed } from 'vue'
  import { useRoute } from 'vue-router'
  import AuthForm from '../components/authform.vue'
  
  const route = useRoute()
  const registrationSuccess = computed(() => route.query.registered === 'success')
  </script>