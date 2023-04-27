import router from '@/router.js'
import AuthService from '@/services/auth.service'
import UserService from '@/services/user.service'

const actions = app => {
  return {
    login ({ dispatch }, loginData) {
      return UserService.login(loginData)
        .then(res => {
          if (res.data.request_token) {
            window.location = 'https://www.themoviedb.org/authenticate/' + res.data.request_token + '?redirect_to=' + location.href
          } else {
            dispatch('setUser', res.data)
            dispatch('StaticStore/getStaticInfo', {}, { root: true })
            app.config.globalProperties.$snotify.success('Logged in successfully.')
            router.push({ name: 'root_path' })
          }
        })
        .catch((err) => {
          console.log(err)
          dispatch('badLogin')
        })
    },
    badLogin () {
      app.config.globalProperties.$snotify.error('Unable to login')
    },
    postSessionId ({ dispatch }, requestToken) {
      return AuthService.postSessionId(requestToken)
        .then(res => {
          dispatch('setUser', res.data)
          dispatch('StaticStore/getStaticInfo', {}, { root: true })
          app.config.globalProperties.$snotify.success('Logged In Successfully')
          router.push({ name: 'root_path' })
        })
        .catch(e => {
          console.log(e)
        })
    },
    createAndLogin ({ dispatch }, userInfo) {
      return UserService.create(userInfo)
        .then(res => {
          if (res.data.request_token) {
            window.location = 'https://www.themoviedb.org/authenticate/' + res.data.request_token + '?redirect_to=' + location.href
          } else {
            dispatch('setUser', res.data)
            dispatch('StaticStore/getStaticInfo', {}, { root: true })
            app.config.globalProperties.$snotify.success('Logged In Successfully')
            router.push({ name: 'root_path' })
          }
        })
        .catch(() => dispatch('badLogin'))
    },
    setUser({ commit }, userData) {
      localStorage.setItem('sessionId', userData.session_id)
      commit('setId', userData.id)
      commit('setSessionId', userData.session_id)
      commit('setUsername', userData.username)
      commit('setAvatar', userData.avatar)
      commit('setMemberSince', userData.member_since)
      commit('setUserBio', userData.bio)
      commit('setUserRatings', userData.user_ratings)
      commit('setUserReviews', userData.user_reviews)
      commit('setUserWatchlist', userData.user_watchlist)
    },
    setUsername({ commit }, username) {
      commit('setUsername', username)
    },
    setUserBio({ commit }, userBio) {
      commit('setUserBio', userBio)
    },
    async updateUser({ commit }, userData) {
      return UserService.update(userData)
        .then(res => commit('setUsername', res.data.username))
        .catch(e => {
          console.log(e)
          app.config.globalProperties.$snotify.error('Unable to update User. Please try again.')
        })
    },
    rateMovie({ commit }, rateObject) {
      commit('rateMovie', rateObject)
    },
    async addToWatchlist({ commit }, params) {
      return UserService.addToWatchlist(params)
        .then(res =>commit('addToWatchlist', res.data))
        .catch(e => console.log(e))
    },
    async removeFromWatchlist({ commit }, params) {
      return UserService.removeFromWatchlist(params)
        .then(() => commit('removeFromWatchlist', params.tmdbMovieId))
        .catch(e => console.log(e))
    },
    logout ({ commit, state }, payload = { msgType: 'success' }) {
      const message = payload.message || 'Logged Out Successfully'
      console.log(message)

      return UserService.logout(state.id)
        .then(() => {
          commit('clearUserData')
          localStorage.removeItem('sessionId')
          app.config.globalProperties.$snotify[payload.msgType](message)
          router.replace({ name: 'login_path' })
        })
        .catch(e => {
          console.log(e)
          app.config.globalProperties.$snotify.error('There was an error logging you out')
        })
    }
  }
}

export default app => actions(app)
