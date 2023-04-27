import { defineStore } from 'pinia'
import StaticService from '@/services/static.service'

export const useStaticStore = defineStore('static', {
  state: () => {
    return {
      baseUrl: null,
      secureBaseUrl: null,
      backdropSizes: [],
      logoSizes: [],
      posterSizes: [],
      profileSizes: [],
      stillSizes: []
    }
  },
  getters: {
    // baseUrl: state => state.baseUrl,
    // secureBaseUrl: state => state.secureBaseUrl,
    // backdropSizes: state => state.backdropSizes,
    // logoSizes: state => state.logoSizes,
    // posterSizes: state => state.posterSizes,
    // profileSizes: state => state.profileSizes,
    // stillSizes: state => state.stillSizes
  },
  actions: {
    async getStaticInfo() {
      await StaticService.get()
        .then(response => {
          const results = response.data.images
          this.baseUrl = results.base_url
          this.secureBaseUrl = results.secure_base_url
          this.backdropSizes = results.backdrop_sizes
          this.logoSizes = results.logo_sizes
          this.posterSizes = results.poster_sizes
          this.profileSizes = results.poster_sizes
          this.stillSizes = results.still_sizes
        })
        .catch(err => console.log(err))
    }
  },
  persist: true
})
