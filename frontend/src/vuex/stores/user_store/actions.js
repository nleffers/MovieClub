import UserService from '@/services/user.service'

const actions = app => {
  return {
    async setUser({ commit, getters }, userId) {
      commit('setLoading', true)

      const authId = getters[`AuthStore/id`]

      if (authId === userId) {
        commit('setId', authId)
        commit('setUsername', getters[`AuthStore/username`])
        commit('setAvatar', getters[`AuthStore/avatar`])
        commit('setMemberSince', getters[`AuthStore/memberSince`])
        commit('setUserBio', getters[`AuthStore/uerBio`])
        commit('setUserRatings', getters[`AuthStore/userRatings`])
        commit('setUserReviews', getters[`AuthStore/userReviews`])
        commit('setUserWatchlist', getters[`AuthStore/userWatchlist`])
        commit('setLoading', false)
      } else {
        await UserService.get(userId)
          .then(response => {
            const userData = response.data
            commit('setId', userData.id)
            commit('setUsername', userData.username)
            commit('setAvatar', userData.avatar)
            commit('setMemberSince', userData.member_since)
            commit('setUserBio', userData.bio)
            commit('setUserRatings', userData.user_ratings)
            commit('setUserReviews', userData.user_reviews)
            commit('setUserWatchlist', userData.user_watchlist)
            commit('setLoading', false)
          })
          .catch(err => {
            console.log(err)
            app.config.globalProperties.$snotify.error('There was an error retrieving the user.')
            commit('setLoading', false)
          })
      }
    },
    setAvatar({ commit }, avatar) {
      commit('setAvatar', avatar)
    },
    openAvatarUploaderModal({ commit }) {
      commit('openAvatarUploaderModal')
    },
    closeAvatarUploaderModal({ commit }) {
      commit('closeAvatarUploaderModal')
    },
    clearUser({ commit }) {
      commit('clearUser')
    }
  }
}

export default app => actions(app)
