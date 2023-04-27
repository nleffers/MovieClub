import actions from './actions.js'
import getters from './getters.js'
import mutations from './mutations.js'

const MovieStore = {
  namespaced: true,
  state() {
    return {
      movie: {
        id: '',
        title: '',
        rating: '',
        rating_count: '',
        reviews: []
      },
      searchResults: [],
      loading: false
    }
  },
  actions,
  getters,
  mutations
}

export default MovieStore
