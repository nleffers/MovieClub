import { createStore as _createStore } from 'vuex'
import VuexPersistence from 'vuex-persist'
import AuthStore from './stores/auth_store'
import MovieStore from './stores/movie_store'
import StaticStore from './stores/static_store'
import UserStore from './stores/user_store'
import { staticStorePlugin } from './plugins/static_store_plugin'

const vuexAuthHistory = new VuexPersistence({
  storage: window.localStorage,
  key: 'auth',
  reducer: state => {
    return ({
      AuthStore: {
        id: state.AuthStore.id,
        sessionId: state.AuthStore.sessionId,
        username: state.AuthStore.username,
        state: state.AuthStore.avatar,
        memberSince: state.AuthStore.memberSince,
        userBio: state.AuthStore.userBio,
        userRatings: state.AuthStore.userRatings,
        userReviews: state.AuthStore.userReviews,
        userWatchlist: state.AuthStore.userWatchlist
      }
    })
  }
})

export default function (app) {
  return _createStore({
    modules: {
      AuthStore: AuthStore(app),
      MovieStore,
      StaticStore,
      UserStore: UserStore(app)
    },
    plugins: [
      vuexAuthHistory.plugin,
      staticStorePlugin
    ],
    getters: {
      currentRoute(state) {
        return state.route.name
      }
    }
  })
}
