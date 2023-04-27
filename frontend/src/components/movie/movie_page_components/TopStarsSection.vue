<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>Top Cast</h2>
    </div>
    <div class="movie-page-cast-options">
      <div
        v-for="(person, index) in topStars"
        :key="index"
        :ref="'person-' + index"
        class="movie-page-cast-option"
        @click="openPersonPage(person)"
      >
        <img :src="getPersonUrl(person.profile_path)" />
        <div class="movie-page-cast-option-title-card">
          <div class="movie-page-cast-option-name">{{ person.name }}</div>
          <div class="movie-page-cast-option-character">as {{ person.character }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useMovieStore } from '@/stores/movie'
import { useStaticStore } from '@/stores/static'

export default defineComponent({
  setup() {
    const movieStore = useMovieStore()
    const staticStore = useStaticStore()

    const { cast, movie } = storeToRefs(movieStore)
    const { profileSizes, secureBaseUrl } = storeToRefs(staticStore)

    return {
      movie,
      cast,
      profileSizes,
      secureBaseUrl,
    }
  },
  computed: {
    topStars() {
      return this.cast.filter(person => person.profile_path).slice(0, 20)
    }
  },
  methods: {
    getPersonUrl(profilePath) {
      return this.secureBaseUrl + this.profileSizes[0] + profilePath
    },
    openPersonPage(person) {
      this.$router.push({ name: 'person_path', params: { id: person.id }})
    },
  }
})
</script>

<style scoped>
.movie-page-cast-options {
  display: inline-flex;
  flex-wrap: wrap;
  width: 80%;
}

.movie-page-cast-option {
  width: 50%;
  display: flex;
  text-align: left;
  vertical-align: middle;
  margin-top: 5px;
  margin-bottom: 5px;
  cursor: pointer;
}

.movie-page-cast-option img {
  border-radius: 50%;
  margin-right: 10px;
}

.movie-page-cast-option-title-card {
  display: flex;
  flex-direction: column;
  justify-content: center;
  overflow-x: hidden;
  text-overflow: ellipsis;
}

.movie-page-cast-option-name {
  font-weight: bold;
}
</style>
