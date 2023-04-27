<template>
  <div v-if="person" class="person-page-container">
    <div class="person-page-section">
      <div class="person-page-section-header">
        <div class="person-page-name">{{ person.name }}</div>
        <div class="person-page-known-for"><span class="bold">Known for</span> {{ person.known_for_department }}</div>
      </div>
      <div class="person-page-main-body">
        <div class="person-page-headshot">
          <img :src="profileImagePath" />
        </div>
        <div class="person-page-bio">
          <div class="person-page-biography">{{ person.biography }}</div>
          <div class="person-page-birth-info"><span class="bold">Born:</span> {{ person.birthday }} in {{ person.place_of_birth }}</div>
        </div>
      </div>
    </div>
    <div class="person-page-section">
      <div class="person-page-section-header">Photo Gallery</div>
      <div class="gallery">
        <div
          v-for="(image, index) in images"
          :key="index"
          :ref="'image-' + index"
          class="gallery-image"
        >
          <img :src="getImageUrl(image)" />
        </div>
      </div>
    </div>
    <div class="person-page-section">
      <div class="person-page-section-header">Filmography</div>
      <div class="filmography">
        <div class="filmography-header">Acting</div>
        <div
          v-for="(role, index) in movieCredits.cast"
          :key="index + role.id"
          :ref="'cast-' + index"
          class="role-card"
        >
          <div class="movie-role-info">
            <div class="role-title" @click="openMoviePage(role)">{{ role.original_title }}</div>
            <div class="role-name">{{ role.character }}</div>
          </div>
          <div class="movie-year">{{ role.release_date.substring(0, 4) }}</div>
        </div>
        <hr />
        <div class="filmography-header">Crew</div>
        <div
          v-for="(role, index) in movieCredits.crew"
          :key="index + role.id"
          :ref="'crew-' + index"
          class="role-card"
        >
          <div class="movie-role-info">
            <div class="role-title" @click="openMoviePage(role)">{{ role.original_title }}</div>
            <div class="role-name">{{ role.job }}</div>
          </div>
          <div class="movie-year">{{ role.release_date.substring(0, 4) }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'
import PersonService from '@/services/person.service'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()

    const { profileSizes, secureBaseUrl } = storeToRefs(staticStore)

    return {
      profileSizes,
      secureBaseUrl,
    }
  },
  props: {
    id: Number
  },
  data() {
    return {
      person: null,
      images: [],
      movieCredits: []
    }
  },
  computed: {
    profileImagePath() {
      if (!this.person) { return null }

      return this.secureBaseUrl + this.profileSizes[2] + this.person.profile_path
    }
  },
  created() {
    this.getPerson()
  },
  methods: {
    getPerson() {
      PersonService.get(this.id)
        .then(res => {
          this.person = res.data
          this.images = this.person.images
          this.movieCredits = this.person.movie_credits
        })
        .catch(e => console.log(e))
    },
    getImageUrl(image) {
      return this.baseUrl + this.profileSizes[1] + image.file_path
    },
    openMoviePage(role) {
      this.$router.push({ name: 'movie_path', params: { id: role.id }})
    }
  }
})
</script>

<style scoped>
.person-page-container {
  color: #FAFAFA;
  margin-top: 20px;
}

.person-page-section {
  width: 90%;
  display: inline-block;
  border: 1px solid #FAFAFA;
  border-radius: 10px;
  padding: 20px;
  margin: 5px;
}

.person-page-section-header {
  font-size: 20px;
  font-weight: bold;
  text-align: left;
  width: 100%;
  padding: 10px;
  padding-top: 0;
}

.person-page-name {
  font-size: 27px;
}

.person-page-known-for {
  font-size: 11px;
  font-weight: normal;
  margin: 4px 0;
}

.person-page-main-body {
  display: inline-flex;
}

.person-page-bio {
  padding: 25px;
  text-align: left;
}

.person-page-biography {
  display: -webkit-box;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
  overflow: hidden;
  max-width: 100%;
  margin-bottom: 10px;
}

.person-page-birth-info {
  margin-top: 10px;
  font-size: 14px;
}

.gallery {
  display: inline-flex;
  overflow-x: scroll;
  width: 100%;
}

.gallery-image {
  margin: 10px;
}

.filmography {
  display: inline-block;
  width: 90%;
  margin: auto;
}

.filmography-header {
  width: 100%;
  text-align: left;
  padding: 5px;
}

.role-card {
  display: inline-flex;
  width: 100%;
  padding: 5px;
  background-color: #111;
}

.role-card:nth-child(even) {
  background-color: #222;
}

.movie-role-info {
  display: inline-block;
  text-align: left;
  width: 100%;
}

.role-title {
  cursor: pointer;
  font-weight: bold;
}
</style>
