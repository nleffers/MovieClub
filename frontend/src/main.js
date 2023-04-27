import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import App from './App.vue'

import axios from 'axios'
import VueAxios from 'vue-axios'
import VueProgressBar from "@aacassandra/vue3-progressbar"
import snotify from 'vue3-snotify'
import piniaPluginPersistedState from 'pinia-plugin-persistedstate'

import 'vue3-snotify/style'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'

const progressBarOptions = {
  color: "#BFFAF3",
  failedColor: "#874B4B",
  thickness: "5px",
  transition: {
    speed: "0.2s",
    opacity: "0.6s",
    termination: 300,
  },
  autoRevert: true,
  location: "top",
  inverse: false,
}

const app = createApp(App)
const pinia = createPinia()
pinia.use(piniaPluginPersistedState)

app.use(VueAxios, axios)
app.use(pinia)
app.use(router)
app.provide('axios', app.config.globalProperties.axios)
app.use(VueProgressBar, progressBarOptions)
app.use(snotify)
app.mount('#app')
