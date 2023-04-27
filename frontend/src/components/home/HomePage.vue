<template>
  <div v-if="!loading" class="home-page">
    <featured-movie-section
      v-if="trendingMovies.length > 0"
      :movies="trendingMovies"
      @changeMovieManually="changeMovieManually($event)"
    />
    <home-page-section
      v-if="popularMovies.length > 0"
      headline="Popular"
      :movies="popularMovies"
    />
    <user-watchlist-section :movies="watchlist" />
    <home-page-section
      v-if="nowPlayingMovies.length > 0"
      headline="Now Playing"
      :movies="nowPlayingMovies"
    />
    <home-page-section
      v-if="upcomingMovies.length > 0"
      headline="Coming Soon"
      :movies="upcomingMovies"
    />
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import HomeService from '@/services/home.service'
import FeaturedMovieSection from './home_page_components/FeaturedMovieSection.vue'
import HomePageSection from './home_page_components/HomePageSection.vue'
import UserWatchlistSection from './home_page_components/UserWatchlistSection.vue'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()

    const { watchlist } = storeToRefs(authStore)

    return {
      watchlist,
    }
  },
  components: {
    FeaturedMovieSection,
    HomePageSection,
    UserWatchlistSection
  },
  data() {
    return {
      loading: true,
      trendingMovies: [],
      nowPlayingMovies: [],
      upcomingMovies: [],
      popularMovies: [],
      movieChangeTimer: setInterval(this.changeTrendingMovies, 8000)
    }
  },
  created() {
    this.getHomePage()
  },
  unmounted() {
    clearInterval(this.movieChangeTimer)
  },
  methods: {
    getHomePage() {
      HomeService.getHomePage()
        .then(response => {
          this.trendingMovies = response.data.trending
          this.nowPlayingMovies = response.data.now_playing
          this.popularMovies = response.data.popular
          this.upcomingMovies = response.data.upcoming
        })
        .catch(err => console.log(err))
      this.loading = false
    },
    changeTrendingMovies() {
      this.trendingMovies.push(this.trendingMovies.shift())
    },
    changeMovieManually(value) {
      while (this.trendingMovies[0].id !== value) {
        this.changeTrendingMovies()
      }
      clearInterval(this.movieChangeTimer)
      this.movieChangeTimer = setInterval(this.changeTrendingMovies, 8000)
    }
  }
})
</script>

<style scoped>
.home-page {
  margin-top: 20px;
}
</style>
