<template>
  <div v-if="!loading" class="user-profile-page">
    <avatar-uploader-modal v-if="avatarUploaderModalOpen" />
    <header-section />
    <watchlist-section />
    <ratings-section />
    <reviews-section />
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores/user'

import AvatarUploaderModal from '../modals/AvatarUploaderModal.vue'
import HeaderSection from './user_profile_page_components/HeaderSection.vue'
import RatingsSection from './user_profile_page_components/RatingsSection.vue'
import ReviewsSection from './user_profile_page_components/ReviewsSection.vue'
import WatchlistSection from './user_profile_page_components/WatchlistSection.vue'

export default defineComponent({
  setup() {
    const userStore = useUserStore()

    const { avatarUploaderModalOpen, loading } = storeToRefs(userStore)

    return {
      userStore,
      avatarUploaderModalOpen,
      loading,
    }
  },
  props: {
    id: [Number, String]
  },
  components: {
    AvatarUploaderModal,
    HeaderSection,
    RatingsSection,
    ReviewsSection,
    WatchlistSection
  },
  created() {
    this.userStore.setUser(this.id)
  },
  beforeUnmount() {
    this.userStore.clearUser()
  },
})
</script>

<style scoped>
.user-profile-page {
  background: #FAFAFA;
  border-radius: 12px;
  margin: auto;
  width: 90%;
  padding-bottom: 5px;
}
</style>

<style>
.user-profile-section {
  border-radius: 12px;
  border: 1px solid black;
  margin: 5px;
  padding: 10px 12px;
  width: calc(100% - 20px);
}

.user-profile-section-flex {
  display: inline-flex;
}

.user-profile-section-block {
  display: inline-block;
}

.user-profile-section-header {
  text-align: left;
}

.user-profile-section-header h2 {
  font-size: 17.5px;
  font-weight: bold;
}
</style>
