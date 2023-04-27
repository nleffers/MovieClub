<template>
  <div class="movie-row-wrapper">
    <router-link :to="{ name: 'movie_path', params: { id: movie.id } }">
      <div class="movie-row">
        <div class="movie-poster">
          <template v-if="movie.poster_path">
            <img :src="baseUrl + movie.poster_path" alt="Poster">
          </template>
          <template v-else>
            No Poster Available
          </template>
        </div>
        <div class="movie-row-info">
          <div id="movie-title">
            {{ movie.title }}
          </div>
          <div id="movie-year">
            {{ movie.release_date | releaseYear }}
          </div>
          <div id="movie-average-rating">
            Average Rating: {{ movie.vote_average }}
          </div>
          <template v-if="isLoggedIn">
            <div id="movie-user-rating">
              User Rating: {{ rating }}
            </div>
          </template>
        </div>
      </div>
    </router-link>
    <hr>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useStaticStore } from '@/stores/static'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const staticStore = useStaticStore()

    const { isLoggedIn } = storeToRefs(authStore)
    const { posterSizes, secureBaseUrl } = storeToRefs(staticStore)

    return {
      isLoggedIn,
      posterSizes,
      secureBaseUrl,
    }
  },
  props: {
    movie: Object
  },
  computed: {
    baseUrl() {
      return this.secureBaseUrl + this.posterSizes[1]
    },
    rating() {
      return this.movie && this.movie.user_rating.substring(0, 4) || 'N/A'
    }
  },
})
</script>

<style scoped>
.movie-poster {
  display: inline-block;
  text-align: right;
  width: 30%;
}

.movie-row-info {
  display: inline-block;
  text-align: left;
  padding-left: 25px;
  width: 70%;
}
</style>
