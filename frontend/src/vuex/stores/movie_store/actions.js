import MovieService from '@/services/movie.service'

const actions = {
  setMovie({ commit }, movieId) {
    commit('setLoading', true)
    MovieService.get(movieId)
      .then(response => {
        commit(`setMovie`, response.data)
        commit('setLoading', false)
      })
      .catch(err => {
        console.log(err)
        commit('setLoading', false)
      })
  },
  movieSearch({ commit }, movies) {
    commit('movieSearch', movies)
  },
  clearMovie({ commit }) {
    commit('clearMovie')
  },
  clearMovies({ commit }) {
    commit('clearMovies')
  },
  createReview({ commit }, reviewObject) {
    commit('createReview', reviewObject)
  },
  updateReview({ commit }, reviewObject) {
    commit('updateReview', reviewObject)
  },
  destroyReview({ commit }, reviewId) {
    commit('destroyReview', reviewId)
  },
}

export default actions
