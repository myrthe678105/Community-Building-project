<template>
    <div class="flex flex-col items-center justify-center py-12">
      <AuthForm :isRegister="true" />
    </div>
  </template>
  
  <script setup>
  import AuthForm from '../components/authform.vue'
  </script>