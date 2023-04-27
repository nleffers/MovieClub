import { defineStore } from 'pinia'
import { useAuthStore } from './auth'
import UserService from '@/services/user.service'

const baseUser = {
  id: '',
  username: null,
  avatar: null,
  memberSince: null,
  bio: null,
  ratings: [],
  reviews: [],
  watchlist: [],
}

export const useUserStore = defineStore('user', {
  state: () => {
    return {
      ...baseUser,
      avatarUploaderModalOpen: false,
      loading: false,
    }
  },
  getters: {
    // id: state => state.id,
    // username: state => state.username,
    // avatar: state => state.avatar,
    // memberSince: state => state.memberSince,
    // bio: state => state.bio,
    // ratings: state => state.ratings,
    // reviews: state => state.reviews,
    // watchlist: state => state.watchlist,
    // avatarUploaderModalOpen: state => state.avatarUploaderModalOpen,
    // loading: state => state.loading,
  },
  actions: {
    async setUser(userId) {
      const authStore = useAuthStore()

      this.loading = true
      const authId = authStore.id

      if (authId === userId) {
        this.setUserData(authStore)
      } else {
        await UserService.get(userId)
          .then((response) => this.setUserData(response.data))
          .catch(err => {
            console.log(err)
            // app.config.globalProperties.$snotify.error('There was an error retrieving the user.')
          })
      }
      this.loading = false
    },
    setAvatar(avatar) {
      this.avatar = avatar
    },
    openAvatarUploaderModal() {
      this.avatarUploaderModalOpen = true
    },
    closeAvatarUploaderModal() {
      this.avatarUploaderModalOpen = false
    },
    clearUser() {
      this.setUserData(baseUser)
    },
    setUserData(user) {
      this.id = user.id
      this.username = user.username
      this.avatar = user.avatar
      this.memberSince = user.member_since || user.memberSince
      this.bio = user.bio
      this.ratings = user.ratings
      this.reviews = user.reviews
      this.watchlist = user.watchlist
    },
  }
})
