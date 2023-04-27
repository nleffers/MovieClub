<template>
  <div class="user-profile-section user-profile-section-block">
    <div class="user-profile-section-header">
      <h2>Watch List</h2>
    </div>
    <div class="user-profile-section-container">
      <div
        v-for="(movie, index) in watchlist"
        :key="index"
        class="watchlist-movie"
        @onClick="openMovie(movie.tmdb_movie_id)"
      >
        <img :src="url(movie.movie_poster_path)" />
        <div class="movie-title">{{ movie.movie_title }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'
import { useUserStore } from '@/stores/user'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()
    const userStore = useUserStore()

    const { secureBaseUrl, posterSizes } = storeToRefs(staticStore)
    const { watchlist } = storeToRefs(userStore)

    return {
      watchlist,
      secureBaseUrl,
      posterSizes,
    }
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
.user-profile-section-container {
  width: 100%;
  display: inline-flex;
  overflow-x: scroll;
}

.watchlist-movie {
  background-color: #FAFAFA;
  border: 1px solid black;
  border-radius: 10px;
  cursor: pointer;
  display: inline-block;
  margin-left: 10px;
  margin-right: 10px;
  padding-top: 10px;
  width: 200px;
}

.watchlist-movie div {
  text-align: center;
}

.movie-title {
  text-overflow: ellipsis;
}
</style>
