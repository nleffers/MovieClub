<template>
  <div class="log-in-page">
    <h1>MovieClub</h1>
    <div class="log-in-page-section">
      <h2>Sign In</h2>
      <login-section
        v-if="loginOpen"
        @switchSignInOption="switchSignInOption"
      />
      <join-section
        v-else
        @switchSignInOption="switchSignInOption"
      />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useAuthStore } from '@/stores/auth'

import JoinSection from './login_page_components/JoinSection.vue'
import LoginSection from './login_page_components/LoginSection.vue'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    return {
      authStore
    }
  },
  components: {
    JoinSection,
    LoginSection
  },
  data() {
    return {
      loginOpen: true
    }
  },
  created() {
    if (this.$route.query.approved) { this.authStore.postSessionId(this.$route.query.request_token) }
  },
  methods: {
    switchSignInOption() {
      this.loginOpen = !this.loginOpen
    }
  }
})
</script>

<style scoped>
.log-in-page {
  color: #FAFAFA;
  margin: auto;
  width: 80%;
}

.log-in-page h1 {
  background-color: #FAFAFA;
  border-radius: 10px;
  color: #000;
  padding: 10px;
}

.log-in-page-section {
  border: 1px solid #FAFAFA;
  border-radius: 10px;
  margin: auto;
  padding-bottom: 20px;
  padding-top: 20px;
  width: 60%;
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
