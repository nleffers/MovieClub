<template>
  <div class="log-in-page">
    <div class="col-md-8 offset-md-2">
      <div class="switch-sections" @click="$emit('switchSignInOption')">New user? Create an account</div>
      <form @submit.prevent="submitLogin">
        <div class="form-group justify-content-center">
          <input
            type="text"
            class="form-control"
            id="username-field"
            placeholder="Enter Username"
            v-model="newUsername"
          />
        </div>
        <div class="form-group">
          <input
            type="password"
            class="form-control"
            id="password-field"
            placeholder="Enter Password"
            v-model="newPassword"
          />
        </div>
        <button
          type="submit"
          class="btn btn-primary"
        >
          Submit
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useAuthStore } from '@/stores/auth'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    return {
      authStore,
    }
  },
  data() {
    return {
      newUsername: '',
      newPassword: ''
    }
  },
  methods: {
    submitLogin() {
      const formData = {
        username: this.newUsername,
        password: this.newPassword
      }
      this.authStore.login(formData)
    }
  }
})
</script>

<style scoped>
.log-in-page {
  margin: auto;
  width: 80%;
}

.switch-sections {
  font-size: 14px;
  cursor: pointer;
}

.form-group {
  display: inline;
}

.form-group input {
  margin-top: 5px;
  float: right;
}

button {
  margin-top: 10px;
}
</style>
