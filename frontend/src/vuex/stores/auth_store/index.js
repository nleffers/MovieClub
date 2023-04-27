import actions from './actions.js'
import getters from './getters.js'
import mutations from './mutations.js'

const AuthStore = app => {
  return {
    namespaced: true,
    state: {
      id: '',
      sessionId: null,
      username: '',
      avatar: null,
      memberSince: null,
      userBio: null,
      userRatings: [],
      userReviews: [],
      userWatchlist: []
    },
    actions: actions(app),
    getters,
    mutations
  }
}

export default app => AuthStore(app)
