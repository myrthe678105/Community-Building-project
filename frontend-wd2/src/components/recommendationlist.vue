<template>
  <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-blue-200">
    <div class="p-4 bg-blue-100">
      <h2 class="text-2xl font-bold text-blue-800">🌟 Community Recommendations</h2>
    </div>

    <!-- Loading state -->
    <div v-if="loading" class="p-6 text-center text-blue-600 animate-pulse">
      Loading recommendations...
    </div>

    <!-- Error state -->
    <div v-else-if="error" class="p-6 text-center text-red-600">
      {{ error }}
    </div>
    <!-- Success state -->
    <div v-if="success" class="p-4 text-green-700 bg-green-100 border border-green-300 rounded">
      {{ success }}
    </div>


    <!-- Recommendation list -->
    <div v-else class="p space">
      <div 
        v-for="rec in recommendations" 
        :key="rec.id"
        class="bg-blue-50 p-4 rounded-lg shadow-sm border border-blue-100"
      >
        <h3 class="font-semibold text-blue-900">{{ rec.title }}</h3>
        <p class="text-sm text-gray-700 mt-1">{{ rec.content }}</p>
        <p class="text-xs text-gray-500 mt-2">
          – {{ rec.user?.name || 'Anonymous' }} • {{ formatDate(rec.created_at) }}
        </p>
      </div>
    </div>

    <!-- Submission form -->
    <form @submit.prevent="submitRecommendation" class="bg-blue-50 p-4 border-t border-blue-200 mt-4 space-y-4">
      <h3 class="text-lg font-semibold text-blue-800">Add Your Recommendation</h3>
      <input 
        v-model="form.title" 
        type="text" 
        placeholder="Title" 
        class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
        required
      />
      <textarea 
        v-model="form.content" 
        placeholder="Description..." 
        class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
        rows="3"
        required
      ></textarea>
      <button 
        type="submit" 
        class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700"
      >
        Submit
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import api from '../services/api'

const authStore = useAuthStore()
const success = ref(null)


const recommendations = ref([])
const loading = ref(true)
const error = ref(null)

const form = ref({
  title: '',
  content: ''
})

const fetchRecommendations = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await api.get('/recommendations')
    recommendations.value = response.data.data
  } catch (err) {
    error.value = 'Failed to load recommendations.'
  } finally {
    loading.value = false
  }
}

const submitRecommendation = async () => {
  const authStore = useAuthStore()

  if (!authStore.user || !authStore.user.id) {
    error.value = 'You must be logged in to submit a recommendation.'
    return
  }

  try {
    await api.post('/recommendations', {
      title: form.value.title,
      content: form.value.content,
      user_id: authStore.user.id
    })
    form.value.title = ''
    form.value.content = ''
    success.value = '✅ Recommendation submitted successfully!'
    error.value = null
    fetchRecommendations()
    setTimeout(() => success.value = null, 3000)
  } catch (err) {
    error.value = 'Failed to submit recommendation.'
    success.value = null
  }
}


const formatDate = (dateStr) => {
  const date = new Date(dateStr)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

onMounted(fetchRecommendations)

</script>
