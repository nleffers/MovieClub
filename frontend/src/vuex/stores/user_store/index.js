import actions from './actions.js'
import getters from './getters.js'
import mutations from './mutations.js'

const UserStore = app => {
  return {
    namespaced: true,
    state: {
      id: '',
      username: null,
      avatar: null,
      memberSince: null,
      userBio: null,
      userRatings: [],
      userReviews: [],
      userWatchlist: [],
      avatarUploaderModalOpen: false,
      loading: false,
    },
    actions: actions(app),
    getters,
    mutations
  }
}

export default app => UserStore(app)
