<template>
  <div id="app">
    <nav-bar v-if="isLoggedIn" />
    <vue-snotify />
    <div class="container-fluid">
      <router-view />
      <vue-progress-bar />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useAuthStore } from './stores/auth'
import NavBar from './components/navigation/NavBar.vue'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    return {
      authStore,
    }
  },
  components: {
    NavBar
  },
  computed: {
    isLoggedIn() {
      return this.authStore.isLoggedIn
    }
  },
  mounted() {
    this.$Progress.finish()
  },
  created() {
    this.$Progress.start()
    this.$router.beforeEach((to, _from, next) => {
      if (to.meta.progress !== undefined) {
        let meta = to.meta.progress
        this.$Progres.parseMeta(meta)
      }
      this.$Progress.start()
      next()
    })
    this.$router.afterEach(() => {
      this.$Progress.finish()
    })
  },
})
</script>

<style>
html, #app {
  min-height: 100vh;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  background-color: #000;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.container-fluid {
  margin: auto;
  width: 60% !important;
  min-width: 1000px;
}
</style>
