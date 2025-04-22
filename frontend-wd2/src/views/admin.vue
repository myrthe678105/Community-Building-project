<template>
    <div class="p-6 font-serif bg-[#F8F7FF] min-h-screen text-[#333]">
      <h1 class="text-3xl font-bold text-[#5B61B2] mb-6">Admin Panel</h1>
  
      <!-- Complaints Section -->
      <section class="mb-10">
        <h2 class="text-2xl font-semibold mb-2">Complaints</h2>
        <div v-if="complaints.length === 0">No complaints found.</div>
        <ul class="space-y-2">
          <li v-for="complaint in complaints" :key="complaint.id" class="bg-white p-4 rounded shadow">
            <p><strong>{{ complaint.description }}</strong></p>
            <p class="text-sm text-gray-600">created at {{ complaint.created_at }}</p>
            <button @click="deleteComplaint(complaint.id)" class="text-red-600">Mark as resolved &#x2714;</button>
          </li>
        </ul>
      </section>
  
      <!-- Events Section -->
      <section class="mb-10">
        <h2 class="text-2xl font-semibold mb-2">Manage Events</h2>
        <form @submit.prevent="createEvent" class="flex flex-col gap-2 mb-4">
          <input v-model="newEvent.title" type="text" placeholder="Event title" class="p-2 rounded border" />
          <input v-model="newEvent.event_date" type="date" class="p-2 rounded border" />
          <textarea v-model="newEvent.description" placeholder="Description" class="p-2 rounded border"></textarea>
          <input v-model="newEvent.location" type="text" placeholder="Event Location" class="p-2 rounded border" />

          <button type="submit" class="bg-[#5B61B2] text-white px-4 py-2 rounded">Add Event</button>
        </form>
  
        <ul class="space-y-2">
          <li v-for="event in events" :key="event.id" class="bg-white p-4 rounded shadow">
            <div class="flex justify-between items-center">
              <div>
                <p class="font-bold">{{ event.title }} – {{ event.date }}</p>
                <p class="text-sm">{{ event.description }}</p>
              </div>
              <div class="flex space-x-2">
                <button @click="editEvent(event)" class="text-blue-600">Edit</button>
                <button @click="deleteEvent(event.id)" class="text-red-600">Delete</button>
              </div>
            </div>
          </li>
        </ul>
      </section>
  
      <!-- Users Section -->
      <section>
        <h2 class="text-2xl font-semibold mb-2">Users</h2>
        <ul class="space-y-2">
          <li v-for="user in users" :key="user.id" class="bg-white p-4 rounded shadow flex justify-between">
            <span>{{ user.name }} ({{ user.role }})</span>
            <button @click="deleteUser(user.id)" class="text-red-600">Delete</button>
          </li>
        </ul>
      </section>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import api from '../services/api'
  
  const complaints = ref([])
  const events = ref([])
  const users = ref([])
  
  const newEvent = ref({
    title: '',
    event_date: '',
    description: '',
    location: ''
  })
  
  onMounted(() => {
    fetchComplaints()
    fetchEvents()
    fetchUsers()
  })
  
  async function fetchComplaints() {
    try {
      const res = await api.get('/complaints')
      complaints.value = res.data
    } catch (err) {
      console.error('Failed to fetch complaints:', err)
    }
  }
  
  async function fetchEvents() {
    try {
      const res = await api.get('/events')
      events.value = res.data
    } catch (err) {
      console.error('Failed to fetch events:', err)
    }
  }
  
  async function fetchUsers() {
    try {
      const res = await api.get('/users')
      users.value = res.data
    } catch (err) {
      console.error('Failed to fetch users:', err)
    }
  }
  
  async function createEvent() {
    try {
      await api.post('/events', newEvent.value)
      await fetchEvents()
      newEvent.value = { title: '', event_date: '', description: '', location: '' }
    } catch (err) {
      console.error('Event creation failed:', err)
    }
  }
  
  async function deleteEvent(id) {
    try {
      await api.delete(`/events/${id}`)
      await fetchEvents()
    } catch (err) {
      console.error('Failed to delete event:', err)
    }
  }
  
  function editEvent(event) {
    newEvent.value = { ...event }
  }
  
  async function deleteUser(id) {
    try {
      await api.delete(`/users/${id}`)
      await fetchUsers()
    } catch (err) {
      console.error('Failed to delete user')
    }
  }
  async function deleteComplaint(id) {
    try {
        await api.delete(`/complaints/${id}`)
        await fetchComplaints()
    } catch (err){
        console.error('Failed to resolve complaints')
    }
  }
  </script>
  