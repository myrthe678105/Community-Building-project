<template>
  <div class="min-h-screen font-serif bg-gradient-to-br from-[#FDE2E4] via-[#E0BBE4] to-[#957DAD] text-[#333]">
    <!-- Title -->
    <div class="text-center py-8">
      <h1 class="text-4xl font-extrabold text-[#fff] drop-shadow-md">Community Events</h1>
      <p class="text-lg text-white/90 mt-2">Check out upcoming events and add them to your calendar!</p>
    </div>

    <!-- Event Cards -->
    <div class="container mx-auto px-4 grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div v-for="event in events" :key="event.id" class="bg-white rounded-2xl shadow-lg p-5 border-l-8 border-[#5B61B2] hover:scale-[1.01] transition-all">
        <h2 class="text-xl font-bold text-[#5B61B2]">{{ event.title }}</h2>
        <p class="text-gray-700 mt-2">{{ event.description }}</p>
        <p class="text-sm text-gray-500 mt-2">📅 {{ formatDate(event.event_date) }}</p>
        <p class="text-sm mt-3 italic text-[#5B61B2]">
          RSVP via WhatsApp: <strong>+31 6 12345678</strong><br />
          or email: <strong>admin@buildingboard.test</strong>
        </p>
      </div>
    </div>

    <!-- Calendar -->
    <div class="container mx-auto px-4 py-10">
      <h2 class="text-2xl font-bold text-white mb-4 text-center drop-shadow">📆 Event Calendar</h2>
      <VueCal
        style="height: 600px"
        :events="calendarEvents"
        default-view="month"
        :time="false"
        class="rounded-xl shadow-md bg-white p-2"
        hide-title
        :on-event-click="onEventClick"
        :disable-views="['years', 'year', 'week', 'day', 'agenda']"
        active-view="month"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import VueCal from 'vue-cal'
import 'vue-cal/dist/vuecal.css'

const events = ref([])
const calendarEvents = ref([])


const fetchEvents = async () => {
  try {
    const response = await axios.get('http://localhost/events')
    events.value = response.data

    calendarEvents.value = response.data.map((event) => {
      console.log('🔎 Raw event date:', event.event_date)

      const rawDate = event.event_date?.toString().replace(' ', 'T')
      const startDate = new Date(rawDate)
      console.log('📅 calendarEvents:', calendarEvents.value)


      if (isNaN(startDate.getTime())) {
        console.error('Invalid event_date:', event.event_date)
        return null
      }

      const endDate = new Date(startDate)
      endDate.setHours(endDate.getHours() + 3)

      return {
        start: startDate.toISOString(),
        end: endDate.toISOString(),
        title: event.title,
        class: 'highlight-purple', 
      }
    }).filter(Boolean) // Filter out any nulls
  } catch (error) {
    console.error('Failed to fetch events:', error)
  }
}

const formatDate = (dateStr) => {
  if (!dateStr) return 'No date'

  try {
    const parsed = new Date(dateStr.toString().replace(' ', 'T'))
    if (isNaN(parsed.getTime())) return 'Invalid date'
    const options = {
      weekday: 'short',
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    }
    return parsed.toLocaleDateString('en-GB', options)
  } catch (error) {
    console.error('Error formatting date:', error)
    return 'Invalid date'
  }
}

const onEventClick = (event) => {
  alert(`📌 ${event.title}\nYou can RSVP via WhatsApp: +31 6 12345678 or email: admin@buildingboard.test`)
}

onMounted(() => {
  fetchEvents()
})
</script>

<style scoped>
.vuecal {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  --vuecal-primary: #5B61B2;
  --vuecal-text: #222;
}
.vuecal__event.highlight-purple {
  background-color: #957DAD !important;
  color: white !important;
  border-radius: 0.5rem;
  font-weight: 600;
  padding: 2px 4px;
}
</style>
