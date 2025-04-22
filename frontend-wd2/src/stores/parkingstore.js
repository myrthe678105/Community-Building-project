import { defineStore } from 'pinia'
import axios from 'axios'

export const useParkingStore = defineStore('parking', {
  state: () => ({
    spots: [],
    loading: false,
    error: null
  }),

  actions: {
    async fetchSpots() {
        this.loading = true
        this.error = null
        try {
          const res = await axios.get('http://localhost/parking')
          console.log("Fetched spots:", res.data) // Log response here
          this.spots = res.data
        } catch (err) {
          this.error = 'Failed to load parking spots.'
          console.error(err)
        } finally {
          this.loading = false
        }
      },
      

    async updateSpotStatus(spotId, newStatus) {
      this.error = null
      try {
        await axios.put(`http://localhost/parking/${spotId}`, { status: newStatus })
        const spot = this.spots.find(s => s.id === spotId)
        if (spot) {
          spot.status = newStatus
        }
      } catch (err) {
        this.error = 'Failed to update parking spot.'
        console.error(err)
      }
    }
  }
})
