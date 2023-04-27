import StaticService from '@/services/static.service'

const actions = {
  async getStaticInfo({ commit }) {
    await StaticService.get()
      .then(response => {
        const results = response.data.images
        commit('setBaseUrl', results.base_url)
        commit('setSecureBaseUrl', results.secure_base_url)
        commit('setBackdropSizes', results.backdrop_sizes)
        commit('setLogoSizes', results.logo_sizes)
        commit('setPosterSizes', results.poster_sizes)
        commit('setProfileSizes', results.poster_sizes)
        commit('setStillSizes', results.still_sizes)
      })
  }
}

export default actions
