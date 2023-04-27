<template>
  <div class="join-page">
    <div class="col-md-8 offset-md-2">
      <div class="switch-sections" @click="$emit('switchSignInOption')">Already have an account? Log In</div>
      <form @submit.prevent="submitJoin">
        <div class="form-group justify-content-center">
          <input
            :class="{ invalid: v$.username.$invalid }"
            type="text"
            class="form-control"
            id="username-field"
            placeholder="Username"
            v-model="newUsername"
          />
        </div>
        <div class="form-group">
          <input
            :class="{ invalid: v$.password.$invalid }"
            type="password"
            class="form-control"
            id="password-field"
            placeholder="Password"
            v-model="newPassword"
          />
        </div>
        <div class="form-group">
          <input
            :class="{ invalid: v$.email.$invalid }"
            type="text"
            class="form-control"
            id="email-field"
            placeholder="Email"
            v-model="newEmail"
          />
        </div>
        <div class="form-group">
          <input
            type="text"
            class="form-control"
            id="first-name-field"
            placeholder="First Name"
            v-model="newFirstName"
          />
        </div>
        <div class="form-group">
          <input
            type="text"
            class="form-control"
            id="last-name-field"
            placeholder="Last Name"
            v-model="newLastName"
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
import { useVuelidate } from '@vuelidate/core'
import { required, email, alphaNum } from '@vuelidate/validators'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    return {
      authStore,
      v$: useVuelidate(),
    }
  },
  data() {
    return {
      newUsername: '',
      newPassword: '',
      newEmail: '',
      newFirstName: '',
      newLastName: ''
    }
  },
  validations: {
    newUsername: {
      required,
      alphaNum
    },
    newPassword: { required },
    newEmail: {
      required,
      email
    }
  },
  methods: {
    submitJoin() {
      if (this.v$.$invalid) {
        return
      }

      const formData = {
        username: this.username,
        password: this.password,
        email: this.email,
        first_name: this.firstName,
        last_name: this.lastName
      }
      this.authStore.createAndLogin(formData)
    }
  }
})
</script>

<style scoped>
.join-page {
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

.invalid {
  color: red;
  background-color: #ffc9aa;
  border: 1px solid red;
}
</style>
