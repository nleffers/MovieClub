const mutations = {
  setBaseUrl(state, baseUrl) {
    state.baseUrl = baseUrl
  },
  setSecureBaseUrl(state, secureBaseUrl) {
    state.secureBaseUrl = secureBaseUrl
  },
  setBackdropSizes(state, backdropSizes) {
    state.backdropSizes = backdropSizes
  },
  setLogoSizes(state, logoSizes) {
    state.logoSizes = logoSizes
  },
  setPosterSizes(state, posterSizes) {
    state.posterSizes = posterSizes
  },
  setProfileSizes(state, profileSizes) {
    state.profileSizes = profileSizes
  },
  setStillSizes(state, stillSizes) {
    state.stillSizes = stillSizes
  }
}

export default mutations
