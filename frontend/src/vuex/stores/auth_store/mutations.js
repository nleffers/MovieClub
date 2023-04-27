const mutations = {
  clearUserData (state) {
    state.id = null
    state.sessionId = null
    state.username = null
    state.avatar = null
    state.memberSince = null
    state.userBio = null
    state.userRatings = []
    state.userReviews = []
    state.userWatchlist = []
  },
  setId (state, id) {
    state.id = id
  },
  setSessionId (state, sessionId) {
    state.sessionId = sessionId
  },
  setUsername (state, username) {
    state.username = username
  },
  setAvatar (state, avatar) {
    state.avatar = avatar
  },
  setMemberSince (state, memberSince) {
    state.memberSince = memberSince
  },
  setUserBio (state, userBio) {
    state.userBio = userBio
  },
  setUserRatings (state, userRatings) {
    state.userRatings = userRatings
  },
  setUserReviews (state, userReviews) {
    state.userReviews = userReviews
  },
  setUserWatchlist (state, userWatchlist) {
    state.userWatchlist = userWatchlist
  },
  addToWatchlist (state, movieObject) {
    state.userWatchlist = [...state.userWatchlist, movieObject]
  },
  removeFromWatchlist (state, movieId) {
    state.userWatchlist = state.userWatchlist.filter(movie => movie.tmdb_movie_id !== movieId)
  }
}

export default mutations
