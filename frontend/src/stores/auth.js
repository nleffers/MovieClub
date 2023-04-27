import router from '@/router.js'
import { defineStore } from 'pinia'
import { useStaticStore } from './static'
import AuthService from '@/services/auth.service'
import UserService from '@/services/user.service'

const baseAuthUser = {
  id: null,
  sessionId: null,
  username: null,
  avatar: null,
  memberSince: null,
  bio: null,
  ratings: [],
  reviews: [],
  watchlist: []
}

export const useAuthStore = defineStore('auth', {
  state: () => {
    return { ...baseAuthUser }
  },
  getters: {
    // id: state => state.id,
    // sessionId: state => state.sessionId,
    // username: state => state.username,
    // avatar: state => state.avatar,
    // memberSince: state => state.memberSince,
    // bio: state => state.bio,
    // ratings: state => state.ratings,
    // reviews: state => state.reviews,
    // watchlist: state => state.watchlist,
    isLoggedIn: state => !!state.sessionId
  },
  actions: {
    login (loginData) {
      return UserService.login(loginData)
        .then(res => {
          if (res.data.request_token) {
            window.location = 'https://www.themoviedb.org/authenticate/' + res.data.request_token + '?redirect_to=' + location.href
          } else {
            this.successfulLogin(res.data)
          }
        })
        .catch(err => this.failedLogin(err))
    },
    postSessionId(requestToken) {
      return AuthService.postSessionId(requestToken)
        .then(res => this.successfulLogin(res.data))
        .catch(err => this.failedLogin(err))
    },
    createAndLogin(userInfo) {
      return UserService.create(userInfo)
        .then(res => {
          if (res.data.request_token) {
            window.location = 'https://www.themoviedb.org/authenticate/' + res.data.request_token + '?redirect_to=' + location.href
          } else {
            this.successfulLogin(res.data)
          }
        })
        .catch(err => this.failedLogin(err))
    },
    successfulLogin(authUser) {
      const staticStore = useStaticStore()

      this.setAuth(authUser)
      staticStore.getStaticInfo()
      // app.config.globalProperties.$snotify.success('Logged In Successfully')
      router.push({ name: 'root_path' })
    },
    failedLogin(err) {
      console.log(err)
      // app.config.globalProperties.$snotify.error('Unable to login')
    },
    setUsername(username) {
      this.username = username
    },
    setBio(bio) {
      this.bio = bio
    },
    async updateUser(userData) {
      return UserService.update(userData)
        .then(res => this.username = res.data.username)
        .catch(err => {
          console.log(err)
          // app.config.globalProperties.$snotify.error('Unable to update User. Please try again.')
        })
    },
    async addToWatchlist(params) {
      return UserService.addToWatchlist(params)
        .then(res => this.watchlist = [...this.watchlist, res.data])
        .catch(err => console.log(err))
    },
    async removeFromWatchlist(params) {
      return UserService.removeFromWatchlist(params)
        .then(() => this.watchlist = this.watchlist.filter(movie => movie.tmdb_movie_id !== params.tmdbMovieId))
        .catch(err => console.log(err))
    },
    logout() {
      return UserService.logout(this.id)
        .then(() => {
          this.clearAuth()
          // app.config.globalProperties.$snotify[payload.msgType](message)
          router.replace({ name: 'login_path' })
        })
        .catch(err => {
          console.log(err)
          // app.config.globalProperties.$snotify.error('There was an error logging you out')
        })
    },
    setAuth(user) {
      localStorage.setItem('sessionId', user.session_id)
      this.setAuthData(user)
    },
    clearAuth() {
      localStorage.removeItem('sessionId')
      this.setAuthData(baseAuthUser)
    },
    setAuthData(user) {
      this.id = user.id
      this.sessionId = user.session_id
      this.username = user.username
      this.avatar = user.avatar
      this.memberSince = user.memberSince
      this.bio = user.bio
      this.ratings = user.ratings
      this.reviews = user.reviews
      this.watchlist = user.watchlist
    }
  },
  persist: true
})
