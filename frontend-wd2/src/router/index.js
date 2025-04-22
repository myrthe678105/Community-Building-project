import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

// Page components
import Home from '@/views/HomeView.vue'
import Login from '@/views/login.vue'
import Register from '@/views/register.vue'
import Dashboard from '@/views/dashboard.vue'
import NotFound from '@/views/notfound.vue'
import EventManagement from '@/views/EventManagement.vue'
import Parking from '@/views/Parking.vue'
import Admin from '@/views/admin.vue'


const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    meta: { requiresAuth: true }
  },
  {
    path: '/parking',
    name: 'Parking',
    component: Parking,
    meta: { requiresAuth: true }
  },
  {
    path: '/eventmanagement',
    name: 'EventManagement',
    component: EventManagement,
    meta: { requiresAuth: true }
  },
  {
    path: '/admin',
    name: 'Admin',
    component: Admin,
    meta: { requiresAuth: true }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: NotFound
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  
  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next({ name: 'Login', query: { redirect: to.fullPath } })
  } else {
    next()
  }
})

export default router