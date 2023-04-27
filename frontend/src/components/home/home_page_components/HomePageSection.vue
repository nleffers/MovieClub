<template>
  <div class="home-page-section">
    <div class="home-page-section-header">
      <h2>{{ headline }}</h2>
    </div>
    <div class="home-page-section-options">
      <div
        v-for="(movie, index) in movies"
        class="home-page-section-option"
        :key="index"
        :ref="'movie-' + index"
        @click="openMovie(movie.id)"
      >
        <img :src="baseUrl + movie.poster_path" />
        <div class="home-page-section-title">{{ movie.title }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()

    const { secureBaseUrl, posterSizes } = storeToRefs(staticStore)

    return {
      posterSizes,
      secureBaseUrl,
    }
  },
  props: {
    headline: String,
    movies: Array
  },
  computed: {
    baseUrl() {
      return this.secureBaseUrl + this.posterSizes[1]
    }
  },
  methods: {
    openMovie(id) {
      this.$router.push({ name: 'movie_path', params: { id: id }})
    }
  }
})
</script>

<style scoped>
.home-page-section {
  width: 100%;
}

.home-page-section-header {
  color: #FAFAFA;
  margin-top: 15px;
  padding-left: 25px;
  text-align: left;
}

.home-page-section-options {
  width: 100%;
  display: inline-flex;
  overflow-x: scroll;
}

.home-page-section-option {
  background-color: #FAFAFA;
  border: 1px solid black;
  border-radius: 10px;
  cursor: pointer;
  display: block;
  margin-left: 10px;
  margin-right: 10px;
  min-width: 200px;
  padding-top: 10px;
}

.home-page-section-title {
  font-weight: bold;
}
</style>
