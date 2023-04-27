<template>
  <div class="user-watchlist-section">
    <div class="user-watchlist-header">
      <h2>User Watchlist</h2>
    </div>
    <div class="user-watchlist-options">
      <div
        v-if="movies.length === 0"
        class="user-watchlist-empty"
      >
        <div>Save shows and movies to track what you want to watch</div>
      </div>
      <div
        v-for="(movie, index) in movies"
        class="user-watchlist-option"
        :key="index"
        :ref="'movie-' + index"
        @click="openMovie(movie.tmdb_movie_id)"
      >
        <img :src="url(movie.movie_poster_path)" />
        <div class="user-watchlist-option-title">{{ movie.movie_title }}</div>
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
      secureBaseUrl,
      posterSizes,
    }
  },
  props: {
    movies: Array
  },
  methods: {
    url(posterPath) {
      return this.secureBaseUrl + this.posterSizes[1] + posterPath
    },
    openMovie(id) {
      this.$router.push({ name: 'movie_path', params: { id: id }})
    }
  }
})
</script>

<style scoped>
.user-watchlist-section {
  width: 100%;
}

.user-watchlist-header {
  color: #FAFAFA;
  margin-top: 15px;
  padding-left: 25px;
  text-align: left;
}

.user-watchlist-empty {
  align-items: center;
  color: #FAFAFA;
  display: flex;
  font-size: 24px;
  font-weight: bold;
  height: 200px;
  margin: auto;
  vertical-align: middle;
}

.user-watchlist-options {
  width: 100%;
  display: inline-flex;
  overflow-x: scroll;
}

.user-watchlist-option {
  background-color: #FAFAFA;
  border: 1px solid black;
  border-radius: 10px;
  cursor: pointer;
  display: block;
  margin-left: 10px;
  margin-right: 10px;
  padding-top: 10px;
  width: 200px;
}

.user-watchlist-option-title {
  font-weight: bold;
}
</style>
