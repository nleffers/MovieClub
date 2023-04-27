const mutations = {
  setMovie(state, payload) {
    state.movie = payload
  },
  movieSearch(state, payload) {
    state.searchResults = payload
  },
  clearMovie(state) {
    state.movie = {}
  },
  createReview(state, payload) {
    state.movie.reviews = [...state.movie.reviews, payload]
  },
  updateReview(state, payload) {
    const reviewIndex = state.movie.reviews.findIndex(review => review.id === payload.id)
    const review = { ...state.movie.reviews[reviewIndex], ...payload }
    let reviews = state.movie.reviews
    reviews.splice(reviewIndex, 1, review)
    state.movie.reviews = [...reviews]
  },
  destroyReview(state, reviewId) {
    state.movie.reviews = state.movie.reviews.filter(review => review.id !== reviewId)
  },
  setLoading(state, loading) {
    state.loading = loading
  }
}

export default mutations
