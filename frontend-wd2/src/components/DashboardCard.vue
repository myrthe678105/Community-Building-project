<template>
    <div @click="$emit('click')" class="cursor-pointer bg-gradient-to-r from-[#DEC1DB] to-[#2F80E4] p-6 rounded-lg shadow hover:scale-105 transition transform">
      <h3 class="text-black text-xl font-sans">{{ title }}</h3>
    </div>
  </template>
  
  <script setup>
  defineProps(['title'])
  </script>
  