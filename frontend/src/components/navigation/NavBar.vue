<template>
  <div class="nav-bar">
    <div class="nav-bar-contents">
      <div class="nav-bar-left-nav">
        <div class="nav-bar-left-nav-option">
          <router-link :to="{ name: 'root_path', params: {} }">
            Movie Club
          </router-link>
        </div>
      </div>

      <div class="nav-bar-middle-nav">
        <input
          v-model="searchInput"
          class="search-input"
          type="text"
          placeholder="Search"
          v-on:keyup.enter="search"
        />
        <div
          class="search-button"
          @click="search"
        >
          Search
        </div>
      </div>

      <div class="nav-bar-right-nav">
        <a class="nav-bar-right-option" @click="openUserProfile">My Account</a>
        <a class="nav-bar-right-option" @click="logout">Sign Out</a>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import ClickOutside from "vue-click-outside";

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    const { id } = storeToRefs(authStore)

    return {
      authStore,
      id,
    }
  },
  data() {
    return {
      searchInput: "",
      showLogInMenu: false
    }
  },
  directives: {
    ClickOutside
  },
  methods: {
    openUserProfile() {
      this.$router.push({ name: 'user_profile_path', params: { id: this.id }})
    },
    search() {
      const query = this.searchInput
      this.searchInput = null
      this.$router.push({ name: "search_path", query: { query }})
    },
    logout() {
      this.authStore.logout()
    }
  }
})
</script>

<style scoped>
.nav-bar {
  height: 50px;
  white-space: nowrap;
  background-image: linear-gradient(#121212, #000);
}

.nav-bar-contents {
  height: 100%;
  width: 60%;
  margin-left: auto;
  margin-right: auto;
  display: inline-flex;
  align-items: center;
}

.nav-bar-left-nav {
  align-items: center;
  height: 100%;
}

.nav-bar-left-nav-option {
  background-color: #FAFAFA;
  border-radius: 15px;
  padding: 10px;
}

.nav-bar-left-nav-option a {
  color: #000;
  font-weight: bold;
}

.nav-bar-middle-nav {
  display: inline-flex;
  margin-left: 10%;
  margin-right: 10%;
  width: 65%;
}

.search-dropdown {
  color: #FAFAFA;
  display: inline-block;
  height: 100%;
  min-width: 80px;
  position: relative;
}

.nav-bar-right-nav {
  display: inline-flex;
}

.nav-bar-middle-nav a, .nav-bar-right-nav a {
  color: #FAFAFA !important;
  cursor: pointer;
}

.log-in-menu-wrapper {
  position: absolute;
  display: flex;
  flex-wrap: wrap;
  width: 200px;
  background: #fff;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.5);
  z-index: 1;
  right: 10px;
  top: 50px;
  padding: 5px;
}

.log-in-menu-wrapper input {
  margin: 2px;
}

.search-input {
  width: 16rem;
}

.search-button {
  border: 1px solid #FAFAFA;
  border-radius: 10px;
  color: #FAFAFA;
  cursor: pointer;
  margin-left: 15px;
  padding: 5px;
}

.nav-bar-right-option::before {
  display: inline-block;
  margin: 0 0.5rem 0.2rem;
  content: '';
  font-size: 1rem;
  line-height: 0.5rem;
  padding: 1px;
  border-radius: 50%;
  vertical-align: middle;
}
</style>
