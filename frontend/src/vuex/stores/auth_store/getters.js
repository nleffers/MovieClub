const getters = {
  id: state => state.id,
  sessionId: state => state.sessionId,
  username: state => state.username,
  avatar: state => state.avatar,
  memberSince: state => state.memberSince,
  userBio: state => state.userBio,
  userRatings: state => state.userRatings,
  userReviews: state => state.userReviews,
  userWatchlist: state => state.userWatchlist,
  isLoggedIn: state => state.sessionId !== null
}

export default getters
