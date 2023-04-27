<template>
  <base-modal>
    <template v-slot:header>Upload Avatar</template>

    <template v-slot:body>
      <div class="avatar-upload">
        <b-form-file
          class="file-form"
          accept="image/png, image/jpg, image/jpeg"
          placeholder="Choose a file..."
          :multiple="false"
          v-model="avatar"
        />
      </div>
    </template>

    <template v-slot:footer>
      <button class="cancel-button" @click="closeModal()">Cancel</button>
      <button class="submit-button" @click="submit()">Upload</button>
    </template>
  </base-modal>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useUserStore } from '@/stores/user'
import BaseModal from './BaseModal.vue'
import UserService from '@/services/user.service'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const userStore = useUserStore()

    const { id: authId } = storeToRefs(authStore)
    const { closeAvatarUploaderModal, setAvatar } = storeToRefs(userStore)

    return {
      authId,
      closeAvatarUploaderModal,
      setAvatar,
    }
  },
  components: {
    BaseModal
  },
  data() {
    return {
      avatar: null
    }
  },
  methods: {
    closeModal() {
      this.closeAvatarUploaderModal()
    },
    submit() {
      if (!this.avatar) {
        return
      }

      const options = {
        id: this.authId,
        avatar: this.avatar
      }

      UserService.uploadAvatar(options)
        .then(response => {
          this.setAvatar(response.data)
          this.closeModal()
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
})
</script>

<style scoped>
</style>
