import actions from './actions.js'
import getters from './getters.js'
import mutations from './mutations.js'

const StaticStore = {
  namespaced: true,
  state: {
    baseUrl: null,
    secureBaseUrl: null,
    backdropSizes: [],
    logoSizes: [],
    posterSizes: [],
    profileSizes: [],
    stillSizes: []
  },
  mutations,
  getters,
  actions
}

export default StaticStore
