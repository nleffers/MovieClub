const mutations = {
  clearUser (state) {
    state.id = null
    state.username = null
    state.avatar = null
    state.memberSince = null
    state.userBio = null
    state.userRatings = []
    state.userReviews = []
    state.userWatchlist = []
    state.loading = false
  },
  setId (state, id) {
    state.id = id
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
  openAvatarUploaderModal(state) {
    state.avatarUploaderModalOpen = true
  },
  closeAvatarUploaderModal(state) {
    state.avatarUploaderModalOpen = false
  },
  setLoading (state, loading) {
    state.loading = loading
  }
}

export default mutations
