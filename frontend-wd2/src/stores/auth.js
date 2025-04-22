import { defineStore } from 'pinia'
import api from '../services/api'
import router from '../router'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token') || null,
    role: localStorage.getItem('role') || null
  }),
  
  getters: {
    isAuthenticated: (state) => !!state.token,
    userRole: (state) => state.role,
    isBewoner: (state) => state.role === 'bewoner',
    isLid: (state) => state.role === 'lid',
    isAdmin: (state) => state.role === 'admin'
  },
  
  actions: {
    async login(credentials) {
      try {
        const response = await api.post('/auth/login', credentials)
        this.token = response.data.token
        this.user = response.data.user
        this.role = response.data.user.role || 'bewoner'
    
        localStorage.setItem('token', this.token)
        localStorage.setItem('role', this.role)
    
        return true
      } catch (error) {
        console.error('Login error:', error)
        return false
      }
    },
    
    async register(userData) {
      try {
        const response = await api.post('/auth/register', userData)
        return response.data
      } catch (error) {
        console.error('Registration error:', error)
        throw error
      }
    },
    
    logout() {
      this.user = null
      this.token = null
      this.role = null
      
      localStorage.removeItem('token')
      localStorage.removeItem('role')
      
      router.push('/login')
    },
    
    async fetchUser() {
      try {
        const response = await api.get('/auth/user')
        this.user = response.data
        this.role = response.data.role
        return this.user
      } catch (error) {
        console.error('Fetch user error:', error)
        this.logout()
      }
    }
  }
})