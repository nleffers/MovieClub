<template>
  <div class="user-account">
    <div class="col-md-10 offset-md-1">
      <form @submit.prevent="submitJoin">
        <div class="form-group justify-content-center">
          <label for="username-field">Username</label>
          <input
            :class="{ invalid: v$.username.$invalid }"
            type="text"
            class="form-control"
            id="username-field"
            placeholder="Username"
            v-model="username"
          />
        </div>
        <div class="form-group">
          <label for="email-field">Email</label>
          <input
            :class="{ invalid: v$.email.$invalid }"
            type="text"
            class="form-control"
            id="email-field"
            placeholder="Email"
            v-model="email"
          />
        </div>
        <div class="form-group">
          <label for="first-name-field">First Name</label>
          <input
            type="text"
            class="form-control"
            id="first-name-field"
            placeholder="First Name"
            v-model="firstName"
          />
        </div>
        <div class="form-group">
          <label for="last-name-field">Last Name</label>
          <input
            type="text"
            class="form-control"
            id="last-name-field"
            placeholder="Last Name"
            v-model="lastName"
          />
        </div>
        <div class="form-group">
          <button
            type="submit"
            class="btn btn-primary"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useVuelidate } from '@vuelidate/core'
import { required, email, alpha } from '@vuelidate/validators'

import UserService from '@/services/user.service'
import { useAuthStore } from '@/stores/auth'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    const { id } = storeToRefs(authStore)

    return {
      v$: useVuelidate(),
      authStore,
      id,
    }
  },
  data() {
    return {
      username: '',
      email: '',
      firstName:'',
      lastName: ''
    }
  },
  validations: {
    username: {
      required,
      alpha
    },
    password: { required },
    email: {
      required,
      email
    }
  },
  created() {
    this.getUser()
  },
  computed: {
    currentUserId() {
      return this.id
    }
  },
  methods: {
    getUser() {
      UserService.get(this.currentUserId)
        .then(response => {
          this.username = response.data.username
          this.email = response.data.email
          this.firstName = response.data.first_name
          this.lastName = response.data.last_name
        })
        .catch(err => console.log(err))
    },
    editUserField(value, method) {
      this.authStore[method](value)
    },
    submitJoin() {
      if (this.v$.$invalid) {
        return
      }

      const formData = {
        id: this.id,
        username: this.username,
        email: this.email,
        first_name: this.firstName,
        last_name: this.lastName
      }
      this.authStore.updateUser(formData)
    }
  }
})
</script>

<style scoped>
.user-account {
  margin: auto;
  width: 80%;
}

.form-group {
  display: inline;
}

.form-group label {
  clear: both;
  float: left;
  margin-right: 15px;
  margin-top: 7px;
}

.form-group input {
  float: right;
  margin-top: 1px;
  width: 85%;
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
