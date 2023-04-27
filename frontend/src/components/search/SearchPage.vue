<template>
  <div class="search-wrapper">
    <div class="search-wrapper-header">
      <p>Displaying {{ totalMovies }} results for "{{ query }}"</p>
    </div>
    <div class="search-wrapper-results">
      <p>Titles</p>
      <div
        v-for="(movie, index) in movies"
        :key="index"
        :ref="'movie-' + index"
        class="search-result"
      >
        <img :src="getImageUrl(movie)" @click="openMoviePage(movie)" />
        <div class="search-result-card">
          <span
            class="title"
            @click="openMoviePage(movie)"
          >{{ movie.title }}</span> ({{ movie.release_date.substring(0, 4) }})
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'
import SearchService from "@/services/search.service";

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()

    const { posterSizes, secureBaseUrl } = storeToRefs(staticStore)

    return {
      posterSizes,
      secureBaseUrl,
    }
  },
  props: {
    query: String
  },
  data() {
    return {
      movies: []
    }
  },
  computed: {
    totalMovies() {
      return this.movies.length
    },
  },
  mounted() {
    SearchService.searchMovies(this.query)
      .then(response => this.movies = response.data.results)
      .catch(err => console.log(err))
  },
  methods: {
    getImageUrl(movie) {
      return this.secureBaseUrl + this.posterSizes[0] + movie.poster_path
    },
    openMoviePage(movie) {
      this.$router.push({ name: 'movie_path', params: { id: movie.id }})
    }
  }
})
</script>

<style scoped>
.search-wrapper {
  background-color: #080808;
  color: #FAFAFA;
  display: inline-block;
  margin: 20px;
  border: 1px solid #FAFAFA;
  border-radius: 10px;
  padding: 20px;
}

.search-wrapper-header p {
  text-align: left;
  font-weight: bold;
  font-size: 24px;
}

.search-wrapper-results {
  display: inline-block;
}

.search-wrapper-results p {
  font-size: 20px;
  text-align: left;
}

.search-result {
  background-color: #111;
  display: inline-flex;
  padding: 5px;
  width: 100%;
}

.search-result:nth-child(even) {
  background-color: #222;
}

.search-result-card {
  margin-top: auto;
  margin-bottom: auto;
  margin-left: 25px;
}

img {
  cursor: pointer;
}

.title {
  cursor: pointer;
}
</style>
