const getters = {
  id: state => state.id,
  username: state => state.username,
  avatar: state => state.avatar,
  memberSince: state => state.memberSince,
  userBio: state => state.userBio,
  userRatings: state => state.userRatings,
  userReviews: state => state.userReviews,
  userWatchlist: state => state.userWatchlist,
  avatarUploaderModalOpen: state => state.avatarUploaderModalOpen,
  loading: state => state.loading,
}

export default getters
