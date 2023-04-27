<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>Photos</h2>
      <div>{{ imagesCount }}</div>
    </div>
    <div class="movie-page-section-options">
      <div
        v-for="(image, index) in movieImages"
        :key="index"
        :ref="'image-' + index"
        class="movie-page-section-option-image"
      >
        <img :src="getImageUrl(image)" />
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

    const { backdropSizes, logoSizes, posterSizes, secureBaseUrl } = storeToRefs(staticStore)
    const { images } = storeToRefs(movieStore)

    return {
      backdropSizes,
      secureBaseUrl,
      images,
      logoSizes,
      posterSizes,
    }
  },
  computed: {
    movieImages() {
      let array = []
      if (this.images.length === 0) { return array }
      this.images.backdrops.forEach(image => array.push({ ...image, source: 'backdrop' }))
      this.images.posters.forEach(image => array.push({ ...image, source: 'poster' }))
      this.images.logos.forEach(image => array.push({ ...image, source: 'logo' }))
      return array
    },
    imagesCount() {
      return this.movieImages.length
    },
  },
  methods: {
    getImageUrl(image) {
      if (image.file_path === null) { return null }

      if (image.source === 'backdrop') { return this.secureBaseUrl + this.backdropSizes[0] + image.file_path }
      else if (image.source === 'logo') { return this.secureBaseUrl + this.logoSizes[0] + image.file_path }
      else if (image.source === 'poster') { return this.secureBaseUrl + this.posterSizes[0] + image.file_path }
      else { return null }
    },
  }
})
</script>

<style scoped>
.movie-page-section-option-image {
  margin-left: 10px;
  margin-right: 10px;
}

.movie-page-section-option-image img {
  height: 200px;
}
</style>
