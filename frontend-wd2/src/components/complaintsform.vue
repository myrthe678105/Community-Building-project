<template>
  <div class="bg-gradient-to-r from-pink-100 to-yellow-100 p-6 rounded-2xl shadow-md border border-pink-200">
    <h2 class="text-2xl font-bold text-pink-700 mb-4">
      {{ isEditing ? 'Edit Complaint 📝' : 'Submit a Complaint' }}
    </h2>

    <div v-if="errorMessage" class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4 rounded-md" role="alert">
      <p>{{ errorMessage }}</p>
    </div>

    <div v-if="successMessage" class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 rounded-md" role="alert">
      <p>{{ successMessage }}</p>
    </div>

    <form @submit.prevent="submitForm" class="space-y-6">
      <div>
        <label for="description" class="block text-lg font-medium text-pink-800 mb-1">Describe Your Issue ✍️</label>
        <textarea
          id="description"
          v-model="form.description"
          rows="6"
          class="w-full px-4 py-3 border-2 border-pink-300 rounded-xl focus:outline-none focus:ring-4 focus:ring-pink-400 bg-white placeholder-pink-300"
          placeholder="What's the issue?"
          required
        ></textarea>
      </div>

      <div class="flex justify-end space-x-2">
        <button
          v-if="isEditing"
          type="button"
          @click="cancelEdit"
          class="px-4 py-2 bg-gray-300 text-gray-700 rounded-xl hover:bg-gray-400 transition"
        >
          Cancel
        </button>
        <button
          type="submit"
          class="px-6 py-2 bg-pink-500 text-white font-semibold rounded-xl hover:bg-pink-600 transition shadow-md"
          :disabled="loading"
        >
          {{ loading ? 'Sending...' : (isEditing ? 'Update Complaint' : 'Submit Complaint') }}
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '../services/api'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()

const props = defineProps({
  complaintId: {
    type: [Number, String],
    default: null
  }
})

const emit = defineEmits(['submitted', 'updated', 'cancelled'])

const form = ref({
  description: ''
})

const loading = ref(false)
const errorMessage = ref('')
const successMessage = ref('')

const isEditing = computed(() => !!props.complaintId)

onMounted(async () => {
  if (isEditing.value) {
    await fetchComplaint()
  }
})

const fetchComplaint = async () => {
  try {
    const response = await api.get(`/complaints/${props.complaintId}`)
    form.value.description = response.data.description
  } catch (error) {
    errorMessage.value = 'Failed to load complaint. Please try again.'
    console.error('Error fetching complaint:', error)
  }
}

const submitForm = async () => {
  loading.value = true
  errorMessage.value = ''
  successMessage.value = ''

  try {
    const payload = {
      user_id: authStore.user.id,
      description: form.value.description
    }

    let response
    if (isEditing.value) {
      response = await api.put(`/complaints/${props.complaintId}`, { description: form.value.description })
      successMessage.value = 'Complaint updated successfully!'
      emit('updated', response.data)
    } else {
      response = await api.post('/complaints', payload)
      successMessage.value = 'Complaint submitted successfully!'
      emit('submitted', response.data)
      resetForm()
    }
  } catch (error) {
    errorMessage.value = error.response?.data?.message || 'An error occurred. Please try again.'
    console.error('Error submitting complaint:', error)
  } finally {
    loading.value = false
  }
}

const resetForm = () => {
  form.value.description = ''
}

const cancelEdit = () => {
  emit('cancelled')
}
</script>
