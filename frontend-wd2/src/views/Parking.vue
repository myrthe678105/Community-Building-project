<template>
  <div class="font-sans bg-gradient-to-b from-[#DEC1DB] via-[#2F80E4] to-[#6DA0E1] min-h-screen">
    <section class="py-16 text-center text-white">
      <h1 class="text-4xl lg:text-5xl font-extrabold leading-tight mb-6 drop-shadow-lg">
        Manage Parking
      </h1>
      <p class="text-lg lg:text-xl mb-12">
        View and manage parking spots. Make your spot available or request one.
      </p>
      <div class="container mx-auto px-8 lg:px-20">
        <div class="bg-white p-8 rounded-xl shadow-xl">
          <h2 class="text-2xl font-semibold text-[#2F80E4] mb-6">Parking Lot Overview</h2>
          <h4 class="text-l font-semibold text-[#05080c] mb-6">*Any spots belonging to you are highlighted</h4>
          <div class="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-5 gap-4">
            <!-- Loop through the spots -->
            <div
              v-for="spot in parkingStore.spots.slice(0, 60)"
              :key="spot.spot_number"
              class="flex flex-col items-center justify-center p-4 rounded-xl shadow-md text-white transition duration-300 hover:scale-105"
              :class="{
                'bg-green-400': spot.status === 'available' && authStore.user?.id !== spot.user_id,
                'bg-red-400': spot.status === 'occupied',
                'bg-yellow-300 text-black': spot.status === 'reserved',
                'border-solid border-4 border-black': authStore.user?.id === spot.user_id,
                }"
            >
              <h3 class="text-lg font-bold">Spot {{ spot.spot_number }}</h3>
              <p class="text-xs mb-2">Assigned to: #{{ spot.user_id }}</p>
              <p class="text-xs mb-4 capitalize">Status: {{ spot.status }}</p>

              <!-- Set the spot as available if the user owns it and it's not already available -->
              <button
                v-if="authStore.user?.id === spot.user_id && spot.status !== 'available'"
                @click="makeAvailable(spot.id)"
                class="bg-white text-green-700 font-semibold px-3 py-1 rounded hover:bg-green-200 transition"
              >
                Set as Available
              </button>

              <!-- Request a spot if it's available -->
              <button
                v-else-if="spot.status === 'available'"
                @click="requestSpot(spot.id)"
                class="bg-white text-blue-700 font-semibold px-3 py-1 rounded hover:bg-blue-200 transition"
              >
                Request Spot
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useParkingStore } from '../stores/parkingstore'
import { useAuthStore } from '../stores/auth'

const parkingStore = useParkingStore()
const authStore = useAuthStore()

onMounted(() => {
  parkingStore.fetchSpots()
})

const makeAvailable = (spotNumber) => {
  parkingStore.updateSpotStatus(spotNumber, 'available')
}

const requestSpot = (spotNumber) => {
  parkingStore.updateSpotStatus(spotNumber, 'reserved')
}
</script>
