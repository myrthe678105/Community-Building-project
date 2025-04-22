<template>
    <div class="bg-white p-8 rounded-lg shadow-md max-w-md w-full mx-auto">
      <h2 class="text-2xl font-bold mb-6 text-center">{{ title }}</h2>
      
      <div v-if="errorMessage" class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
        <p>{{ errorMessage }}</p>
      </div>
      
      <form @submit.prevent="submitForm" class="space-y-4">
        <div>
          <label for="email" class="block text-gray-700 mb-1">Email</label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>
        
        <div>
          <label for="password" class="block text-gray-700 mb-1">Password</label>
          <input
            id="password"
            v-model="form.password"
            type="password"
            class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>
        
        <template v-if="isRegister">
          <div>
            <label for="password_confirmation" class="block text-gray-700 mb-1">Confirm Password</label>
            <input
              id="password_confirmation"
              v-model="form.password_confirmation"
              type="password"
              class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>
          
          <div>
            <label for="name" class="block text-gray-700 mb-1">Full Name</label>
            <input
              id="name"
              v-model="form.name"
              type="text"
              class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>
          
          <div>
            <label for="role" class="block text-gray-700 mb-1">Role</label>
            <select
              id="role"
              v-model="form.role"
              class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            >
              <option value="bewoner">Bewoner</option>
              <option value="lid">Lid</option>
            </select>
          </div>
        </template>
        
        <div>
          <button
            type="submit"
            class="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:ring-opacity-50"
            :disabled="loading"
          >
            {{ loading ? 'Processing...' : buttonText }}
          </button>
        </div>
        
        <div class="text-center mt-4">
          <p v-if="isRegister">
            Already have an account? 
            <router-link to="/login" class="text-blue-600 hover:underline">Login</router-link>
          </p>
          <p v-else>
            Don't have an account? 
            <router-link to="/register" class="text-blue-600 hover:underline">Register</router-link>
          </p>
        </div>
      </form>
    </div>
  </template>
  
  <script setup>
  import { ref, computed } from 'vue'
  import { useRouter, useRoute } from 'vue-router'
  import { useAuthStore } from '../stores/auth'
  
  const props = defineProps({
    isRegister: {
      type: Boolean,
      default: false
    }
  })
  
  const router = useRouter()
  const route = useRoute()
  const authStore = useAuthStore()
  
  const form = ref({
    email: '',
    password: '',
    password_confirmation: '',
    name: '',
    role: 'bewoner'
  })
  
  const loading = ref(false)
  const errorMessage = ref('')
  
  const title = computed(() => props.isRegister ? 'Create an Account' : 'Login to Your Account')
  const buttonText = computed(() => props.isRegister ? 'Register' : 'Login')
  
  const submitForm = async () => {
    loading.value = true
    errorMessage.value = ''
    
    try {
      if (props.isRegister) {
        await authStore.register(form.value)
        // redirect to login
        router.push({ 
          path: '/login', 
          query: { registered: 'success' } 
        })
      } else {
        const success = await authStore.login({
          email: form.value.email,
          password: form.value.password
        })
        
        if (success) {
          // Redirect to dashboard
          const redirectPath = route.query.redirect || '/dashboard'
          router.push(redirectPath)
        } else {
          errorMessage.value = 'Invalid credentials. Please try again.'
        }
      }
    } catch (error) {
      if (error.response && error.response.data && error.response.data.message) {
        errorMessage.value = error.response.data.message
      } else {
        errorMessage.value = 'An error occurred. Please try again.'
      }
    } finally {
      loading.value = false
    }
  }
  </script>