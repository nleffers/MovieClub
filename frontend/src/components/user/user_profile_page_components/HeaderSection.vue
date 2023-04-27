<template>
  <div class="user-profile-section user-profile-section-flex">
    <div
      class="avatar-frame"
      @click="openModal()"
    >
      <img :src="avatar" />
    </div>
    <div class="header-info">
      <h1>{{ username }}</h1>
      <div class="header-member-since">TMDB Member since {{ memberSince }}</div>
      <div class="header-bio">{{ bio }}</div>
      <div
        v-if="isCurrentUser"
        class="header-edit-profile"
        @click="openEditProfilePage()"
      >
        Edit Profile
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useUserStore } from '@/stores/user'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const userStore = useUserStore()

    const { id: authId } = storeToRefs(authStore)
    const { id: userId, avatar, username, memberSince, bio, openAvatarUploaderModal } = storeToRefs(userStore)

    const isCurrentUser = authId === userId

    return {
      authId,
      userId,
      isCurrentUser,
      avatar,
      username,
      memberSince,
      bio,
      openAvatarUploaderModal,
    }
  },
  methods: {
    openModal() {
      if (!this.isCurrentUser) { return }

      this.openAvatarUploaderModal()
    },
    openEditProfilePage() {
      if (!this.isCurrentUser) { return }

      this.$router.push({ name: 'edit_user_profile_path' })
    }
  }
})
</script>

<style scoped>
.avatar-frame {
  border: 1px solid black;
  cursor: pointer;
  height: 100px;
  width: 100px;
  margin: 0 13px 5px;
}

.avatar-frame img {
  height: 100px;
  width: 100px;
}

.header-info {
  text-align: left;
}

.header-info h1 {
  color: #333;
  font-size: 21px;
  line-height: 110%;
  margin: 0;
}

.header-member-since {
  font-size: 9px;
  margin-top: 3px;
  max-height: 90px;
}

.header-bio {
  margin-top: 4px;
  max-height: 90px;
  overflow-y: hidden;
}

.header-edit-profile {
  color: purple;
  cursor: pointer;
  font-size: 10px;
  font-weight: bold;
}
</style>
