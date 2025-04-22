<template>
  <div class="p-6">
    <div class="mb-10">
      <h1 class="text-5xl font-extrabold text-gray-900 tracking-tight text-center mt-8 mb-4 leading-tight drop-shadow-lg">
    Welcome to the Dashboard!</h1>
    </div>
  <!-- Community Recommendation Display -->
  <h3 class="text-xl font-semibold text-gray-800 mb-4 border-b-2 border-gray-300 pb-2">
    Some current recommendations from people in the building:
  </h3>

  <div
    class="rounded-xl shadow-lg p-6 mb-10 transition-opacity duration-300 ease-in-out text-gray-800"
    :style="{ opacity: fadeOut ? 0 : 1 }"
    style="background: linear-gradient(135deg,#F2B5D4, #D5AAFF, #A3CEF1, #7FB7BE );"
  >
    <div v-if="currentRecommendation">
      <h2 class="text-2xl font-bold text-indigo-700">{{ currentRecommendation.title }}</h2>
      <p class="mt-2 text-gray-800">{{ currentRecommendation.content }}</p>
    </div>
  </div>

    <!-- Cards Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
      <DashboardCard
        icon="📮"
        title="Submit Complaint"
        description="Something bothering you? Let us know!"
        @click="activeComponent = 'complaint-form'"
        class="from-pink-200 to-pink-100"
      />

      <DashboardCard
        icon="💡"
        title="Add Recommendation"
        description="Share your favorite spots!"
        @click="activeComponent = 'recommendations'"
        class="from-yellow-200 to-yellow-100"
      />

      <router-link to="/parking">
        <DashboardCard
          icon="🅿️"
          title="Request Parking Spot"
          class="from-green-200 to-green-100"
        />
      </router-link>
      <router-link to="/parking">
        <DashboardCard
          icon="🚫"
          title="Free up your parking for others"
          class="from-indigo-200 to-indigo-100"
        />
      </router-link>
    </div>


    <!-- Conditional Sections -->
    <div v-if="activeComponent === 'complaint-form'" class="bg-white rounded-xl shadow p-6">
      <ComplaintForm @submitted="handleComplaintSubmitted" />
    </div>

    <div v-else-if="activeComponent === 'recommendations'" class="bg-white rounded-xl shadow p-6">
      <RecommendationList/>
    </div>
  </div>
  
<!-- lid member section -->
<h1 class="text-3xl font-bold text-gray-800">Meet our (ai generated) Community Members!</h1>

<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
  <div class="bg-white rounded-2xl shadow-md border border-pink-200 overflow-hidden hover:shadow-lg transition">
    <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Lid photo" class="w-full h-48 object-cover">
    <div class="p-4">
      <h3 class="text-xl font-bold text-pink-700 mb-1">Sophie Jansen</h3>
      <p class="text-sm text-gray-700">📧 sophie@example.com</p>
      <p class="text-sm text-gray-700">📞 06 1234 5678</p>
    </div>
  </div>

  <div class="bg-white rounded-2xl shadow-md border border-pink-200 overflow-hidden hover:shadow-lg transition">
    <img src="https://randomuser.me/api/portraits/men/46.jpg" alt="Lid photo" class="w-full h-48 object-cover">
    <div class="p-4">
      <h3 class="text-xl font-bold text-pink-700 mb-1">Daan Bakker</h3>
      <p class="text-sm text-gray-700">📧 daan@example.com</p>
      <p class="text-sm text-gray-700">📞 06 8765 4321</p>
    </div>
  </div>

  <div class="bg-white rounded-2xl shadow-md border border-pink-200 overflow-hidden hover:shadow-lg transition">
    <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Lid photo" class="w-full h-48 object-cover">
    <div class="p-4">
      <h3 class="text-xl font-bold text-pink-700 mb-1">Lotte de Vries</h3>
      <p class="text-sm text-gray-700">📧 lotte@example.com</p>
      <p class="text-sm text-gray-700">📞 06 5555 1234</p>
    </div>
  </div>

  <div class="bg-white rounded-2xl shadow-md border border-pink-200 overflow-hidden hover:shadow-lg transition">
    <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="Lid photo" class="w-full h-48 object-cover">
    <div class="p-4">
      <h3 class="text-xl font-bold text-pink-700 mb-1">Tom van Leeuwen</h3>
      <p class="text-sm text-gray-700">📧 tom@example.com</p>
      <p class="text-sm text-gray-700">📞 06 2222 9876</p>
    </div>
  </div>
</div>


</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import ComplaintForm from '../components/complaintsform.vue'
import RecommendationList from '../components/recommendationlist.vue'
import DashboardCard from '../components/DashboardCard.vue'
import api from '../services/api'

const authStore = useAuthStore()
const activeComponent = ref('')
const recommendations = ref([])
const currentRecommendation = ref(null)
const fadeOut = ref(false)
let recommendationIndex = 0

onMounted(async () => {
  if (!authStore.user) await authStore.fetchUser()
  await fetchRecommendations()
  startRecommendationCycle()
})

const fetchRecommendations = async () => {
  try {
    const response = await api.get('/recommendations')
    recommendations.value = response.data
    currentRecommendation.value = recommendations.value[0]
  } catch (error) {
    console.error('Failed to load recommendations:', error)
  }
}

const startRecommendationCycle = () => {
  setInterval(() => {
    if (recommendations.value.length > 0) {
      fadeOut.value = true
      setTimeout(() => {
        recommendationIndex = (recommendationIndex + 1) % recommendations.value.length
        currentRecommendation.value = recommendations.value[recommendationIndex]
        fadeOut.value = false
      }, 1000)
    }
  }, 7000)
}

const handleComplaintSubmitted = () => {
  activeComponent.value = ''
}
</script>
