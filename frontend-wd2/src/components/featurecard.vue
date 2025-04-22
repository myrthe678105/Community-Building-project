<template>
  <div
    class="p-6 rounded-lg shadow-md text-center"
    :class="cardBgClass"
  >
    <h3 class="text-xl font-semibold text-gray-900 mb-2">{{ title }}</h3>
    <p class="text-gray-600">{{ description }}</p>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  title: String,
  description: String,
  bg: {
    type: String,
    default: 'white'
  },
});

const cardBgClass = computed(() => {
  //  allowed background colors to Tailwind classes
  const bgMap = {
    'green': 'bg-green-100',
    'yellow': 'bg-yellow-100',
    'pink': 'bg-pink-100',
    'indigo': 'bg-indigo-100'
  };
  
  // Return the mapped class or default to white
  return bgMap[props.bg] || 'bg-white';
});
</script>