<template>
  <BaseModal>
    <template v-slot:header>
      The Movie Database API Authentication
    </template>
    <template v-slot:body>
      <iframe
        :src="iframeUrl"
        class='iframe-wrapper'
        frameborder="0"
      />
    </template>
  </BaseModal>
</template>

<script>
import { defineComponent } from 'vue'
import BaseModal from './BaseModal'

export default defineComponent({
  props: {
    requestToken: String
  },
  components: {
    BaseModal
  },
  data() {
    return {
      url: "https://www.themoviedb.org/authenticate/"
    }
  },
  computed: {
    iframeUrl() {
      return this.url + this.requestToken
    }
  },
  created() {
    window.addEventListener('message', this.emitAuthenticatedRequestToken)
  },
  beforeUnmount() {
    window.removeEventListener('message', this.emitAuthenticatedRequestToken)
  },
  methods: {
    emitAuthenticatedRequestToken() {
      // this.$emit('postSessionId')
    },
  }
})
</script>
