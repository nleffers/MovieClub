<template>
  <div class="edit-profile-page">
    <div class="edit-username">
      <label>Username</label>
      <input
        type="text"
        id="edit-input"
        v-model="newUsername"
      />
    </div>
    <div class="edit-user-bio">
      <label>Bio</label>
      <textarea
        id="edit-bio"
        rows="10"
        v-model="newBio"
      />
    </div>
    <div class="edit-user-buttons">
      <div
        class="cancel-button"
        @click="returnToUser()"
      >
        Cancel
      </div>
      <div
        class="submit-button"
        @click="updateUser()"
      >
        Submit
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import UserService from '@/services/user.service'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    const { id, username, bio } = storeToRefs(authStore)

    return {
      id,
      username,
      bio,
    }
  },
  data() {
    return {
      newUsername: '',
      newBio: ''
    }
  },
  mounted() {
    this.newUsername = this.username
    this.newUserBio = this.bio
  },
  methods: {
    returnToUser() {
      this.$router.push({ name: 'user_profile_path', params: { id: this.id }})
    },
    updateUser() {
      const userData = {
        id: this.id,
        username: this.newUsername,
        bio: this.newBio
      }

      UserService.update(userData)
        .then(() => this.returnToUser())
        .catch(e => console.log(e))
    }
  }
})
</script>

<style scoped>
.edit-profile-page {
  background: #FAFAFA;
  border-radius: 12px;
  margin: auto;
  width: 90%;
  padding: 10px;
}

.edit-profile-page label {
  padding-right: 15px;
  text-align: right;
  vertical-align: top;
  width: 15%;
}

#edit-input, #edit-bio {
  width: 85%;
}

.edit-user-buttons {
  display: inline-flex;
  margin: auto;
}

.cancel-button {
  background-color: red;
  margin-right: 10px;
}

.submit-button {
  background-color: blue;
  margin-left: 10px;
}

.cancel-button, .submit-button {
  border: 1px solid black;
  border-radius: 10px;
  color: #fff;
  cursor: pointer;
  padding: 5px;
}
</style>
